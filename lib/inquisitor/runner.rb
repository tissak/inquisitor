module Inquisitor
  class Runner
    attr_accessor :root_path, :collections

    def initialize(dir=".")
      @root_path = File.expand_path(dir)
    end

    def run
      files = self.find_gemfiles
      @collections = self.check_gemfile(files)
    end

    def find_gemfiles
      Dir.entries(@root_path).collect do |p|
        path = File.join(@root_path, p)
        if File.directory?(path) && ![".",".."].include?(path)
          Inquisitor::GemfileFinder.gemfile_path(path)
        end
      end.compact
    end

    def check_gemfile(files)
      puts "Files found: "
      puts files.join("\n")
      files.collect do |file|
        gem_collection = Inquisitor::GemCollection.new(file)
        file_content = File.read(file)
        unless file_content.nil?
          # As we aren't running bundler in the folders with the gemfile help
          # bundler refer to the Gemfile path by setting it manually via the env
          ENV['BUNDLE_GEMFILE'] = file.gsub(".lock","")
          lock_file = Bundler::LockfileParser.new(file_content)

          lock_file.specs.collect do |s|
            latest_version = Gem.latest_version_for(s.name)
            cv = s.version.nil? ? 'unknown' : s.version.version
            lv = latest_version.nil? ? 'unknown' : latest_version.version
            gem_collection.add_gem(s.name, s.version.version, lv)
          end
        end

        gem_collection
      end
    end
  end
end

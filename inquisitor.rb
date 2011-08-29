require 'rubygems'
require 'bundler'

["lib/gem_collection.rb",
 "lib/gem_entry.rb",
 "lib/gemfile_finder.rb",
 "lib/runner.rb"].each {|f| require f }

module Inquisitor
  def self.run(dir=".")
    @runner = Inquisitor::Runner.new(dir)
    @runner.run
  end

  def self.run_outdated_report(dir=".")
    collections = self.run(dir)
    collections.collect { |c| c.outdated_gems.as_hash }
  end

  def self.run_outdated_report_dump(dir, filename)
    hsh = self.run_outdated_report(dir)
    File.open(filename,"w") do |file|
      hsh.each do |entry|
        file.write "#{entry[:file]}\n"
        entry[:gems].each do |gem|
          file.write "- #{gem[:name]} #{gem[:current]} > #{gem[:new]}\n"
        end
        file.write "\n"
      end
    end
  end
end

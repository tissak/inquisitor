require 'rubygems'
require 'bundler'

["inquisitor/gem_collection.rb",
 "inquisitor/gem_entry.rb",
 "inquisitor/gemfile_finder.rb",
 "inquisitor/runner.rb"].each {|f| require f }

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


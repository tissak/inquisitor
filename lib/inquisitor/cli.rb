require 'thor'
require 'inquisitor'
require 'json'
module Inquisitor
  class CLI < Thor
    desc "report DIRECTORY", "Output a report"
    def report(dir)
      puts Inquisitor.run_outdated_report(dir).to_json
    end

    desc "dump_outdated DIRECTORY FILE", "Output report to a file"
    def dump_outdated(dir, file)
      Inquisitor.run_outdated_report_dump(dir, file)
      puts "Done"
    end
  end
end

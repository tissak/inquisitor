require "spec_helper"

describe Inquisitor::GemfileFinder do
  describe ".probe" do
    it "should determine if a file is present" do
      # use the gems own lockfile for this test
      path = File.expand_path(File.join(__FILE__,"..","..",".."))
      Inquisitor::GemfileFinder.probe(path).should be_true
    end

    it "should return false if no lockfile found" do
      path = File.expand_path(File.join(__FILE__,"."))
      Inquisitor::GemfileFinder.probe(path).should be_false
    end
  end

  describe ".to_full_path" do
    it "should tack on gemfile.lock to the path" do
      Inquisitor::GemfileFinder.to_full_path(".").should == "./Gemfile.lock"
    end

    it "should join on gemfile.lock to the path correctly" do
      Inquisitor::GemfileFinder.to_full_path("./").should == "./Gemfile.lock"
    end
  end
end

require 'spec_helper'

describe Inquisitor::GemEntry do
  before :each do
    @ge = Inquisitor::GemEntry.new("rake", 1, 2)
  end

  context "#outdated?" do
    it "should report true if gem has higher new version" do
      @ge = Inquisitor::GemEntry.new("rake", 1, 2)
      @ge.outdated?.should be_true
    end

    it "should report false if gem has lower new version" do
      @ge = Inquisitor::GemEntry.new("rake", 2, 1)
      @ge.outdated?.should be_false
    end

    it "should report true if gem has unknown new version" do
      @ge = Inquisitor::GemEntry.new("rake", 2, "unknown")
      @ge.outdated?.should be_true
    end

    it "should report true if gem has unknown current version" do
      @ge = Inquisitor::GemEntry.new("rake", "unknown", 1)
      @ge.outdated?.should be_true
    end
  end

  context "#as_hash" do
    it "should convert to a hash" do
      @ge = Inquisitor::GemEntry.new("rake", 0.5, 1)
      hsh = @ge.as_hash
      hsh[:name].should =="rake"
      hsh[:current].should == 0.5
      hsh[:new].should == 1
      hsh[:outdated].should == true
    end
  end
end

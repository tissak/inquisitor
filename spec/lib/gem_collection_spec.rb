require 'spec_helper'

describe Inquisitor::GemCollection do
  context "without specified gems" do
    before :each do
      @gc = Inquisitor::GemCollection.new("../Gemfile")
    end

    context "the attributes" do
      it 'should hold the gemfile name' do
        @gc.gemfile.should == "../Gemfile"
      end

      it 'should start with no gems' do
        @gc.gems.should be_empty
      end
    end

    describe "#add_gem" do
      it "should add to the internal gems list" do
        @gc.add_gem("rake", "1", "2")
        @gc.gems.length.should == 1
        @gc.gems.first.name.should == "rake"
      end
    end

    describe "#as_hash" do
      it "should return a hash" do
        hsh = @gc.as_hash
        hsh[:file].should == "../Gemfile"
        hsh[:gems].should be_empty
      end
      
      it "should return a hash with gems" do
        @gc.add_gem("rake", "1", "2")
        hsh = @gc.as_hash
        hsh[:file].should == "../Gemfile"
        hsh[:gems].length.should == 1
        hsh[:gems].first[:name].should == "rake"
      end
    end

    describe "#outdated_gems" do
      it "should return gems with current higher version" do
        @gc.add_gem("rake", "1", "2")
        @gc.add_gem("bundler", "2.1", "2")
        @gc.add_gem("rails", "1.9", "2.5")
        result = @gc.outdated_gems
        result.gems.length.should == 2
        result.gems.first.name.should == "rake"
        result.gems.last.name.should == "rails"
      end

      it "should return gems with current unkown version" do
        @gc.add_gem("rake", "1", "unknown")
        @gc.add_gem("bundler", "2.1", "2")
        @gc.add_gem("rails", "unknown", "2.5")
        result = @gc.outdated_gems
        result.gems.length.should == 2
        result.gems.first.name.should == "rake"
        result.gems.last.name.should == "rails"
      end

    end
  end
end

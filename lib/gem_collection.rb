module Inquisitor
  class GemCollection
    attr_accessor :gems, :gemfile

    def initialize(gemfile, gems=[])
      @gemfile = gemfile
      @gems = gems
    end

    def add_gem(gemname, current_version, new_version)
      self.gems << GemEntry.new(gemname, current_version, new_version)
    end

    def as_hash
      gem_hash = self.gems.collect {|g| g.as_hash }
      { :file=>gemfile, :gems=>gem_hash }
    end

    def outdated_gems
      gems = self.gems.select { |gem| gem.outdated? }
      Inquisitor::GemCollection.new(@gemfile, gems)
    end
  end
end

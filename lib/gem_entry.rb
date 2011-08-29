module Inquisitor
  class GemEntry
    attr_accessor :name, :current_version, :new_version

    def initialize(name, current_version, new_version)
      @name = name
      @current_version = current_version 
      @new_version = new_version
    end

    def outdated?
      @new_version > @current_version
    end

    def as_hash
      {:name=>@name, :current=>@current_version, :new=>@new_version, :outdated=>self.outdated?}
    end
  end
end

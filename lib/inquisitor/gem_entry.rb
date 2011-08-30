module Inquisitor
  class GemEntry
    attr_accessor :name, :current_version, :new_version

    def initialize(name, current_version, new_version)
      @name = name
      @current_version = current_version 
      @new_version = new_version
    end

    def outdated?
      # if either version state is unknown, return it's out of date to be safe
      return true if (@new_version=="unknown" || @current_version=="unknown")
      @new_version > @current_version
    end

    def as_hash
      {:name=>@name, :current=>@current_version, :new=>@new_version, :outdated=>self.outdated?}
    end
  end
end

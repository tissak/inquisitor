module Inquisitor
  class GemfileFinder
    def self.gemfile_path(base_path)
      return self.to_full_path(base_path) if self.probe(base_path)

      # check to see if we have any capistrano looking pathsd
      cap_symlink = File.join(base_path, "current")
      if File.exist?(cap_symlink)
       if File.directory?(cap_symlink)
          # it's not a cap symlink..its actually a folder
          return self.to_full_path(cap_symlink) if self.probe(cap_symlink)
        else
          # its a cap symlink so follow it
          symlinked_path = File.readlink(cap_symlink)
          return self.to_full_path(symlinked_path) if self.probe(symlinked_path)
        end
      end
      # else we have nothing
      nil
    end

    def self.probe(path)
      File.exist?(self.to_full_path(path))
    end

    def self.to_full_path(path)
      File.join(path,"Gemfile.lock")
    end
  end
end

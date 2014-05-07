# Interface for interacting with the defaults system (NSUserDefaults) using BubbleWrap
# The defaults system allows an application to customize its behavior to match a user’s preferences
# Notice: only PRIMITIVES here
class Preferences

  class << self
    def exists?(key)
      !App::Persistence[key].nil?
    end

    # "Read" objects
    def decode(key)
      NSKeyedUnarchiver.unarchiveObjectWithData(read(key))
    end

    # "Write" objects
    def encode(key, value)
      post_as_data = NSKeyedArchiver.archivedDataWithRootObject(value)
      write(key, post_as_data)
    end

    def write(key, value)
      App::Persistence[key] = value
    end

    def read(key)
      App::Persistence[key]
    end

    def delete(key)
      App::Persistence.delete(key)
    end
  end
end
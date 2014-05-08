# Interface for persisting data using BubbleWrap
# Notice: NSUserDefaults allows the persistence of primitives only
# In order to store objects, it was used NSKeyedArchiver/Unarchiver
class Persistence

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
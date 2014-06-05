class Token < CDQManagedObject
  def self.value
    first.value
  end
end

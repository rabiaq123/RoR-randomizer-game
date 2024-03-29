class RandomizerContainer
  attr_accessor :randomizers

  def store(randomizer) # stores a randomizer in the container, returns self (for method chaining)
    @randomizers << randomizer
    return self
  end

  def store_all(randomizers) # stores all randomizers in the container, returns self (for method chaining)
    @randomizers.concat(randomizers)
    return self
  end

  def count # returns the number of all randomizers stored in itself
    return @randomizers.length
  end

  def move_all(randomizer_container) # remove each randomizer in container and store in self, returns self (for method chaining)
    @randomizers.concat(randomizer_container.randomizers)
    randomizer_container.randomizers = []
    return self
  end

  def empty # abstract method to remove all members from the container; will be overriden in subclasses
    return self
  end

  def select(description, amt = :all) # returns a Hand object that holds up to 'amt' selected items
    hand = Hand.new

    # if all items are desired, the symbol :all will be supplied instead of a number
    amt = @randomizers.length if amt == :all
    # selects items based on the description provided
    # if no description provided, delete any 'amt' randomizers from the container
    @randomizers.delete_if do |randomizer|
      if description <= randomizer.description && amt != 0 # if description is a subset of randomizer.description
        hand.store(randomizer)
        amt -= 1
        true # remove the randomizer from the array
      end
    end

    return hand
  end
end

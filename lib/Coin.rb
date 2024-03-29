class Coin < Randomizer
  attr_accessor :denomination

  DENOMINATION = {
    nickel: 0.05,
    dime: 0.10,
    quarter: 0.25,
    dollar: 1,
    toonie: 2
  }

  def initialize(denomination)
    @denomination = (denomination if DENOMINATION.has_value?(denomination))
    @sides = 2 # default for coin
    @up = nil
    @num_randomizations = 0
    @item = :coin
  end

  def denomination() # returns the denomination of the coin (does not set it)
    return @denomination
  end

  def flip # flips the coin, returns self, is a synonym for randomize()
    randomize
    return self
  end

  def sideup # returns :H or :T (the result of the last flip) or nil (if no flips yet done), is a synonym for result()
    return result
  end

  def description # HELPER: get Coin instance description
    description = super # get default description from parent class
    description[:denomination] = @denomination
    return description
  end
end

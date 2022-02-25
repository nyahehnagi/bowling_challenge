class Frame
TEN_PINS = 10

  def initialize
    @rolls = {}
    @frame_score = 0
  end

  def log_roll(pins_downed)
    raise "Pins downed must be between 0 and 10" if invalid_pins?(pins_downed)
    #raise "Pins downed must be between 0 and #{pins_remaining}" if to_many_pins_downed?(pins_downed)
    @frame_score += pins_downed
    @rolls[@rolls.count + 1] = calculate_score(pins_downed)

  end

  def roll_score(roll)
    @rolls[roll]
  end

  def frame_complete?
    @rolls.count > 1 || roll_score(1) == :strike
  end

  private

  def invalid_pins?(pins_downed)
    return pins_downed < 0 || pins_downed > 10 
  end

  def to_many_pins_downed?(pins_downed)
    @frame_score - pins_downed < 0
  end

  # def pins_remaining
  #   TEN_PINS - @frame_score
  # end

  def calculate_score (pins_downed) 
 
    pins_downed = :strike if strike?(pins_downed) 
    pins_downed = :spare if spare?(pins_downed)

    pins_downed
  end

  def strike?(pins_downed) 
    return true if pins_downed == 10 && @rolls.empty?
    return true if pins_downed == 10 && @rolls[1] == :strike
    return true if pins_downed == 10 && @rolls[2] == :strike
    false
  end

  def spare?(pins_downed)
    return false if pins_downed == :strike
    @frame_score == 10 && @rolls[1] < 10
  end


end
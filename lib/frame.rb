class Frame
TEN_PINS = 10
FIRST_ROLL = 1
SECOND_ROLL = 2
LAST_ROLL = 3

  def initialize
    @rolls = {}
    @frame_total = 0
    @frame_type = nil
  end

  def log_roll(pins_downed)
    raise "Pins downed must be between 0 and 10" if invalid_pins?(pins_downed)
    process_roll(pins_downed)
    p @rolls
    p @frame_type
  end

  def roll_score(roll)
    @rolls[roll]
  end

  def frame_complete?
    @rolls.count > 1 || @frame_type == :strike
  end


  def strike_frame?
    @frame_type == :strike
  end

  def spare_frame?
    @frame_type == :spare
  end

  private

  def invalid_pins?(pins_downed)
    return pins_downed < 0 || pins_downed > 10 
  end

  def to_many_pins_downed?(pins_downed)
    @frame_total - pins_downed < 0
  end

  def process_roll(pins_downed)
    process_frame_type(pins_downed)
    process_final_roll(pins_downed)
    process_second_roll(pins_downed)
    process_first_roll(pins_downed)
  end

  def process_first_roll(pins_downed)
    return unless first_roll?
    @rolls[FIRST_ROLL] = pins_downed
  end

  def process_second_roll(pins_downed)
    return unless second_roll?
    @rolls[SECOND_ROLL] = pins_downed
  end

  def process_final_roll(pins_downed)
    return unless last_roll?
    @rolls[LAST_ROLL] = pins_downed
  end

  def process_frame_type(pins_downed)
    return unless @frame_type.nil?
    @frame_type = :strike if pins_downed == TEN_PINS && first_roll?
    @frame_type = :spare if second_roll? && pins_downed + @rolls[FIRST_ROLL] == TEN_PINS
    @frame_type = :open_frame if second_roll? && pins_downed + @rolls[FIRST_ROLL] != TEN_PINS
  end

  def last_roll?
    return false if second_roll? 
    return false if first_roll?
    @rolls[LAST_ROLL].nil?
  end

  def second_roll?
    return false if first_roll?
    @rolls[SECOND_ROLL].nil?
  end

  def first_roll?
    @rolls.empty?
  end

end
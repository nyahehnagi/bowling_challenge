require 'frame'

class ScoreCard

FIRST_ROLL = 1
SECOND_ROLL = 2
FINAL_ROLL = 3
LAST_FRAME = 10
TEN_PINS_DOWN = 10

  def initialize(frame_class = Frame)
    @frame_class = frame_class
    @frames = {}
  end

  def current_frame_number
    @frames.count
  end

  def log_roll(pins_downed)
    current_frame.log_roll(pins_downed)
  end

  def score()
    score = 0 
    @frames.each do |frame_no, frame|
      if frame_no == LAST_FRAME
        score += process_frame(frame_no, frame)
      elsif frame.frame_complete?
        score += process_frame(frame_no, frame)
      end
    end
    score
  end

private

  def process_frame(frame_no, frame)
    if strike?(frame.roll_score(FIRST_ROLL))
      return strike_points(frame_no)
    elsif spare?(frame.roll_score(SECOND_ROLL))
      return spare_points(frame_no)
    else
      return frame.roll_score(FIRST_ROLL).to_i + frame.roll_score(2).to_i
    end
  end

  def current_frame()
    if new_frame?
      @frames[@frames.count + 1] = @frame_class.new
    end

    @frames[@frames.keys.last]

  end

  def new_frame?
    return true if @frames.empty?
    return false if @frames.count == LAST_FRAME
    return true if @frames[@frames.keys.last].frame_complete?
    return false
  end

  def spare?(roll)
    roll == :spare 
  end

  def strike?(roll)
    roll == :strike
  end

  def strike_points(frame_no)
    if frame_no == LAST_FRAME
      last_frame = @frames[frame_no]
      return 10 + roll_to_int(last_frame.roll_score(SECOND_ROLL), frame_no) + roll_to_int(last_frame.roll_score(FINAL_ROLL), frame_no)
    end

    if @frames.key?(frame_no + 1)
      next_frame = @frames[frame_no + 1]
      # 2 rolls for this frame?
      if (next_frame.roll_score(SECOND_ROLL))
          return 10 + roll_to_int(next_frame.roll_score(FIRST_ROLL),frame_no + 1) + roll_to_int(next_frame.roll_score(2), frame_no + 1)
      else
        # Look ahead 2 frames ahead
        if @frames.key?(frame_no + 2)
          return 10 + roll_to_int(next_frame.roll_score(FIRST_ROLL), frame_no + 1) + roll_to_int(@frames[frame_no + 2].roll_score(FIRST_ROLL), frame_no + 2) 
        end
      end
    end
    # Nothing to match on.. 
    return 0 
  end

  def spare_points(frame_no)
    if frame_no == LAST_FRAME
      last_frame = @frames[frame_no]
      return roll_to_int(last_frame.roll_score(FINAL_ROLL), frame_no) + TEN_PINS_DOWN 
    else
      @frames.key?(frame_no + 1) ? roll_to_int(@frames[frame_no + 1].roll_score(FIRST_ROLL), frame_no) + TEN_PINS_DOWN : 0
    end
  end

  def roll_to_int(roll, frame_no)
    case roll
    when :strike 
      return TEN_PINS_DOWN
    when :spare 
      return TEN_PINS_DOWN - @frames[frame_no].roll_score(FIRST_ROLL)
    else
      return roll
    end
  end

end
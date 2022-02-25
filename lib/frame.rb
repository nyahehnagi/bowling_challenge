class Frame

  def initialize
    @rolls = {}
    @score = 0
  end

  def log_roll(score)
    @score += score
    @rolls[@rolls.count + 1] = calculate_score(score)

  end

  def roll_score(roll)
    @rolls[roll]
  end

  def complete?
    @rolls.count > 1 || roll_score(1) == :strike
  end

  private

  def calculate_score (score) 
 
    score = :strike if strike?(score) 
    score = :spare if spare?(score)

    score
  end

  def strike?(score) 
    return true if score == 10 && @rolls.empty?
    return true if score == 10 && @rolls[1] == :strike
    return true if score == 10 && @rolls[2] == :strike
    false
  end

  def spare?(score)
    return false if score == :strike
    @score == 10 && @rolls[1] < 10
  end


end
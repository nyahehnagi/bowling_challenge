# frozen_string_literal: true

describe 'logging rolls to the scorecard' do
  it 'first frame, first roll, no strike' do
    scorecard = ScoreCard.new
    scorecard.log_roll(7)
    expect(scorecard.score).to eq 0
  end

  it 'first frame, second roll, no spare' do
    scorecard = ScoreCard.new
    scorecard.log_roll(7)
    scorecard.log_roll(2)
    expect(scorecard.score).to eq 9
  end
end

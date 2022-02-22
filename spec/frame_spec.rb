require './lib/frame'

describe Frame do
  
  subject(:frame) { described_class.new }
  context "No bonuses" do
    it "scores a roll" do
      frame.log_roll(5)
      expect(frame.score).to eq 5
    end

    it "scores a roll" do
      frame.log_roll(6)
      expect(frame.score).to eq 6
    end

    it "scores the second roll" do
      frame.log_roll(6)
      frame.log_roll(3)
      expect(frame.score).to eq 9
    end

    it "can see the first roll" do
      frame.log_roll(6)
      expect(frame.roll_score(1)).to eq 6
    end

    it "can see the second roll" do
      frame.log_roll(6)
      frame.log_roll(3)
      expect(frame.roll_score(2)).to eq 3
    end
  end

  context "With bonuses" do

    it "scores a spare on the second roll" do
      frame.log_roll(3)
      frame.log_roll(7)
      expect(frame.roll_score(2)).to eq :spare
    end

    
    it "scores a spare on the second roll if first roll zero" do
      frame.log_roll(0)
      frame.log_roll(10)
      expect(frame.roll_score(2)).to eq :spare
    end

    it "scores a strike on the first roll" do
      frame.log_roll(10)
      expect(frame.roll_score(1)).to eq :strike
    end

    it "scores two strikes on 2 rolls" do
      frame.log_roll(10)
      frame.log_roll(10)
      expect(frame.roll_score(1)).to eq :strike
      expect(frame.roll_score(2)).to eq :strike
    end
  end

end
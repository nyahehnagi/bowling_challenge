require './lib/frame'


describe "getting bonus on the frame" do
  it "scores a spare on the second roll" do
    frame = Frame.new()
    frame.log_roll(3)
    frame.log_roll(7)
    expect(frame.roll_score(2)).to eq :spare
  end


  it "scores a strike on the first roll" do
    frame = Frame.new()
    frame.log_roll(10)
    expect(frame.roll_score(1)).to eq :strike
  end

  
  it "scores two strikes on 2 rolls" do
    frame = Frame.new()
    frame.log_roll(10)
    frame.log_roll(10)
    expect(frame.roll_score(1)).to eq :strike
    expect(frame.roll_score(2)).to eq :strike
  end

  it "scores three strikes on 3 rolls" do
    frame = Frame.new()
    frame.log_roll(10)
    frame.log_roll(10)
    frame.log_roll(10)
    expect(frame.roll_score(1)).to eq :strike
    expect(frame.roll_score(2)).to eq :strike
    expect(frame.roll_score(3)).to eq :strike
  end

  # it "scores zero on first roll, strikes on 2 rolls" do
  #   frame = Frame.new()
  #   frame.log_roll(10)
  #   frame.log_roll(10)
  #   expect(frame.roll_score(1)).to eq :strike
  #   expect(frame.roll_score(2)).to eq :strike
  # end
end
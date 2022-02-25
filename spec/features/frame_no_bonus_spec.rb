
describe "one frame with no bonus" do

  it "logs a single roll" do
    frame = Frame.new()
    frame.log_roll(6)
    expect(frame.roll_score(1)).to eq 6
  end

  it "logs the second roll" do
    frame = Frame.new()
    frame.log_roll(6)
    frame.log_roll(3)
    expect(frame.roll_score(2)).to eq 3
  end

  it "scores a spare on the second roll if first roll zero" do
    frame = Frame.new()
    frame.log_roll(0)
    frame.log_roll(10)
    expect(frame.roll_score(2)).to eq :spare
  end

end
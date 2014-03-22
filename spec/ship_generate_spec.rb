require 'spec_helper'

describe ShipGenerator do
  it "takes a ship length, orientation, and board as arguments" do
    board = [5, 6, 7, 8]
    ship_gen = ShipGenerator.new(5, :horiz, board)
    expect(ship_gen.length).to eq 5
    expect(ship_gen.orientation).to eq :horiz
    expect(ship_gen.board).to eq [5,6,7,8]
  end

  it "#generate returns an array of coords of correct length" do
    ship_gen = ShipGenerator.new(5, :horiz, [])
    ship = ship_gen.generate(3, 3)
    expect(ship.length).to eq 5
  end

  it "#generate with :horiz argument returns an array of horizontal coords" do
    ship_gen = ShipGenerator.new(3, :horiz, [])
    ship = ship_gen.generate(3, 4)
    expect(ship.all? { |c| c / 10 == 3 }).to be_true
  end

  it "#generate does not overrun the row" do
    ship_gen = ShipGenerator.new(7, :horiz, [])
    ship = ship_gen.generate(3, 3)
    expect(ship).to eq [*33..39]
  end

  it "#generate with :vert argument returns an array of vertical coords" do
    ship_gen = ShipGenerator.new(5, :vert, [])
    ship = ship_gen.generate(3, 3)
    expect(ship).to eq [33, 43, 53, 63, 73]
  end

  it "#right returns an array of adjacent coords of correct length" do 
    ship_gen = ShipGenerator.new(5, :horiz, [])
    expect(ship_gen.inc(3)).to eq [3,4,5,6,7]
  end

  it "#left returns an array of adjacent coords of correct length" do
    ship_gen = ShipGenerator.new(5, :horiz, [])
    expect(ship_gen.dec(35)).to eq [31,32,33,34,35]
  end

  it "#get_dir returns 'left' when going right would run off the board" do
    ship_gen = ShipGenerator.new(5, :horiz, [])
    expect(ship_gen.get_dir(7)).to eq :dec
  end

  it "#get_dir returns 'right' when going left would run off board" do
    ship_gen = ShipGenerator.new(5, :horiz, [])
    expect(ship_gen.get_dir(4)).to eq :inc
  end

  it "#get_dir works with ships of all lengths" do
    ship_gen = ShipGenerator.new(6, :horiz, [])
    expect(ship_gen.get_dir(6)).to eq :dec
  end

  it "#get_dir works with all lengths off left side of board" do
    ship_gen = ShipGenerator.new(6, :horiz, [])
    expect(ship_gen.get_dir(5)).to eq :inc
  end

  it "#get_dir returns 'either' if either works" do
    ship_gen = ShipGenerator.new(5, :horiz, [])
    expect(ship_gen.get_dir(5)).to eq :either
  end

  it "#check_coords returns false for coords already on board" do
    ship_gen = ShipGenerator.new(5, :horiz, [25, 35, 45])
    expect(ship_gen.check_coords([25, 26, 27])).to eq false
  end

  it "#check_coords returns true if no coords already on board" do
    ship_gen = ShipGenerator.new(5, :horiz, [25, 35, 45])
    expect(ship_gen.check_coords([22, 23, 24])).to eq true
  end

  it "#check_coords returns false if coords are empty" do
    ship_gen = ShipGenerator.new(5, :horiz, [25, 35, 45])
    expect(ship_gen.check_coords([])).to eq false
  end

  it "#add_ship returns coords" do
    ship_gen = ShipGenerator.new(5, :horiz, [25, 35, 45])
    add = ship_gen.add_ship
    expect(add.size).to eq 5
    expect(add.is_a? Array).to be_true
  end
end
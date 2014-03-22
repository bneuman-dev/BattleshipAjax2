require 'spec_helper'

describe FleetGenerator do
  it "generates a fleet for ship_conf with just one ship" do
    ship_conf = [{name: 'Destroyer', length: 2}]
    gen = FleetGenerator.new(ship_conf)
    gen.make_fleet
    expect(gen.fleet.size).to eq 1
  end

  it "a ship in #ships has coords" do
    ship_conf = [{name: 'Destroyer', length: 2}]
    gen = FleetGenerator.new(ship_conf)
    gen.make_fleet
    expect(gen.fleet.first[:coords]).to_not be_nil
  end

  it "#coords is an array of appropriate length" do
    ship_conf = [{name: 'Destroyer', length: 2}]
    gen = FleetGenerator.new(ship_conf)
    gen.make_fleet
    expect(gen.fleet.first[:coords].size).to eq 2
  end

  it "#coords is an array of integers" do
    ship_conf = [{name: 'Destroyer', length: 2}]
    gen = FleetGenerator.new(ship_conf)
    gen.make_fleet
    expect(gen.fleet.first[:coords].all? {|c| c.is_a? Integer})
    .to be_true
  end

  it "#board returns empty array before adding ships" do
    ship_conf = [{name: 'Destroyer', length: 2}]
    gen = FleetGenerator.new(ship_conf)
    expect(gen.board).to eq []
  end

  it "#board returns array of coords after adding ship" do
    ship_conf = [{name: 'Destroyer', length: 2}]
    gen = FleetGenerator.new(ship_conf)
    gen.make_fleet
    expect(gen.board.size).to eq 2
  end

  it "#board returns array of coords of right length after adding multiple ships" do
    ship_conf = [
      {name: 'Destroyer', length: 2},
      {name: 'Cruiser', length: 3},
      {name: 'Battleship', length: 4},
      {name: 'Carrier', length: 5},
      {name: 'Cruiser', length: 3}]
    gen = FleetGenerator.new(ship_conf)
    gen.make_fleet
    expect(gen.board.size).to eq 17
  end

  it "generates a fleet for with five ships" do
    ship_conf = [
      {name: 'Destroyer', length: 2},
      {name: 'Cruiser', length: 3},
      {name: 'Battleship', length: 4},
      {name: 'Carrier', length: 5},
      {name: 'Cruiser', length: 3}]
    gen = FleetGenerator.new(ship_conf)
    gen.make_fleet
    expect(gen.fleet.size).to eq 5
  end

  # it "all ships in fleet have # of coords eq to length" do

  # end
end

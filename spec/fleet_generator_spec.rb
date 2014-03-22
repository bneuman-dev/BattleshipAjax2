require 'spec_helper'

describe FleetGenerator do
  it "generates a fleet for ship_conf with just one ship" do
    ship_conf = [{name: 'Destroyer', length: 2}]
    gen = FleetGenerator.new(ship_conf)
    expect(gen.fleet.size).to eq 1
  end
end

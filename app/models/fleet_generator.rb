class FleetGenerator
  attr_reader :fleet
  def initialize(ship_conf)
    @ship_conf = ship_conf
    @fleet = []
  end

  def make_fleet
    @ship_conf.each do |ship|
      orientation = [:horiz, :vert].sample
      ship[:coords] = ShipGenerator.new(ship[:length], orientation, board).add_ship
      @fleet << ship
    end
  end

  def board
    @fleet.reduce([]) do |accum, ship|
      accum += ship[:coords]
    end
  end
end
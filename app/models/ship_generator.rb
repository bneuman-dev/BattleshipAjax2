class ShipGenerator
  attr_reader :length, :orientation, :board
  def initialize(length, orientation, board)
    @length = length
    @orientation = orientation
    @board = board
  end

  def add_ship
    coords = []

    until check_coords(coords)
      start_point = rand(0..9)
      line = rand(0..9)
      coords = generate(line, start_point)
    end

    coords
  end

  def generate(line, start)
    dir = get_dir(start)

    points = case dir
    when :inc then inc(start)
    when :dec then dec(start)
    when :either then [inc(start), dec(start)].sample
    end
  
    case orientation
    when :horiz then points.map { |point| line * 10 + point }
    when :vert then points.map { |point| point * 10 + line }
    end
  end

  def inc(start)
    [*start..start + (length - 1)]
  end

  def dec(start)
    [*(start - (length - 1))..start]
  end

  def get_dir(start)
    if start > (10 - (length - 1))
      :dec
    elsif start < length
      :inc
    else
      :either
    end
  end

  def check_coords(coords)
    return false if coords.empty?
    coords.none? { |coord| @board.include? coord }
  end
end
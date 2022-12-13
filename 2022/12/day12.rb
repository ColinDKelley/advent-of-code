
class Board
  def initialize(matrix, x_range: nil, y_range: nil, allowed_moves: nil)
    @matrix = matrix
    @height = @matrix.size
    @width = @matrix.first.size
    @x_range = x_range || Range.new(0, @width, exclusive: true)
    @y_range = y_range || Range.new(0, @height, exclusive: true)
    @allowed_moves = allowed_moves
  end

  def dup
    self.class.new(@matrix.map(&:dup), x_range: @x_range, y_range: @y_range, allowed_moves: @allowed_moves)
  end

  def findxy(target)
    @matrix.find.with_index do |row, y|
      if (x = row.find.with_index { |char, i| char == target and break i })
        break [x, y]
      end
    end
  end

  def []=(point, value)
    @matrix[point.last][point.first] = value
  end

  def inspect
    @matrix.map(&:inspect)
  end

  def height_at(point)
    if in_bounds?(point)
      if (row = @matrix[point.last])
        row[point.first]
      end
    end
  end

  def swap_height_at(point, value)
    height_at(point).tap do |height|
      value || height or raise "Value/Height missing from #{point.inspect}"
      self[point] = value
    end
  end

  def in_bounds?(point)
    @x_range.include?(point.first) &&
    @y_range.include?(point.last)
  end

  def shortest_path_to(head_point, dest_point, moves = 0, shortest = nil)
    shortest && (moves + 1 >= shortest) and return nil

    puts "SHORTEST_PATH #{head_point.inspect}, #{moves}, #{shortest}" if rand(5000) == 0
    head_height = swap_height_at(head_point, nil)

    adjacent_points =
      @allowed_moves[head_point.last][head_point.first].select do |point|
        allowed = (height = height_at(point)) && self.class.allowed_height_delta?(head_height, height)
        if allowed && point == dest_point
          puts "FOUND at moves #{moves + 1}"
          return moves + 1
        end
        allowed
      end

    scratch_board = dup

    adjacent_points.each do |adjacent_point|
      distance = scratch_board.shortest_path_to(adjacent_point, dest_point, moves + 1, shortest)
      shortest = [shortest, distance].compact.min
    end

    shortest
  ensure
    swap_height_at(head_point, head_height) rescue nil
  end

  class << self
    def height_delta(from, to)
      to.ord - from.ord
    end

    def allowed_height_delta?(from, to)
      height_delta(from, to) <= 1
    end

    def adjacent_points(point)
      [
        [point.first, point.last-1],
        [point.first, point.last+1],
        [point.first-1, point.last],
        [point.first+1, point.last]
      ]
    end
  end

  require 'pry'

  def find_allowed_moves!
    @allowed_moves = find_allowed_moves
  end

  def find_allowed_moves
    matrix = @height.times.map { @width.times.map { [] } }

    @height.times do |y|
      @width.times do |x|
        point = [x, y]
        head_height = height_at(point)
        self.class.adjacent_points(point).each do |point|
          if (height = height_at(point)) && self.class.allowed_height_delta?(head_height, height)
            matrix[y][x] << point
          end
        end
      end
    end

    matrix
  end
end

matrix = STDIN
  .read
  .split("\n")
  .map { _1.chars }

board = Board.new(matrix)

start_point = board.findxy('S')
end_point = board.findxy('E')

board[start_point] = 'a'
board[end_point] = 'z'

board.find_allowed_moves!

puts board.inspect, start_point.inspect, end_point.inspect

puts board.shortest_path_to(start_point, end_point)

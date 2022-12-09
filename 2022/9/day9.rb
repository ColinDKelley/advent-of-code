require 'set'

TAIL_KNOTS = 9

lines = STDIN.each_line.map(&:chomp)

@x = 5
@y = 5

@tx = 5
@ty = 5

tail_positions = Set.new
tail_positions << [@tx, @ty]

def move(dir)
  case dir
  when 'R'
    @x += 1
  when 'L'
    @x -= 1
  when 'U'
    @y -= 1
  when 'D'
    @y += 1
  else
    raise "unexpected move #{dir} #{amount}"
  end
end

def deltas(head, tail)
  sign = tail > head ? 1 : -1
  [(tail - head)*sign, sign]
end

def move_tail
  if @y == @ty # same row
    puts "SAME ROW"
    if (@x - @tx) > 1 # ahead of tail by 2+
      @tx += 1
    elsif (@x - @tx) < -1
      @tx -= 1
    end
  elsif @x == @tx # same col
    puts "SAME COL"
    if (@y - @ty) > 1
      @ty += 1
    elsif (@y - @ty) < -1
      @ty -= 1
    end
  else
    xdelta, xsign = deltas(@x, @tx)
    ydelta, ysign = deltas(@y, @ty)
    if xdelta == 2 && ydelta == 1
      puts "DIAG x2"
      @tx -= xsign
      @ty -= ysign
    elsif xdelta == 1 && ydelta == 2
      puts "DIAG Y2"
      @tx -= xsign
      @ty -= ysign
    end
  end
end

lines.each do |line|
  dir, amount = line.split

  amount = amount.to_i

  amount.times do
    move(dir)
    move_tail
    tail_positions << [@tx, @ty]
    puts "Head: [#{@x}, #{@y}]  Tail: [#{@tx}, #{@ty}]"
  end
end

puts tail_positions.inspect

puts tail_positions.size

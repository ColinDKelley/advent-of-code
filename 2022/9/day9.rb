require 'set'

TAIL_KNOTS = 9

@x = 10
@y = 10

@tx = [@x] * TAIL_KNOTS
@ty = [@y] * TAIL_KNOTS

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

# returns [magnitude, sign]
def delta(head, tail)
  sign = tail > head ? 1 : -1
  [(tail - head)*sign, sign]
end

def move_tail(x, y, ti)
  if y == @ty[ti] # same row
    if (x - @tx[ti]) > 1 # ahead of tail by 2+
      @tx[ti] += 1
    elsif (x - @tx[ti]) < -1
      @tx[ti] -= 1
    end
  elsif x == @tx[ti] # same col
    if (y - @ty[ti]) > 1
      @ty[ti] += 1
    elsif (y - @ty[ti]) < -1
      @ty[ti] -= 1
    end
  else
    xdelta, xsign = delta(x, @tx[ti])
    ydelta, ysign = delta(y, @ty[ti])
    if (xdelta == 2 && ydelta >= 1) || (xdelta >= 1 && ydelta == 2)
      @tx[ti] -= xsign
      @ty[ti] -= ysign
    elsif xdelta > 2 || ydelta > 2
      raise "Uh oh! xdelta #{xdelta}; ydelta #{ydelta} ???"
    end
  end
end

tail_positions = Set.new
tail_positions.add([@tx.last, @ty.last])

STDIN.each_line do |line|
  dir, amount = line.split

  amount.to_i.times do
    move(dir)
    x, y = @x, @y
    TAIL_KNOTS.times do
      move_tail(x, y, _1)
      x, y = @tx[_1], @ty[_1]
    end
    tail_positions.add([@tx.last, @ty.last])
    puts "Head: [#{@x}, #{@y}]  Tails: #{TAIL_KNOTS.times.map { |i| "[#{@tx[i]}, #{@ty[i]}] " }}"
  end
end

puts tail_positions.size

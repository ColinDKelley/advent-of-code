@x = 1
@cycles = [@x]

def cycle
  @cycles << @x
end

STDIN.each_line do |line|
  case line.split
  in ['noop']
    @cycles << @x
  in ['addx', count]
    @cycles << @x
    @cycles << @x
    @x += count.to_i
  in []
  else
    raise "unknown command #{line.split.inspect}"
  end
end

@cycles << @x

strength = @cycles.map.with_index(&:*)

puts [20, 60, 100, 140, 180, 220].map { |i| strength[i] }.sum

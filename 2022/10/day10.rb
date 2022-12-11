@x = 1
@cycles = [@x]
@pixels = []

def sprite_visible?
  delta = @x - (@cycles.size % 40)
  (-2..0).include?(delta).tap { puts "cycle: [#{@cycles.size}]=#{@x} delta: #{delta}: #{_1}" }
end

def cycle
  @pixels << (sprite_visible? ? '#' : ' ')
  puts @pixels.each_slice(40).map(&:join)
  @cycles << @x
end

STDIN.each_line do |line|
  case line.split
  in ['noop']
    cycle
  in ['addx', count]
    cycle
    cycle
    @x += count.to_i
  in []
  else
    raise "unknown command #{line.split.inspect}"
  end
end

cycle

strength = @cycles.map.with_index(&:*)

puts [20, 60, 100, 140, 180, 220].map { |i| strength[i] }.sum

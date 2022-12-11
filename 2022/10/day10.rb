@x = 1
@cycles = [@x]

def sprite_visible?(cycle, x)
  (-2..0).include?(x - (cycle % 40))
end

def cycle!
  @cycles << @x
end

STDIN.each_line do |line|
  case line.split
  in ["noop"]
    cycle!
  in ["addx", count]
    cycle!
    cycle!
    @x += count.to_i
  else
    raise "unknown command #{line.split.inspect}"
  end
end

strength = @cycles.map.with_index(&:*)

puts [20, 60, 100, 140, 180, 220].map { |i| strength[i] }.sum

pixels = @cycles.map.with_index { |x, cycle| sprite_visible?(cycle, x) ? "#" : " " }
puts pixels[1..-1].each_slice(40).map(&:join)

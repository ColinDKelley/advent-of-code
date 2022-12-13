
pairs =
  STDIN.read.split("\n\n")
     .map { |pair| pair.split("\n").map { eval(_1) } }

# returns -1 if right sorts after left
def compare(left, right)
  case [left, right]
  in [Integer, Integer]
    left <=> right
  in [Array, Array]
    [left.size, right.size].max.times.find { (r = compare(left[_1], right[_1]).nonzero?) and break r } || 0
  in [Array, Integer]
    compare(left, [right])
  in [Integer, Array]
    compare([left], right)
  in [nil, Object]
    -1
  in [Object, nil]
    1
  end.tap do |result|
    puts "compare #{left.inspect} <=> #{right.inspect} => #{result.inspect}"
  end
end

puts pairs.inspect

matches =
  pairs.map.with_index { |(left, right), i| puts "Pair #{i + 1}"; compare(left, right) < 0 ? i + 1 : nil }

puts matches.inspect, matches.compact.sum

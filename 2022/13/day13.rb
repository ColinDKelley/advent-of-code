# returns 0 if equal
# returns 1 if left sorts after right
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
  end.tap { |result| puts "compare #{left.inspect} <=> #{right.inspect} => #{result.inspect}" }
end

packets =
  STDIN
    .read
    .split("\n")
    .map { eval(_1) unless _1.empty? }
    .compact

DIVIDERS = [[[2]], [[6]]]

puts([*packets, *DIVIDERS]
    .sort { compare(_1, _2) }
    .map.with_index { _2 + 1 if DIVIDERS.include?(_1) }
    .compact
    .reduce(&:*)
)

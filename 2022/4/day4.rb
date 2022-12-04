require 'set'

contains = overlap = 0

STDIN.each_line do |line_with_newline|
  line = line_with_newline.chomp

  sets = line.split(',').map do |range|
    start_end = range.split('-').map(&:to_i)
    Range.new(*start_end).to_a.to_set
  end

  if sets.include?(sets.reduce(&:|)) # union of the 2 exactly equals 1 of them
    contains += 1
  end

  if (sets.reduce(&:&)).any?         # intersection of the 2 is non-empty
    overlap += 1
  end
end

puts contains, overlap

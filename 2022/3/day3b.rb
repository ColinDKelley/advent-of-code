def priority(item)
  case item
  when 'a'..'z'
    item.ord - 'a'.ord + 1
  when 'A'..'Z'
    item.ord - 'A'.ord + 27
  else
    raise "unknown item range #{item.inspect}"
  end
end

groups = [[]]

STDIN.each_line do |line_with_newline|
  line = line_with_newline.chomp

  if groups.last.size == 3
    groups << []
  end

  groups.last << line
end

sum = 0

groups.each do |group|
  common = group.map { |g| g.split('') }.reduce(&:&)
  common.size == 1 or raise "expected exactly 1 common: #{group.inspect} => #{common.inspect}"

  puts "#{group.inspect} => #{common.first.inspect}"

  sum += priority(common.first)
end

puts sum

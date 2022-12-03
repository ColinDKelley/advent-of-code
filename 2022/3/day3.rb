def get_priority(item)
  case item
  when 'a'..'z'
    item.ord - 'a'.ord + 1
  when 'A'..'Z'
    item.ord - 'A'.ord + 27
  else
    raise "unknown item range #{item.inspect}"
  end
end

sum = 0

STDIN.each_line do |line_with_newline|
  line = line_with_newline.chomp

  comp1 = line[0, line.size/2]
  comp2 = line[line.size/2, line.size/2]

  common = comp1.split('') & comp2.split('')

  common.size == 1 or raise "??? #{common.inspect}"

  sum += get_priority(common.first)

  puts common.join(', ') + " #{sum}"
end

puts sum

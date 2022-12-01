elf_calories = Hash.new { |k, v| k[v] = [] }
elf = 0

STDIN.each_line do |line_with_newline|
  line = line_with_newline.chomp

  if line.empty?
    elf += 1
  else
    calories = line.to_i
    elf_calories[elf] << calories
  end
end

elf_calories_sum = elf_calories.map do |elf, cal_list|
  [elf, cal_list.sum]
end

calories_sum = elf_calories_sum.map(&:last)


puts "1. Most calories: #{calories_sum.max}"

puts "2. Sum of top 3 most calories: #{calories_sum.sort_by { |cals| -cals }.take(3).sum}"

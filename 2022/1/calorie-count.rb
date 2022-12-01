# this array has one entry per elf
# each elf's entry has an array of calorie amounts
elf_calories = []
elf = 0

STDIN.each_line do |line_with_newline|
  line = line_with_newline.chomp

  if line.empty?
    elf += 1
  else
    elf_calories[elf] ||= []
    elf_calories[elf] << line.to_i
  end
end

elf_calories_sum = elf_calories.map(&:sum)

puts "1. Most calories: #{elf_calories_sum.max}"

puts "2. Sum of top 3 most calories: #{elf_calories_sum.sort_by { |cals| -cals }.take(3).sum}"

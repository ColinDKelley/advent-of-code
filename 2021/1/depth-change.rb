last_depth = nil

STDIN.each_line do |line|
  depth = line.chomp.to_i
  puts(
    if last_depth.nil?
      "-"
    elsif depth > last_depth
      "increase"
    elsif depth < last_depth
      "decrease"
    else
      "unchanged"
    end
  )

  last_depth = depth
end

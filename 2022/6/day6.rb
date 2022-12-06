def first_unique(chars, len)
 (len..chars.size).find { chars[_1 - len, len].uniq.size == len }
end

chars = STDIN.read.chars

puts first_unique(chars, 4)
puts first_unique(chars, 14)

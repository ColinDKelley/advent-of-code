MIN_CHARS = 14

index = 0
buffer = []

STDIN.each_char do |char|
  buffer << char

  if buffer.size > MIN_CHARS
    buffer.shift
  end

  index += 1

  if buffer.uniq.size == MIN_CHARS
    puts(buffer.join, index)
    break false
  end
end and puts("not found! #{buffer.join} #{index}")

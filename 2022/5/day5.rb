
index = 0
buffer = []

STDIN.read.chars.each do |char|
  buffer << char

  if buffer.size >= 4
    buffer.shift
  end

  if buffer.uniq.size == 4
    break
  end

  index += 1
end

puts buffer.inspect, index

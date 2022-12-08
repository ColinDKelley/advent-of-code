heights = STDIN.each_line.map do |line|
  line.chomp.chars.map(&:to_i)
end

X = heights.first.size
Y = heights.size

visible = Y.times.map { [false] * X }
(0...X).each { |x| visible[0][x] = visible[Y - 1][x] = true }
(0...Y).each { |y| visible[y][0] = visible[y][X - 1] = true }

(0...X).each do |x|
  highest = 0
  (0...Y).each do |y|
    if (h = heights[y][x]) > highest
      visible[y][x] = true
      highest = h
    end
  end
  highest = 0
  (0...Y).reverse_each do |y|
    if (h = heights[y][x]) > highest
      visible[y][x] = true
      highest = h
    end
  end
end

(0...Y).each do |y|
  highest = 0
  (0...X).each do |x|
    if (h = heights[y][x]) > highest
      visible[y][x] = true
      highest = h
    end
  end
  highest = 0
  (0...X).reverse_each do |x|
    if (h = heights[y][x]) > highest
      visible[y][x] = true
      highest = h
    end
  end
end

puts "A: #{visible.flatten.count(&:itself)}"

scenic = Y.times.map { [1] * X }

(1...X).each do |x|
  (1...Y).each do |y|
    height = heights[y][x]

    # consider all 4 directions from [y][x]
    # LEFT
    count = 0
    (0...x).reverse_each do |xi|
      count += 1
      if heights[y][xi] >= height
        break
      end
    end
    scenic[y][x] *= count

    # RIGHT
    count = 0
    ((x + 1)...X).each do |xi|
      count += 1
      if heights[y][xi] >= height
        break
      end
    end
    scenic[y][x] *= count

    # UP
    count = 0
    (0...y).reverse_each do |yi|
      count += 1
      if heights[yi][x] >= height
        break
      end
    end
    scenic[y][x] *= count

    # DOWN
    count = 0
    ((y + 1)...Y).each do |yi|
      count += 1
      if heights[yi][x] >= height
        break
      end
    end
    scenic[y][x] *= count
  end
end

puts "B: #{scenic.flatten.max}"

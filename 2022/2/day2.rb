Normalize =
{
 'A' => 0, # Rock
 'B' => 1, # Paper
 'C' => 2, # Scissors
 'X' => 0, # Rock
 'Y' => 1, # Paper
 'Z' => 2, # Scissors
}

SHAPE_SCORE =
{
  0 => 1,
  1 => 2,
  2 => 3
}

NEED_TO_END =
{
  0 => 0,
  1 => 3,
  2 => 6
}

def outcome_score(opp_shape, my_shape)
  case (my_shape - opp_shape) % 3
  when 0                                 # tie
    3
  when 1                                 # I'm +1 on the mod wheel, so I won
    6
  else                                   # I'm +2 (aka -1) on the mod wheel, so I lost
    0
  end
end

sums = [0, 0]

STDIN.each_line do |line_with_newline|
  line = line_with_newline.chomp

  opp_shape, need_to_end = line.split.map { Normalize[_1] }

  need_outcome_score = NEED_TO_END[need_to_end] or
    raise "NEED_TO_END not found #{need_to_end.inspect}"

  my_shape = [0, 1, 2].find { |my| need_outcome_score == outcome_score(opp_shape, my) } or
    raise "my_shape not found #{need_outcome_score}"

  scores = [SHAPE_SCORE[my_shape], outcome_score(opp_shape, my_shape)]

  sums[0] += scores[0]; sums[1] += scores[1]

  puts scores.inspect
end

puts sums.inspect, sums.sum

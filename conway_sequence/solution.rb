initial = gets.to_i
limit   = gets.to_i - 1

sequence = [[initial], [1, initial]]

(1..limit).each do |i|
  last_seq = sequence[i].dup
  tempseq  = []
  previous = nil

  while current = last_seq.shift
    if previous == current
      tempseq << [] if tempseq.empty?
      tempseq.last << current
    else
      tempseq << [current]
    end
    previous = current
  end

  sequence << tempseq.map {|n| [n.count, n.last] }.flatten
end

puts sequence[limit].join(" ")

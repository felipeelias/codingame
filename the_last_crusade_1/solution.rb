# simple solution, without pathfinding
STDOUT.sync = true

grid = []
_width, height = gets.split(" ").map(&:to_i)
height.times do
  grid << gets.chomp.split(" ").map(&:to_i)
end
_exit = gets.to_i

loop do
  x, y, pos = gets.split(" ")
  x = x.to_i
  y = y.to_i

  direction = case grid[y][x]
    when 3, 7, 8, 9, 1 then "#{x} #{y+1}"
    when 11 then "#{x+1} #{y}"
    when 6, 2 then (pos == "RIGHT" ? "#{x-1} #{y}" : "#{x+1} #{y}")
    when 10 then "#{x-1} #{y}"
    when 5, 13 then (pos == "TOP" ? "#{x+1} #{y}" : "#{x} #{y+1}")
    when 4, 12 then (pos == "TOP" ? "#{x-1} #{y}" : "#{x} #{y+1}")
  end

  puts direction
end

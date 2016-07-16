def median(array)
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

xv, yv = [], []
n = gets.to_i
n.times do
  x, y = gets.split(" ").map(&:to_i)
  xv << x
  yv << y
end

median_y = median(yv)
distance = yv.reduce(0) { |sum, y| sum + (y - median_y).abs }.to_i
x_length = xv.minmax.reduce(:-).abs.to_i

if n > 1
  puts distance + x_length
else
  puts "0"
end

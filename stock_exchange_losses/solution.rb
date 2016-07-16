_n = gets.to_i
inputs = gets.split(" ").map(&:to_i)

loss, max = 0, 0

inputs.each_cons(2) do |(a, b)|
  if a > b
    max = a if a > max
    loss = b - max if b - max < loss
  end
end

puts loss

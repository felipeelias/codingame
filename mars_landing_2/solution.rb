STDOUT.sync = true

land_points = []
gets.to_i.times do
  # land_x, land_y
  land_points << gets.split(" ").collect(&:to_i)
end

landing_area   = land_points.each_cons(2).find { |(a, b)| a.last == b.last }
landing_area_x = landing_area.map(&:first)

landing_x = (landing_area_x.max - landing_area_x.min) / 2 + landing_area_x.min
landing_y = landing_area.first.last
MAX_ANGLE = 21

loop do
  STDERR.puts landing_area.inspect
  STDERR.puts [landing_x, landing_y].inspect

  # h_speed, v_speed, fuel, rotate, power
  x, y, h_speed, v_speed, fuel, rotate, power = gets.split(" ").collect(&:to_i)

  case
  when (landing_x - x).abs > 1000
    STDERR.puts "APPROACHING"
    thrust = 4
    angle  = case x <=> landing_x
      when -1 then -MAX_ANGLE
      when 0  then 0
      when +1 then +MAX_ANGLE
    end

    thrust, angle = if h_speed > 20 then
      STDERR.puts "BREAKING"
      [4, MAX_ANGLE + 10]
    elsif h_speed < -20 then
      STDERR.puts "BREAKING"
      [4, -MAX_ANGLE - 10]
    else
      [thrust, angle]
    end
  when (landing_x - x).abs <= 1000
    STDERR.puts "DESCENDING"

    thrust = case v_speed.abs
      when (39..Float::INFINITY) then 4
      when (20..38) then 3
      when (10..19) then 2
      when (5..9) then 0
      else 0
    end

    thrust, angle = if h_speed > 20 then
      STDERR.puts "BREAKING"
      [4, MAX_ANGLE + 10]
    elsif h_speed < -20 then
      STDERR.puts "BREAKING"
      [4, -MAX_ANGLE - 10]
    else
      [thrust, 0]
    end

    angle = y.between?(landing_y, landing_y + 500) ? 0 : angle
  end

  if y >= 2900 then thrust = 0 end

  puts "#{angle} #{thrust}"
end

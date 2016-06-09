STDOUT.sync = true

_, _, _, exit_floor, exit_pos, _, _, elevators_count = gets.split(" ").collect(&:to_i)

elevators = {}
elevators[exit_floor] = exit_pos

elevators_count.times do
  elevator_floor, elevator_pos = gets.split(" ").collect(&:to_i)
  elevators[elevator_floor] = elevator_pos
end

loop do
  clone_floor, clone_pos, direction = gets.split(" ")
  clone_floor  = clone_floor.to_i
  clone_pos    = clone_pos.to_i
  elevator_pos = elevators[clone_floor]

  command = if elevator_pos
    case elevator_pos <=> clone_pos
    when -1 # elevator is on the left of the clone
      if direction == "RIGHT"
        elevators.delete(clone_floor)
        "BLOCK"
      else
        "WAIT"
      end
    when 0 # elevator is at the clone position
      "WAIT"
    when 1 # elevator is on the right of the clone
      if direction == "LEFT"
        elevators.delete(clone_floor)
        "BLOCK"
      else
        "WAIT"
      end
    end
  else
    "WAIT"
  end

  puts command
end

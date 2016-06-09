STDOUT.sync = true

class Link
  attr_reader :n1, :n2
  attr_accessor :distance

  def initialize(n1, n2)
    @n1, @n2 = n1, n2
    @distance = nil
  end

  def to_s
    "#{n1} #{n2}"
  end

  def inspect
    "#<Node #{[n1, n2].inspect}, distance: #{distance}>"
  end
end

def reset(links)
  links.dup.each { |n| n.distance = nil }
end

def links_of(links, index)
  links.select do |link|
    link.n1 == index || link.n2 == index
  end
end

def distances(links, start)
  links    = links.dup
  frontier = links_of(links, start)

  distance = 0
  while frontier.any?
    new_frontier = []

    frontier.each do |link|
      if link.distance.nil?
        link.distance = distance + 1
        new_frontier.concat(links_of(links, link.n1))
        new_frontier.concat(links_of(links, link.n2))
        new_frontier.uniq!
      end
    end

    frontier = new_frontier
    distance += 1
  end

  links
end

def sort(links)
  links.reject(&:nil?).sort_by { |link| link.distance }
end

def closest_to(links, destination)
  sort(links_of(links, destination)).first
end

def main(links, gateways, agent)
  with_distances = distances(reset(links), agent)

  choices = gateways.map do |gateway|
    closest_to(with_distances, gateway)
  end

  closest = sort(choices).first

  links.delete(closest)

  closest
end

links = []
gateways = []

@n, @l, @e = gets.split(" ").collect(&:to_i)
@l.times do
  links << Link.new(*gets.split(" ").collect(&:to_i))
end

@e.times do
  gateways << gets.to_i
end

loop do
  agent = gets.to_i
  closest = main(links, gateways, agent)
  puts closest.to_s
end

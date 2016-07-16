require 'pry'

CAPTURES = []
def puts(*args)
  args.each do |arg|
    STDOUT.puts arg
    CAPTURES << arg.to_s
  end
end

puzzle, test_case = ARGV.first.split("/")

STDIN  = File.open("#{puzzle}/#{test_case}")
output = File.read("#{puzzle}/#{test_case}.out").chomp

load "#{puzzle}/solution.rb"
solution = CAPTURES.last.to_s

if solution != output
  raise "Wrong solution #{solution.inspect}, expected #{output.inspect}"
end

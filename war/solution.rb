class Game
  CARDS = { 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }
  EmptyDeck = Class.new(RuntimeError)

  def initialize(p1cards, p2cards)
    @p1cards = Array(p1cards)
    @p2cards = Array(p2cards)
    @p1deck, @p2deck = [], []
    @turns = 0
  end

  def play
    loop do
      break [1, @turns] if @p2cards.empty?
      break [2, @turns] if @p1cards.empty?

      case compare(@p1cards.first, @p2cards.first)
      when +1 then @p1cards.concat(turn_result); replay
      when -1 then @p2cards.concat(turn_result); replay
      when  0 then war
      end
    end
  end

  def replay
    @turns += 1
    @p1deck.clear
    @p2deck.clear
  end

  def turn_result
    if @p1deck.any?
      @p1deck + [@p1cards.shift] + @p2deck + [@p2cards.shift]
    else
      [@p1cards.shift, @p2cards.shift]
    end
  end

  def war
    raise EmptyDeck if @p1cards.size < 4 || @p2cards.size < 4

    @p1deck.concat(@p1cards.shift(4))
    @p2deck.concat(@p2cards.shift(4))
  end

  def compare(card1, card2)
    CARDS.fetch(card1, card1.to_i) <=> CARDS.fetch(card2, card2.to_i)
  end
end

if ENV['spec'].nil?
  p1cards = gets.to_i.times.map { gets.chop.chop }
  p2cards = gets.to_i.times.map { gets.chop.chop }

  begin
    puts Game.new(p1cards, p2cards).play.join(' ')
  rescue Game::EmptyDeck
    puts "PAT"
  end
else
  require 'rspec/autorun'
  require 'pry'

  RSpec.configure { |c| c.color = true }

  describe 'War' do
    specify 'p2 wins' do
      game = Game.new(%w(K Q J), %w(A K Q))
      winner, turns = game.play
      expect(winner).to eq 2
      expect(turns).to eq 3
    end

    specify 'one war' do
      game = Game.new(%w(A 1 1 1 1), %w(A 2 2 2 2))
      winner, turns = game.play
      expect(winner).to eq 2
      expect(turns).to eq 1
    end

    specify 'two wars' do
      # w = war
      # e = end
      #                  w       w       e
      game = Game.new(%w(A 1 1 1 2 3 3 3 4), %w(A 1 2 2 2 3 3 3 3))
      winner, turns = game.play
      expect(winner).to eq 1
      expect(turns).to eq 1
    end

    specify 'example 0' do
      game = Game.new(%w(10 9 8 K 7 5 6), %w(10 7 5 Q 2 4 6))
      expect { game.play }.to raise_error(Game::EmptyDeck)
    end

    specify 'example 1' do
      game = Game.new(%w(A K Q), %w(K Q J))
      winner, turns = game.play
      expect(winner).to eq 1
      expect(turns).to eq 3
    end

    specify 'example 2' do
      game = Game.new(
        %w(5 3 2 7 8 7 5 5 6 5 4 6 6 3 3 7 4 4 7 4 2 6 8 3 2 2),
        %w(A 9 K K K K 10 10 9 Q J 10 8 Q J A J A Q A J 10 9 8 Q 9)
      )
      winner, turns = game.play
      expect(winner).to eq 2
      expect(turns).to eq 26
    end

    specify 'example 3' do
      game = Game.new(
        %w(8 K A Q 2),
        %w(8 2 3 4 3)
      )
      winner, turns = game.play
      expect(winner).to eq 2
      expect(turns).to eq 1
    end

    specify 'example 4' do
      game = Game.new(
        %w(8 K A Q 3 K A Q 6),
        %w(8 2 3 4 3 2 3 4 7)
      )
      winner, turns = game.play
      expect(winner).to eq 2
      expect(turns).to eq 1
    end

    specify 'example 5' do
      game = Game.new(
        %w(A 4 5 6 Q J 8 2 7 J J 6 K Q 9 2 5 9 6 8 A 4 2 2 7 8),
        %w(10 4 6 3 K J 10 A 5 K 10 9 9 8 5 A 3 4 K 7 3 Q 10 3 7 Q)
      )
      winner, turns = game.play
      expect(winner).to eq 2
      expect(turns).to eq 1262
    end

    specify 'example 6' do
      game = Game.new(
        %w(5 8 10 9 4 6 Q 6 6 9 2 7 A 5 7 9 Q 4 3 J 2 K 10 Q 3 8),
        %w(4 J 8 10 5 7 3 A K 10 J 6 2 K 8 9 K 3 A J 4 7 2 Q 5 A)
      )
      expect { game.play }.to raise_error(Game::EmptyDeck)
    end

    specify 'example 7' do
      game = Game.new(
        %w(4 4 Q 7 Q A 6 5 2 10 3 2 J 10 2 5 K A K J J 9 7 6 3 8),
        %w(3 7 K 9 4 6 8 J 9 10 5 8 A 2 6 7 10 3 K A 9 Q 4 8 Q 5)
      )
      expect { game.play }.to raise_error(Game::EmptyDeck)
    end

  end
end

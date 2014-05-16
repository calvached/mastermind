require_relative 'messages_to_player'
require_relative 'board'
require_relative 'codemaker'

class Game
	def initialize
		@message = MessagesToCodeBreaker.new
	end

	def run
		@message.greeting
		player_options(gets.chomp)
	end

	private

	def player_options(input)
		case input
		when '1'
			@message.play_instructions
			player_options(gets.chomp)
		when '2'
			@message.intro_to_game
			start_game
		when '3'
			@message.greeting
			player_options(gets.chomp)
		when '4'
			@message.quit_game
		else
			@message.help
			player_options(gets.chomp)
		end
	end

	def start_game
		maker = CodeMaker.new
		@board = Board.new(maker.unsolved_pattern)

		1.upto(10) do |num|
			@board.show_current_guesses
			print "Guess #{num}: "
			guess = format_guess(get_codebreaker_guess)
			@board.save_guess(guess)
			return game_finished(num) if maker.give_feedback(guess)
		end
	end

	def game_finished(num)
		@board.show_solved_board
		case num
		when 1
			puts "#{num} try, really? You're either really lucky or you cheated, either way I don't like you!"
		when 2..4
			puts "You have outwitted the CodeMaker in #{num} tries, you are a Mastermind!"
		when 5..7
			puts "#{num} tries is not too shabby if I do say so myself."
		when 8..10
			puts "Dude...it took you #{num} tries, for a second there I almost thought you wouldn't make it!"
		end
	end

	def get_codebreaker_guess
		gets.chomp.upcase.split('')
	end

	def format_guess(guess)
		arr = []
		unless guess.length == 4
			""
		else
				guess.each do |letter|
					arr << /[A-F]/.match(letter)
				end

				if arr.include?(nil)
					""
				else
					guess
				end
		end
	end
end

game = Game.new
game.run

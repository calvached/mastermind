require_relative 'messages_to_player'

class CodeMaker
	# the codemaker has to make a pattern
	# the codemaker has to check whether the pattern matches or not
	# the codemaker has to give feedback
	attr_reader :unsolved_pattern
	def initialize
		@unsolved_pattern = generate_code_pattern
	end

	private

	def generate_code_pattern
		array = ('A'..'F').to_a
		box = []

		1.upto(4) { box << array.sample }
		box
	end
end

class Guess
	attr_reader :all_user_guesses
	def initialize
		@all_user_guesses = []
	end

	def save_user_guess(user_guess)
		@all_user_guesses << user_guess
	end
end

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
			# Maybe I should be creating a round/guess here instead?
			maker = CodeMaker.new
			# Maybe it's easier to keep track of the pattern, the guess, and the number of guesses (counter) in the same spot?
			@message.intro_to_game
			guess = Guess.new

			1.upto(12) do |num|
				print "Guess #{num}: "
				guess.save_user_guess(gets.chomp.upcase)
			end
			guess.all_user_guesses

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

end

game = Game.new
p game.run

# TODO:
# Guess/Round
# Board
# Feedback
# Computer (CodeMaker)
# Human (CodeBreaker)

# Feedback will look like this:
# Correct letter and position: 1
# Correct letter and incorrect position: 2 


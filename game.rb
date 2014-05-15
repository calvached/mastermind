require_relative 'messages_to_player'

class CodeMaker
	# the codemaker has to make a pattern
	# the codemaker has to check whether the pattern matches or not
	# the codemaker has to give feedback
	attr_reader :unsolved_pattern
	def initialize
		@unsolved_pattern = generate_code_pattern
	end

	def give_feedback(user_guess)
		letter_only_counter = []
		unless user_guess.empty?
			user_guess.split('').each do |letter|
				if @unsolved_pattern.include?(letter)
					letter_only_counter << letter
				end
			end
			puts "Outside the loop: #{letter_only_counter} #{letter_only_counter.length}, answer: #{@unsolved_pattern}"
		else
			puts "Foolish mortal, you have thrown away a guess!"
		end

		# Correct letter and position: 1
		# Correct letter and incorrect position: 2 
	end

	private

	def generate_code_pattern
		array = ('A'..'F').to_a
		box = []

		1.upto(4) { box << array.sample }
		box
	end
end

class Board
	attr_reader :codebreaker_guesses
	def initialize(maker_pattern)
		@maker_pattern = maker_pattern
		@codebreaker_guesses = [] || 'none'
	end

	def save_guess(user_guess)
		@codebreaker_guesses << user_guess
	end

	def show_all_guesses
		puts
		puts '[* * * *]'
		@codebreaker_guesses.each do |guess|
			puts "[#{guess}]"
		end
	end

	def show_solved_board
		
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
		# Maybe I should be creating a round/guess here instead?	
		maker = CodeMaker.new
		board = Board.new(maker.unsolved_pattern)

		1.upto(12) do |num|
			# board.show_all_guesses
			print "Guess #{num}: "
			user_guess = valid_guess(gets.chomp.upcase)
			board.save_guess(user_guess)
			maker.give_feedback(user_guess)
		end
	end

	def valid_guess(user_guess)
		arr = []
		unless user_guess.length == 4
			""
		else
				user_guess.split('').each do |letter|
					arr << /[A-F]/.match(letter)
				end

				if arr.include?(nil)
					""
				else
					user_guess
				end
		end
	end
end

game = Game.new
p game.run

# TODO:
# Guess/Round
# Feedback
# Computer (CodeMaker)
# Human (CodeBreaker)
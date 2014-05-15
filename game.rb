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
		unless user_guess.empty?
			return true if exact_match?(user_guess)
			letter_with_position_match(user_guess)
			letter_match(user_guess)
		else
			puts ['Foolish mortal, you have thrown away a guess!',
				    'Did you even READ the instructions??',
				    "Well there goes your guess...now you're never going to see it again",
				    'That was a bad guess...and you should feel bad',
				    "Let's play by the rules now shall we?"].sample
		end
		# Correct letter and incorrect position: 2
	end

	private

	def exact_match?(user_guess)
		@unsolved_pattern == user_guess
	end

	def letter_with_position_match(user_guess)
		counter = []
		user_guess.each_with_index do |cb_letter, cb_i|
				if @unsolved_pattern.include?(cb_letter)
					@unsolved_pattern.each_with_index do |cm_letter, cm_i|
					  counter << cb_letter if cb_letter == cm_letter && cb_i == cm_i
					end
				end
			end

		puts "Correct letter and position: #{counter.length}, answer: #{@unsolved_pattern}"
	end

	def letter_match(user_guess)
		
	end

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
		puts '~CURRENT BOARD~'
		puts '[* * * *]'
		@codebreaker_guesses.reverse.each do |guess|
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
			board.show_all_guesses
			print "Guess #{num}: "
			guess = format_guess(get_codebreaker_guess)
			board.save_guess(guess)
			return game_finished if maker.give_feedback(guess)
		end
	end

	def game_finished
		puts 'You have outwitted the CodeMaker, you are a Mastermind!'
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
p game.run

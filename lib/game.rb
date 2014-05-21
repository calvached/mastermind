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
			puts maker.unsolved_pattern
			print "Guess #{num}: "
			guess = get_codebreaker_guess

				while guess.empty? do
					maker.give_feedback(guess)
					print "Guess #{num}: "
				  guess = get_codebreaker_guess
				end

			@board.save_guess(guess)

			return game_finished(num) if maker.give_feedback(guess)

			@board.save_feedback(maker.current_position_match, maker.current_letter_match)
			@board.show_solved_board('LOSING') if num == 10
		end
	end

	def game_finished(num)
		@board.show_solved_board('WINNING')
		case num
		when 1
			@message.one_shot_wonder(num)
		when 2..4
			@message.true_mastermind(num)
		when 5..7
			@message.not_too_shabby(num)
		when 8..10
			@message.close_call(num)
		end
	end

	def get_codebreaker_guess
		delete_any_invalid_patterns(gets.chomp.upcase.split(''))
	end

	def delete_any_invalid_patterns(guess)
		unless guess.length == 4
			""
		else
			delete_patterns_with_invalid_characters(guess)
		end
	end

	def delete_patterns_with_invalid_characters(guess)
		arr = []
		guess.each do |letter|
			arr << /[A-F]/.match(letter)
		end

		arr.include?(nil) ? "" : guess
	end
end

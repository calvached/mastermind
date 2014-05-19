require_relative 'messages_to_player'

class Board
	attr_reader :codebreaker_guesses

	def initialize(maker_pattern)
		@maker_pattern = maker_pattern
		@codebreaker_guesses = []
		@feedback = []
	end

	def save_guess(user_guess)
		@codebreaker_guesses << user_guess
	end

	def save_feedback(position_fb, letter_fb)
		@feedback << convert_numbers_to_feedback_pegs(position_fb, letter_fb)
	end

	def show_current_guesses
		puts
		puts '~CURRENT BOARD~'
		puts '[* * * *]'
		output_codebreaker_guesses
	end

	def show_solved_board
		puts 
		puts '~WINNING BOARD~'
		puts "#{@maker_pattern}"
		output_codebreaker_guesses
	end

	def output_codebreaker_guesses
		@codebreaker_guesses.length.downto(0) do |i|
			puts "#{@codebreaker_guesses[i]} #{@feedback[i]}"
		end
	end

	def convert_numbers_to_feedback_pegs(position_num, letter_num)
		peg_holder = []
		peg_holder << 'o' * position_num
		peg_holder << 'x' * letter_num
		randomize_feedback_pegs(peg_holder)
	end

	def randomize_feedback_pegs(peg_holder)
		peg_holder.join.split('').sample(4)
	end

end
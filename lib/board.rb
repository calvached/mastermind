require_relative 'messages_to_player'

class Board
	attr_reader :codebreaker_guesses

	def initialize(maker_pattern)
		@maker_pattern = maker_pattern
		@message = MessagesToCodeBreaker.new
		@codebreaker_guesses = []
		@feedback = []
	end

	def save_guess(user_guess)
		@codebreaker_guesses << user_guess
	end

	def save_feedback(feedback)
		@feedback << feedback
	end

	def show_current_guesses
		@message.current_board
		output_codebreaker_guesses
	end

	def show_solved_board(player_outcome)
		@message.solved_board(player_outcome, @maker_pattern)
		output_codebreaker_guesses
	end

	def output_codebreaker_guesses
		@codebreaker_guesses.length.downto(0) do |i|
			@message.show_guess(@codebreaker_guesses[i], @feedback[i])
		end
	end

	def randomize_feedback_pegs(peg_holder)
		peg_holder.join.split('').sample(4)
	end

end
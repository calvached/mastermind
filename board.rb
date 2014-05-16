class Board
	attr_reader :codebreaker_guesses
	def initialize(maker_pattern)
		@maker_pattern = maker_pattern
		@codebreaker_guesses = [] || 'none'
	end

	def save_guess(user_guess)
		@codebreaker_guesses << user_guess
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
		@codebreaker_guesses.reverse.each do |guess|
			puts "[#{guess}]"
		end
	end

end
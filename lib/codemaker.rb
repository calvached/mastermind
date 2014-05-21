require 'messages_to_player'

class CodeMaker
	attr_reader :solved_pattern
	attr_accessor :current_position_match, :current_letter_match, :unsolved_pattern

	def initialize
		@message = MessagesToCodeBreaker.new
		@unsolved_pattern = generate_code_pattern
		@solved_pattern = false
		@current_position_match = nil
		@current_letter_match = nil
		@matches_indexes = []
	end

	def give_feedback(guess)
		give_exact_feedback(guess).concat(give_letter_feedback(guess))
	end

	def give_exact_feedback(guess)
		possible_matches = []

		guess.each_with_index do |letter, i|
			possible_matches << 'o' if @unsolved_pattern[i] == letter
			@matches_indexes << i
		end

		possible_matches
	end

	def generate_code_pattern
    letter_pool = ('A'..'F').to_a
    pattern = []

    1.upto(4) { pattern << letter_pool.sample }
    pattern
  end

  def give_letter_feedback(guess)
  	new_pattern = @unsolved_pattern.clone
  	@matches_indexes.each do |position|
  		new_pattern[position] = '-'
  	end

  	possible_matches = []
  	guess.each do |letter|

  		possible_matches << 'x' if new_pattern.include?(letter)
  	end
		p possible_matches
  end
end
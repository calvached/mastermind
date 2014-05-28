require 'messages_to_player'

class CodeMaker
	attr_reader :solved_pattern
	attr_accessor :current_position_match, :current_letter_match, :unsolved_pattern

	def initialize
		@message = MessagesToCodeBreaker.new
		@unsolved_pattern = generate_code_pattern
		@solved_pattern = false
		@matches_indexes = []
	end

	def give_feedback(guess)
		@guess = guess
		@solved_pattern = true if give_exact_feedback == ['o','o','o','o']
		give_exact_feedback.concat(give_letter_feedback)
	end

	def give_exact_feedback
		possible_matches = []

		@guess.each_with_index do |letter, i|
			if @unsolved_pattern[i] == letter
				possible_matches << 'o' 
				@matches_indexes << i
			end
		end

		possible_matches
	end

  def give_letter_feedback
  	possible_matches = []

  	remaining_guess.each do |letter|
  		possible_matches << 'x' if remaining_pattern.include?(letter)
  	end
		possible_matches
  end

  def remaining_guess
  	new_guess = @guess.clone
  	@matches_indexes.each do |position|
  		new_guess[position] = '+'
  	end

  	new_guess.uniq
  end

  def remaining_pattern
  	pattern = @unsolved_pattern.clone

  	@matches_indexes.each do |position|
  		pattern[position] = '-'
  	end

  	pattern
  end

	def generate_code_pattern
    letter_pool = ('A'..'F').to_a
    pattern = []

    1.upto(4) { pattern << letter_pool.sample }
    pattern
  end

end
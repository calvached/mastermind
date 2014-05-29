class CodeMaker
	attr_accessor :unsolved_pattern

	def feedback(guess)
		@guess = guess
		exact_feedback.concat(letter_feedback)
	end

	def exact_feedback
		@matches_indexes = []
		results = []

		@guess.each_with_index do |letter, i|
			if @unsolved_pattern[i] == letter
				results << 'o' 
				@matches_indexes << i
			end
		end

		results
	end

  def letter_feedback
  	results = []

  	get_unmatched(@guess, '+').uniq.each do |letter|
  	  results << 'x' if get_unmatched(@unsolved_pattern, '-').include?(letter)
  	end

		results
  end

  def get_unmatched(sequence, matched_placeholder)
  	new_sequence = sequence.clone

  	@matches_indexes.each do |position|
  		new_sequence[position] = matched_placeholder
  	end

  	new_sequence
  end

	def generate
		@unsolved_pattern = []

    1.upto(4) { @unsolved_pattern << letter_pool.sample }
  end

  def letter_pool
  	('A'..'F').to_a
  end

end
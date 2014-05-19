class CodeMaker
	attr_reader :unsolved_pattern, :solved_pattern

	def initialize
		@unsolved_pattern = generate_code_pattern
		@solved_pattern = false
	end

	def give_feedback(user_guess)
		unless user_guess.empty?
			return @solved_pattern = true if exact_match?(user_guess)
			letter_with_position_match(user_guess)
			letter_match(user_guess)
		else
			puts 'Invalid guess. Please try again. You may use 4 of the following letters: A, B, C, D, E, F.'
		end
	end

	private

	def exact_match?(user_guess)
		@unsolved_pattern == user_guess
	end

	def letter_with_position_match(user_guess)
		@indexes = []
		counter = []
		user_guess.each_with_index do |cb_letter, cb_i|
				if @unsolved_pattern.include?(cb_letter)
					@unsolved_pattern.each_with_index do |cm_letter, cm_i|
					  if cb_letter == cm_letter && cb_i == cm_i
					  	@indexes << cm_i
					  	counter << cb_letter 
					  end
					end
				end
			end

		puts "Correct letter with position: #{counter.length}"
	end

	def letter_match(user_guess)
		counter = []
		user_guess.uniq.each do |letter|
			counter << letter if unmatched_letters.include?(letter)
		end

		puts "Correct letter only: #{counter.length}"
	end

	def unmatched_letters
		mod_pattern = @unsolved_pattern.clone
		@indexes.reverse.each {|i| mod_pattern.delete_at(i) }
		mod_pattern
	end

	def generate_code_pattern
		array = ('A'..'F').to_a
		box = []

		1.upto(4) { box << array.sample }
		box
	end
end
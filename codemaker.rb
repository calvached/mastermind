
class CodeMaker
	attr_reader :unsolved_pattern, :solved_pattern
	attr_accessor :current_position_match, :current_letter_match

	def initialize
		@message = MessagesToCodeBreaker.new
		@unsolved_pattern = generate_code_pattern
		@solved_pattern = false
		@current_position_match = nil
		@current_letter_match = nil
	end

	def give_feedback(user_guess)
		unless user_guess.empty?
			return @solved_pattern = true if exact_match?(user_guess)

			@current_position_match = letter_with_position_match(user_guess)
			@current_letter_match = letter_match(user_guess)
			puts
		else
			@message.invalid_guess
		end
	end

	private

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

		counter.length
	end

	def letter_match(user_guess)
		# This sometimes works -_-
		counter = []
		user_guess.uniq.each do |letter|
			counter << letter if unmatched_letters.include?(letter)
		end

		counter.length
	end

	def exact_match?(user_guess)
		@unsolved_pattern == user_guess
	end

	def unmatched_letters
		mod_pattern = @unsolved_pattern.clone
		@indexes.reverse.each {|i| mod_pattern.delete_at(i) }
		mod_pattern
	end

	def generate_code_pattern
		letter_pool = ('A'..'F').to_a
		pattern = []

		1.upto(4) { pattern << letter_pool.sample }
		pattern
	end
end
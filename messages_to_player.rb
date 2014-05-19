class MessagesToCodeBreaker

	def intro_to_game
		puts '########################################'
		puts '# The CodeMaker has encoded a pattern. #' 
		puts '#     Will you be able to solve it?    #'
		puts '#  May the odds be ever in your favor. #'
		puts '#        Here are your options:        #'
		puts '#          [A, B, C, D, E, F]          #'
		puts '#                BEGIN!                #'
		puts '########################################'
	end

	def greeting
                                                        
		puts '###################################'
		puts '#     ~WELCOME TO MASTERMIND!~    #'
		puts '#          COMMAND LIST:          #'
		puts '#        1. How to play           #'
		puts '#        2. Play                  #'
		puts '#        3. Help                  #'
		puts '#        4. Exit                  #'
		puts '###################################'
	end

	def play_instructions
		puts '########################################################'
		puts '#                    ~INSTRUCTIONS~                    #'
		puts '# The CodeMaker will generate a random pattern         #'
		puts '# with 4 of the following letters: A, B, C, D, E, F.   #'
		puts '# Your job is to break the code (correct letters and   #'
		puts '# correct order) with the least number of guesses.     #'
		puts '# You will have a total of 10 pattern guesses each     #'
		puts '# game. After each guess the CodeMaker will provide    #'
		puts '# feedback by telling you how many guesses are correct #'
		puts '# in both letter and position and also how many        #'
		puts '# guesses are the correct letter, but in the wrong     #'
		puts '# position.                                            #'
		puts '#                                                      #'
		puts '# In order to submit a pattern guess you must first    #'
		puts '# enter 4 valid characters then press the [return] or  #'
		puts '# [enter] key.                                         #'
		puts '########################################################'
	end

	def quit_game
		puts 'Goodbye....for now'
	end

	def help
		puts "Invalid command. Press 3 for Help."
	end

	def invalid_guess
		puts 'Invalid guess. Please try again. You may use 4 of the following letters: A, B, C, D, E, F.'
	end

	def one_shot_wonder(num)
		puts "#{num} try, really? You're either really lucky or you cheated, either way I don't like you!"
	end

	def true_mastermind(num)
		puts "You have outwitted the CodeMaker in #{num} tries, you are a Mastermind!"
	end

	def not_too_shabby(num)
		puts "#{num} tries is not too shabby if I do say so myself."
	end

	def close_call(num)
		puts "Dude...it took you #{num} tries, for a second there I almost thought you wouldn't make it!"
	end
end
require 'random_word_generator'

class GameEnvSetup
	attr_accessor :correct, :wrong, :total, :question
	def initialize
		@correct = 0
		@wrong = 0
		@total = 0
		@question = ""
		@word = ""
	end

	def random_word

		@word = RandomWordGenerator.word

		if @word.nil? || @word == ""
			@word = "The Matrix"
		end

		@word

	end

end
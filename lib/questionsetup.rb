class QuestionSetup

	attr_accessor :questions
	def initialize array_of_movies
		@array = array_of_movies
		@random_integer = Random.new.rand(2)
		@questions = []

	end

	def randomize_question
		populate_questions_array(@array)
		question = questions[@random_integer]
	end

	def populate_questions_array array_of_movies
		@questions.push(["Which movie was released in " + (array_of_movies[@random_integer].year).to_s + " ?",array_of_movies[@random_integer].year])
		@questions.push(["In which movie was " + array_of_movies[@random_integer].cast_members[0] + " an actor?",array_of_movies[@random_integer].cast_members[0]])
	end

	def add_question question_answer_array
		@questions.push(question_answer_array)
	end

end

class ResultsParser
	attr_accessor :movie_clicked, :movie_attributes
	def initialize(movie_clicked,game_instance)
		@movie_clicked = movie_clicked
		@movie_attributes = []
		@game_instance = game_instance
	end

	def load_movie_attributes_for_selected_movie
		@movie_attributes.push(@movie_clicked.cast_members[0])
		@movie_attributes.push((@movie_clicked.year).to_s)
	end
	def validate_answer question, answer
		
		if answer.any? {|item| item == question[1]}
			@game_instance.correct += 1
			@game_instance.total +=1
			true
		else
			@game_instance.wrong += 1
			@game_instance.total += 1
			false
		end

	end

end
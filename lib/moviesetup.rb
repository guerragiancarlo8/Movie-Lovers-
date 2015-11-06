require 'imdb'

class MovieSetup
	attr_accessor :movies, :word
	def initialize word
		@movies = []
		@word = word
	end

	def query_imdb
		array_with_movie_objects = (Imdb::Search.new(@word)).movies
		array_with_movie_objects
	end

	def load_movies_into_movies_array

		count = 0

		query_imdb.each do |movie|
			if count < 9
				if !movie.poster.nil?
					@movies.push(movie)
					count+=1
				end
			end
		end
	end
end

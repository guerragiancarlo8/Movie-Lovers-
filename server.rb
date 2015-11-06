require 'sinatra'

require 'rspec'

require 'imdb'

require 'random_word_generator'

require_relative './lib/gameenvsetup.rb'

require_relative './lib/moviesetup.rb'

require_relative './lib/questionsetup.rb'

require_relative './lib/resultsparser.rb'


game = GameEnvSetup.new


get '/' do

	erb(:search)

end

post '/search' do


	movies = MovieSetup.new(game.random_word)

	movies.load_movies_into_movies_array

	question = QuestionSetup.new(movies.movies)

	@question = question.randomize_question
	#esto ahora es un doble array, [0] = pregunta, [1] = respuesta
	game.question = @question

	@movies = movies.movies

	erb(:results)
end

post '/result' do

	results_parser = ResultsParser.new((Imdb::Movie.new(params['answer'])),game)
	
	results_parser.load_movie_attributes_for_selected_movie

	if results_parser.validate_answer(game.question,results_parser.movie_attributes)
		erb(:success)
	else
		erb(:failure)
	end
end

=begin
	results_parser.validate_answer(game.question,)
	if pregunta.include? "was released in"

		if pregunta.include? (movie_clicked.year).to_s
			correct+=1
			total+=1
		else
			wrong+=1
			total+=1
		end

		if pregunta.include? (movie_clicked.year).to_s
			erb(:success)
		else
			erb(:failure)
		end

	elsif pregunta.include? "an actor"

		if movie_clicked.cast_members.any? {|actor| pregunta.include? actor}
			correct+=1
			total +=1
		else
			wrong+=1
			total+=1
		end

		if movie_clicked.cast_members.any? {|actor| pregunta.include? actor}
			erb(:success)
		else
			erb(:failure)
		end
	end
=end


get '/final' do
	@game = game
	erb(:final)
end

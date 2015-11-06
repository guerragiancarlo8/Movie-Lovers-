require 'sinatra'

require 'rspec'

require 'imdb'

get '/' do

	#asks for word on input field

	erb(:search)

end

post '/search' do


	i = Imdb::Search.new(params['movie'])

	array_of_movies = i.movies

	@movies = []

	count = 0

	array_of_movies.each do |movie|
		if count < 9
			if !movie.poster.nil?
				@movies.push(movie)
				count += 1
			end
		end
	end

	erb(:results)
end


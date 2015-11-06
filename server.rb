require 'sinatra'

require 'rspec'

require 'imdb'

require 'random_word_generator'

rand_word = RandomWordGenerator.word
pregunta = ""
correct=0
wrong=0
total=0



get '/' do

	erb(:search)

end

post '/search' do

	puts rand_word
	i = Imdb::Search.new(rand_word)
	#Imdb::Search.new(RandomWordGenerator.word)


	array_of_movies = i.movies
	@movies = []

	#@movies = array_of_movies[0,8].map{|x| x if !x.poster.nil? }

	count = 0
	array_of_movies.each do |movie|
		if count < 9
			if !movie.poster.nil?
				@movies.push(movie)
				count += 1
			end
		end
	end

	random_integer = Random.new.rand(9)

	questions = ["Which movie was released in "+ (array_of_movies[random_integer].year).to_s+ " ?","In which movie was " + array_of_movies[random_integer].cast_members[0] + " an actor?"]

	puts array_of_movies[random_integer].title
	@question = questions[Random.new.rand(2)]
	pregunta = @question
	erb(:results)
end

post '/result' do
	movie_clicked = Imdb::Movie.new(params['answer'])
	
	puts "la pregunta es " + pregunta
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

end

get '/final' do
	@correct = correct.to_s
	@wrong = wrong.to_s
	@total = @correct + "/" + total.to_s
	erb(:final)
end

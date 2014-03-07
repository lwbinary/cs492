class MoviesController < ApplicationController

	def index
		@movies = Movie.all
	end

	def show
		id = params[:id]
		@movie = Movie.find(id)
	end

	def create
		#debugger
		logger.debug("MoviesController create movie...........>#{params.inspect}")
		@movie = Movie.new(movie_params)
		if @movie.save
			flash[:notice] = "Movie \"#{@movie.title}\" was successfully created."
			#instead of create a create view, we'd like to go to the movie list page after created a movie
			redirect_to movies_path
		else
			render 'new' # new template can access @movie's field, @movie available to the view and hold value entered first time
		end
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_params)
			flash[:notice] = "'#{@movie.title}' updated."
			redirect_to movie_path(@movie)
			#respond_to do |format|
				#format.html {redirect_to movie_path(@movies)}
				#format.xml {render xml: @movie.to_xml}
			#end
		else
			render 'edit'
		end
	end

	def new
		@movie = Movie.new
	end

	def edit
		id = params[:id]
		@movie = Movie.find(id)
	end

	def destroy
		id = params[:id]
		@movie = Movie.find(id)
		@movie.destroy
		flash[:notice] = "'#{@movie.title}' deleted."
		redirect_to movies_path
	end

	private
	def movie_params
		params.require(:movie).permit(:title, :rating, :description, :release_date)
	end
end

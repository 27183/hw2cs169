class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index_by_title
    @movies = Movie.order(:title)
    @hilight = :title
  end

  def index_by_release
    @movies = Movie.order(:release_date)
    @hilight = :release
  end
   
  def sort_by_title
    @movies = Movie.order(:title)
  end
  def sort_by_release
    @movies = Movie.order(:release_date)
  end

  def index
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    vals = @all_ratings
    vals = params[:ratings].keys if params[:ratings]
    @selected_ratings = vals
    @movies = Movie.where(:rating => vals)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

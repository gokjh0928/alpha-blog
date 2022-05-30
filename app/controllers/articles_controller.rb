class ArticlesController < ApplicationController

    def show
        # Instance variable which is passed to the show.html.erb view for use
        @article = Article.find(params[:id])
    end

    def index
        # Grab all articles from the Articles table and send to index.html.erb for use
        @articles = Article.all
    end
end
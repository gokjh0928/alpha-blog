class ArticlesController < ApplicationController

    def show
        # Instance variable which is passed to the show.html.erb view for use
        @article = Article.find(params[:id])
    end
end
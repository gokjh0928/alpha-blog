class ArticlesController < ApplicationController

    def show
        # Instance variable which is passed to the show.html.erb view for use
        @article = Article.find(params[:id])
    end

    def index
        # Grab all articles from the Articles table and send to index.html.erb for use
        @articles = Article.all
    end

    def new
        # instantiate new article to prevent errors on first time loading new.html.erb
        # we're flashing errors present in @article so we need at least an empty @article to exist to allow this code
        @article = Article.new
    end
    
    def edit
        # get the article to edit from params hash
        @article = Article.find(params[:id])
    end

    def create
        # require sets requirement for article key from param
        # permit whitelists fields within the hash associated with the article key
        @article = Article.new(params.require(:article).permit(:title, :description))
        # render plain: @article.inspect

        if @article.save
            # ruby extracts id from @article and uses it for the /article path 
            # the format of the article_path is /articles/:id(.:format), as we see in rails routes --expanded
            flash[:notice] = "Article was created successfully" # make sure flashed messages are rendered in application.html.erb since it's common amongst all views
            redirect_to @article # is shortcut for "redirect_to article_path(@article)"
        else
            # if failing to save the article in the database, then render 'new' template again
            # status: :unprocessable_entity is bc the turbo library doesn't like 200 responses from POST form submissions
            render 'new', status: :unprocessable_entity
        end
    end

    def update
        # now update the article using the updated params passed in from the edit action
        @article = Article.find(params[:id])
        # require sets requirement for article key from param("article"=>{"title"=>"first article", "description"=>"edited description of first article"})
        # permit whitelists fields within the hash associated with the article key
        if @article.update(params.require(:article).permit(:title, :description))
            # ruby extracts id from @article and uses it for the /article path 
            # the format of the article_path is /articles/:id(.:format), as we see in rails routes --expanded
            flash[:notice] = "Article was updated successfully" # make sure flashed messages are rendered in application.html.erb since it's common amongst all views
            redirect_to @article # is shortcut for "redirect_to article_path(@article)"
        else
            # if failing to save the article in the database, then render 'new' template again
            # status: :unprocessable_entity is bc the turbo library doesn't like 200 responses from POST form submissions
            render 'edit', status: :unprocessable_entity
        end
    end
end
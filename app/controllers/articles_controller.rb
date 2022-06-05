class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  # GET
  def show
    # set_article done here
  end
  
  # GET
  def index
    # Grab all articles from the Articles table and send to index.html.erb for use
    @articles = Article.all
  end
  
  # GET
  def new
    # instantiate new article to prevent errors on first time loading new.html.erb
    # we're flashing errors present in @article so we need at least an empty @article to exist to allow this code
    @article = Article.new
  end
  
  # GET
  def edit
    # get the article to edit from params hash(set_article)
  end
  
  # POST
  def create
    # require sets requirement for article key from param
    @article = Article.new(article_params)
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
  
  # PATCH/PUT
  def update
    # update article using updated params passed in from the edit action(set_article)
    
    # require sets requirement for article key from param("article"=>{"title"=>"first article", "description"=>"edited description of first article"})
    if @article.update(article_params)
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
  
  # DELETE
  def destroy
    @article.destroy
    # articles_path goes to the index action
    redirect_to articles_path, status: :see_other
  end
  
  private
  def set_article
    # Instance variable which is passed to the show.html.erb view for use
    @article = Article.find(params[:id])
  end
  
  def article_params
    # permit whitelists fields within the hash associated with the article key
    params.require(:article).permit(:title, :description)
  end
end
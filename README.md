# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Notes on building Rails application:
- config/routes.rb contains the routes(acts as router)
- CONTROLLER_NAME#ACTION_NAME routes to the proper controller and action
- Resource routing is Rails default to declare all common routes for GET, POST, PATCH/PUT, DELETE
- Resouce routing example: "resources :articles, only: [:show]" will create a GET route where it creates a Controller#Action of articles#show
- Note: we still need to create an ArticlesController(articles_controller.rb), the corresponding actions, and the corresponding views(create a 'articles' folder and 'show.html' within it for the above example) for the created routes above

- can create new controller using command "rails generate controller CONTROLLER_NAME"
- root CONTROLLER_NAME#ACTION_NAME will define the root path
- the controller accesses the views that will be sent back to user
- all additional controllers made will inherit/subclass from the default application_controller.erb
- when action in controller doesn't explicitly render a view, it will find a view that matches the name of the controller and action(i.e. pages_controller with an empty home action would render views/pages/home)
- to get specific parameters from the url for the action, you can use "params"(a hash data structure) to get the parameters(i.e. "@article = Article.find(params[:id])" will get the id 1 from /articles/1 and create an instance variable of @article which is available to the view template) 
- in the view template, use <%= @article.title %> to get the above article variable's title field(remember to include the '=' since that specifies to display as <%%> only evaluates)

- views are in views folder
- app/assets stores static assets(images, stylesheets)
- the html.erb files will link to the assets/stylesheets folder with "stylesheet_link_tag"
- views/layouts/application.html.erb file is where all views are served through in Rails application(all other views show up in the "yield" part in the body of this file)

- channels folder allows for real time communication

- helpers folder contains helper functions used for views templates ONLY

- javascript folder contains packs/application.js, which is the main JS file made for use throughout application "javascript_pack_tag"



- config/environment specifies different configurations for different environments(development, production, test)
- config/routes acts as the router(used a lot!)

- db folder contains the sqlite3 database stuff
- db folder contains schema files containing details of tables
- models/application_record.rb contains ApplicationRecord which inherits from ActiveRecord, the ORM(Object Relational Mapper) that is responsible for communicating between database and Rails app(think it's like SQLAlchemy for Flask)
- rails generate scaffold will generate a scaffold, which creates:
    * a migration file in db/migrate
    * a model in app/models
    * tests
    * a bunch of routes(expressed as 1 line in routes.rb but can check using "rails routes --expanded" command)
    * a controller
    * a bunch of views
- run the migration file to create the table(rails db:migrate), which we can see generates a schema in db/schema.rb
- Creating the tables from scratch:
    * "rails generate migration name_here" creates migration file in db/migrate with timestamp in name(used 'rails generate migration create_articles)
    * note: Rails will not run migration files that have been run already(through 'rails db:migrate')
    * after running migration file, schema.rb will be generated with a table(can see it contains create_table "articles" since Rails inferred we wanted to create a table named "articles" from create_articles) 
    * changing migration file to make changes in the table will not do anything even when trying to run it
    * one method(not preferred) is to do a rollback('rails db:rollback')
        + can see that the rollback reverts the creation of the table, so we can make changes to migration file in order to create new table with rails db:migrate
        + why this is not preferred: working as a team, code repositories are shared and migration files will be run on their files too, thus changes in the migration file will not be reflected on their database since that migration file was already run on their end previously and will lead to sync issues
    * preferred method: new migration file
        + did "rails generate migration add_timestamps_to_articles"(which Rails didn't know how to infer so didn't do any default behavior)
        + we want to add a timestamps column to the articles table so we use "add_column :articles, :created_at, :datetime"
        + for add_column, the input structure is as follows: "add_column :TABLE_NAME, :ATTRIBUTE_NAME, :DATATYPE"
        + can see changes reflected in the schema file
    * now create article.rb in app/models which inherits from ApplicationRecord and define Article class
    * can connect to articles table with "rails c"(c meaning console)
    * can use ctrl+l to go to the top of the console(like clear in terminal)
    * Article.all will do a SQL like query and get all Articles in table
    * Not preferred way to create article is with Article.create(), which creates an article in the table given the input parameters(like title and description but no timestamp parameters since that's done automatically)
    * Preferred way is to create a variable and assign to it a new Article object(article = Article.new), then use getters and setters to initialize attributes(like article.title = "Insert title here"), and we will upload this onto the database table through 'article.save'
    * Until we upload article onto the table with the .save, id and the timestamped variables will be seen as nil
    * Another way is to do article=Article.new(title: "title", description: "description here") and do article.save
    * Article.find(ID_NUMBER): get the article with that specific ID
    * Article.first gets first article in table, Article.last gets last article in table
    * Can alter article in the Article table by creating a variable(i.e. article = Article.find(2)) then editing fields inside it(i.e. article.title = "new title"), but remember to reflect this change in the database, you need to call the .save method(i.e. article.save)
    * "article.destroy" will destroy the article and reflect the change immediately in the database without the .need for the save method
    * do "exit" in the console to exit it
- models folder stores all models, with all models extending or inheriting("<") from the default application_record.erb file
    * Can set "validations" in model file to ensure some fields/columns are inputted when creating the record instead of being null
    * Done in the model file to validate specific fields(i.e. 
    "validates :title, presence: true, length: { minimum: 6, maximum: 100 }" 
    in the article.rb file for the Articles table in above database section, which ensures there needs to be a title of length 6~100) --> a created article without the necessary fields will have article.save return false, and we can see the error message in article.errors.full_messages
    * Do "reload!" in the console if you want it to reflect most recent change in the models without having to leave and reenter it



- Gemfile is essentially a requirements.txt file
- Gemfile.lock contains the dependencies, works in-hand with Gemfile
- package.json contains dependencies with Yarn


Rails Naming Conventions
- Model: 
    * name = 'article' (singular)
    * file name = 'article.rb'
    * class name = 'Article'
- Table: 
    * name = 'articles' (plural)






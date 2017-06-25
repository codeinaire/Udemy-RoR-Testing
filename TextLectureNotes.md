# Section 2, Lecture 30



Let’s deal with the case where there are no articles in the db.

Add the following scenario to the listing_articles_spec file:

scenario "A user has no articles" do
Article.delete_all
visit "/"
expect(page).not_to have_content(@article1.title)
expect(page).to have_content(@article1.body)
expect(page).to have_content(@article2.title)
expect(page).to have_content(@article2.body)
expect(page).to have_link(@article1.title)
expect(page).to have_link(@article2.title)
within ("h1#no-articles") do
expect(page).to have_content("No Articles Created")
end
end

When run, it fails with the error:
Failure/Error: within ("h1#no-articles") do
Capybara::ElementNotFound:
Unable to find css "h1#no-articles"

Modify index.html.erb like below to include this:
<% if @articles.empty? %>
<h1 id="no-articles">No Articles Created</h1>
<% else %>
<% @articles.each do |article| %>
<div class="well well-lg article-detail">
<div class="article-title">
<%= link_to article.title, article_path(article) %>
</div>
<div class="article-body">
<%= article.body %>
</div>
</div>
<% end %>
<% end %>

And with this all tests pass.
Commit/merge and push to Github ->
git add -A
git commit -m "Implement displaying a message when no articles are created."
git checkout master
git merge listing-articles
git push


# Section 2, Lecture 29

First create a topic branch for listing articles ->

git checkout -b listing-articles
Next create the feature spec called listing_article_spec.rb:
require "rails_helper"
RSpec.feature "Listing Articles" do
before do
@article1 = Article.create(title: "The first article",
body: "Lorem ipsum dolor sit amet, consectetur.")
@article2 = Article.create(title: "The second article",
body: "Pellentesque ac ligula in tellus feugiat.")
end

scenario "A user lists all articles" do

visit "/"
expect(page).to have_content(@article1.title)
expect(page).to have_content(@article1.body)
expect(page).to have_content(@article2.title)
expect(page).to have_content(@article2.body)
expect(page).to have_link(@article1.title)
expect(page).to have_link(@article2.title)
end
end

We get the following error:
Failure/Error: expect(page).to have_content(@article1.title) expected to find text "The first article" in "Blog App New Articl....

Write code to display the list of articles in the article’s index.html.erb file in the app/views/articles folder like below:

<%= link_to "New Article", new_article_path, class: "btn btn-defaul btn-lg", id: "new-article-btn" %>
<% @articles.each do |article| %>
<div class="well well-lg">
<div class="article-title">
<%= article.title %>
</div>
<div class="article-body">
<%= article.body %>
</div>
</div>
<% end %>

When the specs run, they fail with messages such as:
Failure/Error: <% @articles.each do |article| %>
ActionView::Template::Error:
undefined method `each' for nil:NilClass

This suggests that the @articles variable is not defined. Define it in the articles_controller.rb file:

def index
@articles = Article.all
end

When the spec runs again it fails with this message:
Failure/Error: expect(page).to have_link(@article1.title)
expected to find link "The first article" but there were no
matches

The title is supposed to be a link so it should be changed to this:
<div class="article-title">
<%= link_to article.title, article_path(article) %>
</div>

The tests are now passing

Update the index.html.erb to display article body, truncated to 500 characters max like below:

<div class="article-body">
<%= truncate(article.body, length: 500) %>
</div>

Add the following styles to custom.css.scss:
// Listing articles styling

.article-title {
  font-weight: bold;
  font-size: 2.5em;
  margin-bottom: 0.8em;
  padding-left: 0.7em;
}

.article-body {
  font-size: 1.5em;
  padding-left: 1.2em;
  color: #64103F;

}

.author {
  color: #64103F;
  padding-left: 25px;
}

// .article-title {
//
// }

.article-detail {
  margin-top: 20px;
  color: #0000ff;
}

We want the most recent article to show up on top so add the following to your app/models/article.rb file:
default_scope { order(created_at: :desc) }

```

# Section 2, Lecture 25

Add the following styles to custom.css.scss:

body {
  padding-top: 80px;
  background: #e1e1e1;
  color: #64103F;
}

// Navbar styling
.navbar {
 background: #64103F;
 padding-bottom: 20px;
}

.navbar-default .navbar-brand {
  padding-top: 25px;
  font-size: 150%;
  font-weight: bold;
  color: #ffffff;
}

.navbar-default .navbar-brand:hover {
  color: #ff0000;
}

.navbar-default {
  border: #64103F;
}

.navbar-nav {
  padding-top: 10px;
  padding-right: 20px;
}

.navbar-default .navbar-nav li > a {
  font-weight: bold;
  font-size: 130%;
  color: #ffffff;
}

.navbar-default .navbar-nav li > a:hover {
  color: #ff0000;
}

// Form styling
.page-heading, div > label {
  color: #64103F;
}

Update the create action in the articles_controller to change flash to flash.now
def create
@article = Article.new(article_params)
if @article.save
flash[:success] = "Article has been created"
redirect_to articles_path
else
flash.now[:danger] = "Article has not been created"
render :new
end
end

Make a commit:
git add -A
git commit -m "Complete article validations and flash"
git checkout master
git merge article-validation
git push


# Section 2, Lecture 25

Create a new git branch as follows:

git checkout -b article-validation
Start guard in a new terminal like below:
guard

Add a new scenario to creating_article_spec.rb file to test for failure
Add the scenario like below:
scenario "A user fails to create a new article" do
visit "/"
click_link "New Article"
fill_in "Title", with: ""
fill_in "Body", with: ""
click_button "Create Article"
expect(page).to have_content("Article has not been created")
expect(page).to have_content("Title can't be blank") expect(page).to have_content("Body can't be blank")
end

Guard’s output should give the error that says
Failure/Error: expect(page).to have_content("Article has not been created")
expected to find text "Article has not been created" in "Blog App Article has been created New Article"
This is because there is no failure path. Modify controller create action to this:

def create
@article = Article.new(article_params)
if @article.save
flash[:success] = "Article has been created"
redirect_to articles_path
else
flash[:danger] = "Article has not been created"
render :new
end
end

Results of run (whether from Guard or manually) should be the same as the previous error message because validations are not in place.

Add Validation -> Open the file app/models/article.rb and change it to this:
class Article < ActiveRecord::Base
validates :title, presence: true
validates :body, presence: true
end

When tests run again they fail with the message:
Failure/Error: expect(page).to have_content("Title can't be blank") expected to find text "Title can't be blank"...

Now we have to add this error porton to the new form template directly below form_for:
￼￼￼
￼￼￼￼￼
<% if @article.errors.any? %>
<div class="panel panel-danger col-md-offset-1">
<div class="panel-heading">
<h2 class="panel-title">
<%= pluralize(@article.errors.count, "error") %>
prohibited this article from being saved: </h2>
<div class="panel-body">
<ul>
<% @article.errors.full_messages.each do |msg| %>
<li>
<%= msg %>
</li>
<% end %>
</ul>
</div>
</div>
</div>
<% end %>

# Section 2, Lecture 20

The final Guardfile after the updates is below, some comments have been removed, you can also get this from the github repo of the course at

https://github.com/udemyrailscourse/bdd_course_rails5/blob/master/Guardfile

cucumber_options = {
  # Below are examples overriding defaults

  # cmd: 'bin/cucumber',
  # cmd_additional_args: '--profile guard',

  # all_after_pass: false,
  # all_on_start: false,
  # keep_failed: false,
  # feature_sets: ['features/frontend', 'features/experimental'],

  # run_all: { cmd_additional_args: '--profile guard_all' },
  # focus_on: { 'wip' }, # @wip
  # notification: false
}

guard "cucumber", cucumber_options do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { "features" }

  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "features"
  end
end

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'

guard :rspec, cmd: "rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { "spec/features" }
  watch(%r{^app/models/(.+)\.rb$})  { "spec/features" }
  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      rspec.spec.call("acceptance/#{m[1]}")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "spec" } # { "#{rspec.spec_dir}/routing" }  
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { "spec/features" } # { |m| rspec.spec.call("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end
end

Important additions that were made were the two lines below in the # Rails files section:
watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { "spec/features" }
watch(%r{^app/models/(.+)\.rb$})  { "spec/features" }

The two updates were also made, first in the # Rails config changes section:
watch(rails.routes)          { "spec" } # { "#{rspec.spec_dir}/routing" }

The last update was made in the # Capybara features specs section:
watch(rails.view_dirs)     { "spec/features" } # { |m| rspec.spec.call("features/#{m[1]}") }

# Section 2 Lecture 20

Create a new git topic branch as follows:

git checkout -b adding-guard

Add the following gems to the development group of the Gemfile:
gem 'guard', '~> 2.14.0'
gem 'guard-rspec', '~> 4.7.2'
gem 'guard-cucumber', '~> 2.1.2'

Run the following command to install the gems:
bundle install

Also run the command:
guard init

Run the command:
bundle binstubs guard

Run:
cucumber --init

Make a commit:
git add -A
git commit -m "Add Guard"
git checkout master
git merge adding-guard
git push

# Section 2 Lecture 19

Add Bootstrap
In the Gemfile add the following gems:
gem 'bootstrap-sass', '~>3.3.6'
gem 'autoprefixer-rails', '~>6.3.7'

Run:
bundle install

Go the the stylesheets folder under the assets folder and create a new file called
custom.css.scss and add the following to it:
@import "bootstrap-sprockets";
@import "bootstrap";

Also add the following to the application.js file in the assets/javascript folder under the line that says require jquery_ujs:

//= require bootstrap-sprockets

Navigate to app/views/layouts/application.html.erb and add a navigation bar in the body tag:
<header role="banner">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
<div class="container-fluid">
<div class="navbar-header">
<button type="button" class="navbar-toggle" data-toggle="collapse"
data-target="#bs-example-navbar-collapse-1">
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<%= link_to "Blog App", root_path, class: "navbar-brand" %>
</div>
<div class="navbar-collapse collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav">
<li class="active"><%= link_to "Authors", "#" %></li>
</ul>
</div>
</div>
</nav>
</header>
<div class="container">
<div class="row">
<div class="col-md-12">
<% flash.each do |key, message| %>
<div class="text-center alert alert-<%= key == 'notice'? 'success': 'danger' %>">
<%= message %>
</div>
<% end %>
<%= yield %>
</div>
</div>
</div>

Make a commit:
git add -A
git commit -m "Setup bootstrap and navbar"
git push

# Section 2 Lecture 18

Generate an article model:

rails g model article title:string body:text

To run the migration file that's created, run the following command:
rails db:migrate

This time the error message says to create the create action in Articles Controller
Create the action, and the article_params method under private like below:

def create
@article = Article.new(article_params)
@article.save
flash[:success] = "Article has been created"
redirect_to articles_path
end

private
def article_params
params.require(:article).permit(:title, :body)
end

Running the rspec again fails with this message:
Failure/Error: expect(page).to have_content("Article has been created") expected to find text "Article has been created" in "New Article"
Can’t find flash message. Add flash messaging to the app/views/layouts/application.html.erb file:

<% flash.each do |key, message| %>
<div class="text-center alert alert-<%= key == 'notice'? 'success': 'danger' %>">
<%= message %>
</div>
<% end %>

Run rspec again and this time it passes.

Make a commit and merge code:

git add -A
git commit -m "complete article feature"
git checkout master
git merge article-feature-success
git push

# Section 2 Lecture 16

Go to app/views/articles/index.html.erb and remove the existing content from it

Add the line below and save it:
<%= link_to "New Article", new_article_path %>

This time it fails with this error message:
￼￼￼ActionView::Template::Error:
undefined local variable or method `new_article_path' for ...

Add the path by adding resources in the config/routes.rb file:
resources :articles

Save and when the spec is run again it gives this error message:
Failure/Error: click_link "New Article" AbstractController::ActionNotFound:
The action 'new' could not be found for ArticlesController
￼￼￼￼
So add the new action to articles_controller.rb file:
def new
end

It fails with this error:
Failure/Error: click_link "New Article" ActionController::UnknownFormat:
ArticlesController#new is missing a template for ...

Add the new article template in the app/views/articles/new.html.erb file (create the file):

<h3 class='text-center'>Adding New Article</h3>
<div class='row'>
<div class='col-md-12'>
<%= form_for(@article, :html => {class: "form-horizontal", role: "form"}) do |f| %>
<div class='form-group'>
<div class='control-label col-md-1'>
<%= f.label :title %>
</div>
<div class='col-md-11'>
<%= f.text_field :title, class: 'form-control', placeholder: 'Title of article', autofocus: true %>
</div>
</div>
<div class='form-group'>
<div class='control-label col-md-1'>
<%= f.label :body %>
</div>
<div class='col-md-11'>
<%= f.text_area :body, rows: 10, class: 'form-control', placeholder: 'Body of article' %>
</div>
</div>
<div class='form-group'>
<div class='col-md-offset-1 col-md-11'>
<%= f.submit class: 'btn btn-primary btn-lg pull-right' %>
</div>
</div>
<% end %>
</div>
</div>

In the new action of articles_controller.rb file add the following:

def new
  @article = Article.new
end

```

# Section 2, Lecture 14

Create Article Feature Test -

Create a topic branch:
git checkout -b article-feature-success

Create a folder called features under spec directory:
mkdir spec/features

In that folder create a new file called creating_article_spec.rb:
Open that file and add the following:

require "rails_helper"
RSpec.feature "Creating Articles" do
scenario "A user creates a new article" do
visit "/"
click_link "New Article"
fill_in "Title", with: "Creating a blog"
fill_in "Body", with: "Lorem Ipsum"
click_button "Create Article"
expect(page).to have_content("Article has been created")
expect(page.current_path).to eq(articles_path)
end
end

Now save the file type this to run the spec (or you can just type rspec to run all specs):
rspec spec/features/creating_article_spec.rb

You get a routing error that suggests to create a root path
Update the routes.rb file in the config folder like below:
root to: "articles#index"

Now save and run rspec spec/features/creating_article_spec.rb
again.
You get an error that says: Uninitialized constant ArticlesController. This suggests to create the Articles Controller

Generate an articles controller with an index action by issuing the following command:
rails g controller articles index

Remove the get 'articles/index' line from the routes.rb file

Save￼ and run rspec again.
The next error message suggests to add the "New Article" link

# Section 2, Lecture 12

Install RSpec and Capybara

In the Gemfile add the needed gems in their specific groups as follows:

group :development, :test do
gem 'rspec-rails', '3.1.0'
end

group :test do
gem 'capybara', '2.7.1'
end

Then run:
bundle install

Now run the rspec install generator:
rails generate rspec:install

Generate a stub for RSpec:
bundle binstubs rspec-core

Make a git commit and push to Github:
git add -A
git commit -m "Setup RSpec and Capybara"
git push

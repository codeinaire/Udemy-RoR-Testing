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

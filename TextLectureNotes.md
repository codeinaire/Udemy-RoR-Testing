#Section 2 Lecture 16

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

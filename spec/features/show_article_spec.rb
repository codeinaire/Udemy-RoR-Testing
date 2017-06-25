require "rails_helper"

RSpec.feature "Showing an article:" do

  before do
    @john = User.create(email: "test@subject.com", password: "password")
    @secondUser = User.create(email: "test1@subject.com", password: "password")
    @article = Article.create(title: "The first article", body: "Lorem ipsum dolor sit amet, consectetur", user: @john)
  end

  scenario "to non-signed in user hide the Edit and Delete buttons" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to non-owner in user hide the Edit and Delete buttons" do
    login_as(@secondUser)
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

end

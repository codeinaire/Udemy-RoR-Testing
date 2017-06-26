require "rails_helper"

RSpec.feature "Adding comments to articles:" do
  before do
    @john = User.create(email: "test@subject.com", password: "password")
    @secondUser = User.create(email: "test1@subject.com", password: "password")
    @article = Article.create(title: "The first article", body: "Lorem ipsum dolor sit amet, consectetur", user: @john)
  end

  scenario "permits a signed in user to write a comment" do
    login_as(@secondUser)

    visit "/"

    click_link @article.title
    fill_in "New Comment", with: "An amazing article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing article")
    expect(current_path).to eq(article_path(@article.id))
  end

end

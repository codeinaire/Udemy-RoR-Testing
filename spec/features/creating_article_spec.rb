# NOTE - this is required for any test file because the required file contains config settings.
require "rails_helper"

# NOTE - this is in 13.1
RSpec.feature "Creating Articles:" do

  before do
    @john = User.create(email: "test@subject.com", password: "password")
    login_as(@john)
  end

  scenario "A user creates a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"

    click_button "Create Article"

    expect(Article.last.user).to eq(@john)
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@john.email}")
  end

  scenario "A user fails to create a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Create Article"

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")

  end
end

# NOTE - this is required for any test file because the required file contains config settings.
require "rails_helper"

# NOTE - this is in 13.1
RSpec.feature "Creating Articles:" do
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

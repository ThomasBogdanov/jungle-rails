require 'rails_helper'

RSpec.feature "Visitor navigates to Details page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "They see all products" do
    visit root_path

    first(:link, "Details").click

    # first('.actions', :visible => false).find_link("Details").click

    # first(:xpath, "//a[@href='/products/1']").click

    expect(page).to have_css('.products-show')
    # expect(page).to have_css 'section.products-show', :visible => false

    # commented out b/c it's for debugging only
    save_and_open_screenshot

  end
end
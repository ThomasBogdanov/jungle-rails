require 'rails_helper'

RSpec.feature "Clicking Add increases My Cart by 1", type: :feature, js: true do
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

    # first(:link, "Add").click

    first('.actions', :visible => false).click_link_or_button("Add")

    expect(page).to have_content('My Cart (1)')


    # commented out b/c it's for debugging only
    save_and_open_screenshot
  end
end

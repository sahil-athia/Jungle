require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do

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

  scenario "They see the product details" do
    # ACT
    visit root_path
    
    # there sould be 10 since we are loading 10 products in the "before"
    expect(page).to have_css 'article.product', count: 10

    # click on the first product cards header (which contains a link)
    page.find(".product",  match: :first).find("header").double_click

    # if the link is clicked sucessfully, there sould be a products-show
    expect(page).to have_css 'section.products-show'

    # DEBUG / VERIFY
    save_screenshot("product_description_page.png")

  end

end
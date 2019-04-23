require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
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

  scenario "Cart is updated when add item to cart" do
    visit root_path

    product = page.find('article.product:first-child')
    #name = product.find('h4').text

    product.find('.actions > form.button_to').click

    # DEBUG
    save_screenshot # index page
    nav_bar = page.find :link, 'My Cart', href: '/cart'
    expect(nav_bar).to have_content('My Cart (1)')
    save_screenshot 'add_to_cart.png' #detail page
  end
end

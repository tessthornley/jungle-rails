require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "User can navigate from home page to product detail by clicking on a product" do
    visit root_path

    product = page.find('article.product:first-child')
    name = product.find('h4').text

    product.find('.actions > a.btn-default').click

    # DEBUG
    save_screenshot # index page
    expect(page).to have_css('.products-show .page-header h1')
    title = page.find('.products-show h1')
    expect(title.text).to end_with(name)
    save_screenshot 'detail_page1.png' #detail page
  end
end

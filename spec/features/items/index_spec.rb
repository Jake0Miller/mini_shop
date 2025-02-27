require 'rails_helper'

RSpec.describe 'Items index page', type: :feature do
  describe 'when a user visits the index page' do
    it 'user can see all items' do
      merchant_1 = Merchant.create!(name: 'Bob', address: '400 W 10th', city: 'Denver', state: 'CO', zip: '80204')
      merchant_2 = Merchant.create!(name: 'Roy', address: '601 W 11th', city: 'Chicago', state: 'IL', zip: '50291')
      item_1 = merchant_1.items.create!(name: 'iPhone', description: 'A phone', price: 999.99, image: 'iphone.jpg', active: true, inventory: 1000)
      item_2 = merchant_2.items.create!(name: 'Snuggie', description: 'Not a blanket', price: 4.99, image: 'snuggie.jpg', active: true, inventory: 7)

      visit items_path

      within('.title') { expect(page).to have_content("All Items") }
      within("#item-#{item_1.id}") do
        expect(page).to have_link(item_1.name)
        expect(page).to have_content(item_1.description)
        expect(page).to have_link(merchant_1.name)
      end
      within("#item-#{item_2.id}") do
        expect(page).to have_link(item_2.name)
        expect(page).to have_content(item_2.description)
        expect(page).to have_link(merchant_2.name)
      end
    end

    it 'user can see nav bar' do
      visit items_path

      within('.nav-1') do
        expect(page).to have_button("Merchants")
        expect(page).to have_button("Items")

        click_on "Merchants"

        expect(current_path).to eq(merchants_path)
      end
    end

    it 'user can see nav bar' do
      visit items_path

      within('.nav-1') do
        expect(page).to have_button("Merchants")
        expect(page).to have_button("Items")

        click_on "Items"

        expect(current_path).to eq(items_path)
      end
    end
  end
end

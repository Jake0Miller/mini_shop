require 'rails_helper'

RSpec.describe 'Merchant Items page', type: :feature do
  describe 'when a user visits merchants/:id/items' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'Bob', address: '400 W 10th', city: 'Denver', state: 'CO', zip: '80204')
    end

    it 'user can see all items belonging to that merchant' do
      merchant_2 = Merchant.create!(name: 'Roy', address: '601 W 11th', city: 'Chicago', state: 'IL', zip: '50291')
      item_1 = @merchant_1.items.create!(name: 'iPhone', description: 'A phone', price: 999.99, image: 'iphone.jpg', active: true, inventory: 1000)
      item_2 = merchant_2.items.create!(name: 'Snuggie', description: 'Not a blanket', price: 4.99, image: 'snuggie.jpg', active: true, inventory: 7)
      item_3 = @merchant_1.items.create!(name: 'Zebra', description: 'Not a horse', price: 5000, image: 'horse.jpg', active: true, inventory: 1)

      visit merchant_items_path(@merchant_1)

      within('.title') do
        expect(page).to have_content("All Items for #{@merchant_1.name}")
      end
      within("#item-#{item_1.id}") do
        expect(page).to have_link(item_1.name)
        expect(page).to have_content(item_1.description)
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(item_2.name)
        expect(page).to_not have_content(item_2.description)
      end
      within("#item-#{item_3.id}") do
        expect(page).to have_link(item_3.name)
        expect(page).to have_content(item_3.description)
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(item_1.name)
        expect(page).to_not have_content(item_1.description)
      end
      expect(page).to_not have_content(merchant_2.name)
    end

    it 'user can see nav bar' do
      visit merchant_items_path(@merchant_1)

      within('.nav-1') do
        expect(page).to have_button("Merchants")
        expect(page).to have_button("Items")

        click_on "Merchants"

        expect(current_path).to eq(merchants_path)
      end
    end

    it 'user can see nav bar' do
      visit merchant_items_path(@merchant_1)

      within('.nav-1') do
        expect(page).to have_button("Merchants")
        expect(page).to have_button("Items")

        click_on "Items"

        expect(current_path).to eq(items_path)
      end
    end
  end
end

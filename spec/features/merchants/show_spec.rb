require 'rails_helper'

RSpec.describe 'merchants show page', type: :feature do
  describe 'when a user visits a merchant page' do
    before(:each) do
      @merchant = Merchant.create!(name: 'Bob', address: '400 W 10th', city: 'Denver', state: 'CO', zip: '80204')
    end

    it 'user can see merchant details' do
      visit merchant_path(@merchant)

      within('.title') { expect(page).to have_content(@merchant.name) }
      within('#address') { expect(page).to have_content(@merchant.address) }
      within('#city') { expect(page).to have_content(@merchant.city) }
      within('#state') { expect(page).to have_content(@merchant.state) }
      within('#zip') { expect(page).to have_content(@merchant.zip) }
    end

    it 'user can see links' do
      visit merchant_path(@merchant)

      within('.bottom_link') do
        expect(page).to have_link("Add Item")
        expect(page).to have_link("Edit")
        expect(page).to have_link("Delete")
      end
    end

    it 'user can see nav bar' do
      visit merchant_path(@merchant)

      within('.nav') do
        expect(page).to have_link("Merchants")
        expect(page).to have_link("Items")
      end
    end
  end
end

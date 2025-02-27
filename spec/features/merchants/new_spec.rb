require 'rails_helper'

RSpec.describe 'merchants new entry', type: :feature do
  describe 'when a user visits the index page' do
    it 'user clicks to create a new merchant' do
      visit merchants_path
      click_button "New Merchant"

      expect(current_path).to eq(new_merchant_path)
      within('.title') { expect(page).to have_content("New Merchant") }

      fill_in :name, with: "Jon"
      fill_in :address, with: "200 E 10th"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80211"
      click_on "Submit"

      expect(current_path).to eq(merchants_path)
      within('.title') { expect(page).to have_content("All Merchants") }
      within("#merchant-#{Merchant.last.id}") do
        expect(page).to have_content("Jon")
      end
    end

    it 'user can see nav bar' do
      visit new_merchant_path

      within('.nav-1') do
        expect(page).to have_button("Merchants")
        expect(page).to have_button("Items")

        click_on "Merchants"

        expect(current_path).to eq(merchants_path)
      end
    end

    it 'user can see nav bar' do
      visit new_merchant_path

      within('.nav-1') do
        expect(page).to have_button("Merchants")
        expect(page).to have_button("Items")

        click_on "Items"

        expect(current_path).to eq(items_path)
      end
    end
  end
end

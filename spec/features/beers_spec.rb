require 'rails_helper'

BeerClub
BeerClubsController
Beer
BeersController
Brewery
BreweriesController
Membership
MembershipsController
Rating
RatingsController
SessionsController
User
UsersController
ApplicationController


  describe "beer sign up" do
    it "can create beer with right credentials" do
      visit new_beer_path
      fill_in('Name', with:'testikalja')
      select('Weizen', from:'Style')
      click_button('Create Beer')
      
      expect(Beer.count).to eq(1)

      end
    it "not saving beer with wrong credentials" do
      visit new_beer_path
      fill_in('Name', with:'')
      select('Weizen', from:'Style')
      click_button('Create Beer')
      
      expect(Beer.count).to eq(0)
      expect(current_path).to eq(beers_path)
      expect(page).to have_content "Name can't be blank"
      end
    end
  

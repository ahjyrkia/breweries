require 'rails_helper'



describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    visit signin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end
 it "ratings show on rater's page" do
   visit new_rating_path
   select('iso 3', from:'rating[beer_id]')
   fill_in('rating[score]', with:'20')
   click_button "Create Rating"
   visit user_path(1)
   expect(page).to have_content 'iso 3'
 end
 it "rating not around after user deletes is" do
   visit new_rating_path
   select('iso 3', from:'rating[beer_id]')
   fill_in('rating[score]', with:'20')
   click_button "Create Rating"
   visit user_path(1)
   expect(user.ratings.count).to eq(1)
   click_link('delete')
   expect(user.ratings.count).to eq(0)
 end
 it "newly added ratings show up on page" do
   visit new_rating_path
   select('iso 3', from:'rating[beer_id]')
   fill_in('rating[score]', with:'20')
   select('Karhu', from:'rating[beer_id]')
   fill_in('rating[score]', with:'15')

   expect(page).to have_content 'iso 3'
   expect(page).to have_content 'Karhu'
 end
  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
end

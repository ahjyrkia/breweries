require 'rails_helper'


describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "not too short password" do
    user = User.create username:"Seppo", password:"Sec", password_confirmation:"Sec"
    
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved when contains letters only" do
    user = User.create username:"Seppo", password:"Secret", password_confirmation:"Secret"
    
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  it "has method for determining the favorite_beer" do
    user = FactoryGirl.create(:user)
    expect(user).to respond_to(:favorite_beer)
  end
  it "without ratings does not have a favorite beer" do
    user = FactoryGirl.create(:user)
    expect(user.favorite_beer).to eq(nil)
  end
  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
  end
end

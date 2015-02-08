require 'rails_helper'

describe Beer do
  it "saved if has name and style" do
  beer = Beer.create name:"iso 3", style:"Lager"

  expect(beer).to be_valid 
  expect(Beer.count).to eq(1)
  end
  it "not saved when no name" do
  beer = Beer.create style:"Lager"

  expect(beer).not_to be_valid
  expect(Beer.count).to eq(0)
  end
  it "not saved when no style" do
  beer = Beer.create name:"iso 3"

  expect(beer).not_to be_valid
  expect(Beer.count).to eq(0)
  end
end

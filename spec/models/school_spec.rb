require 'rails_helper'

RSpec.describe School, type: :model do

  describe "validations" do
    it {should validate_presence_of(:name) }
    it {should validate_presence_of(:rating) }
    it {should validate_presence_of(:level) }
 end

  describe "#gummy_bears" do
  	it "returns (rating * 10) gummy bears" do
  		school = School.create(name: 'test', rating: 7, level:'high')
  		expect(School.first.gummy_bears).to eq("I get 70 gummy bears because I have a 7 out of 10 rating!")
	end  
  end

  describe "#by_rating" do
  	it "orders schools by rating" do
  	  s1 = School.create(name: 'AAA', rating: 4, level: 'high')
  	  s2 = School.create(name: 'BBB', rating: 3, level: 'elementary')
  	  s3 = School.create(name: 'CCC', rating: 2, level: 'middle')
  	  s4 = School.create(name: 'DDD', rating: 1, level: 'high')
  	  ordered_schools = School.all.by_rating
  	  expect(ordered_schools.first).to eq(s4)
  	  expect(ordered_schools.last).to eq(s1)
  	end
  end

  describe "#just_high_schools" do
  	it "returns all high schools" do
  	  s1 = School.create(name: 'AAA', rating: 4, level: 'high')
  	  s2 = School.create(name: 'BBB', rating: 3, level: 'elementary')
  	  s3 = School.create(name: 'CCC', rating: 2, level: 'middle')
  	  s4 = School.create(name: 'DDD', rating: 1, level: 'high')
  	  only_high = School.all.just_high_schools
  	  expect(only_high.count).to eq(2)
  	  expect(only_high.first.level).to eq('high')
  	end

  end


end
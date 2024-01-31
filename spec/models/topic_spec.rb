require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  it "should validate name" do 
    topic = user.topics.create(description: "Begin your journey in JavaScript with data types, variables and built in methods")
    expect(topic.errors[:name]).to_not be_empty
  end

  it "should validate description" do 
    topic = user.topics.create(name: "JavaScript Foundations")
    expect(topic.errors[:description]).to_not be_empty
  end

  it "should validate user_id" do 
    topic = Topic.create(name: "JavaScript Foundations", description: "Begin your journey in JavaScript with data types, variables and built in methods")
    expect(topic.errors[:user_id]).to_not be_empty
  end

  it "should validate name length to be between 3 and 50 characters" do 
    topic1 = user.topics.create(name: "Ja", description: "Begin your journey in JavaScript with data types, variables and built in methods")
    expect(topic1.errors[:name]).to_not be_empty
    topic2 = user.topics.create(name: "JavaScript Intro and Foundations are totally awesome!!!!!!", description: "Begin your journey in JavaScript with data types, variables and built in methods")
    expect(topic2.errors[:name]).to_not be_empty
  end

  it "should validate description length to be at least 10 characters" do 
    topic = user.topics.create(name: "JavaScript Foundations", description: "Begin")
    expect(topic.errors[:description]).to_not be_empty
  end
end

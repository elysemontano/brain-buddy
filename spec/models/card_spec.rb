require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  let(:topic) {Topic.create(
    user_id: user.id,
    name: 'JavaScript Intro', 
    description: 'Begin your journey in JavaScript with data types, variables and built in methods'
  )}

  it "should validate question" do 
    card = user.cards.create(topic_id: 3, answer: "Object Oriented Programming is a programming paradigm that organizes data into a format that allows each instance to be an object")
    expect(card.errors[:question]).to_not be_empty
  end

  it "should validate answer" do 
    card = user.cards.create(topic_id: 3,
    question: "What is OOP?")
    expect(card.errors[:answer]).to_not be_empty
  end

  it "should validate user_id" do 
    card = Card.create(topic_id: 3,
    question: "What is OOP?",
    answer: "Object Oriented Programming is a programming paradigm that organizes data into a format that allows each instance to be an object")
    expect(card.errors[:user_id]).to_not be_empty
  end

  it "should validate topic_id" do 
    card = user.cards.create(question: "What is OOP?",
    answer: "Object Oriented Programming is a programming paradigm that organizes data into a format that allows each instance to be an object")
    expect(card.errors[:topic_id]).to_not be_empty
  end

  it "should validate question length is more than 5 characters" do 
    card = user.cards.create(topic_id: 3, question: "Wha",
    answer: "Object Oriented Programming is a programming paradigm that organizes data into a format that allows each instance to be an object")
    expect(card.errors[:question]).to_not be_empty
  end

  it "should validate question length is more than 5 characters" do 
    card = user.cards.create(topic_id: 3, question: "What is OOP?",
    answer: "Obj")
    expect(card.errors[:answer]).to_not be_empty
  end
end

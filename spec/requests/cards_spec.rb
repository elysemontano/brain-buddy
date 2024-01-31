require 'rails_helper'

RSpec.describe "Cards", type: :request do
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

  # ________INDEX__________
  describe "GET /index" do
    it 'gets a list of cards' do 
      card = user.cards.create(question: "What are the six primitive data types?", answer: "Number, String, Boolean, Undefined, Null, and Symbol", topic_id: topic.id)

      get '/cards'

      card = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(card.first['question']).to eq('What are the six primitive data types?')
      expect(card.first['answer']).to eq('Number, String, Boolean, Undefined, Null, and Symbol')
    end
  end
  
  #_______CREATE_________
  describe "POST /create" do
    it "creates a card" do
      card_params = {
        card: {
          question: "What are the six primitive data types?", answer: "Number, String, Boolean, Undefined, Null, and Symbol", 
          topic_id: topic.id,
          user_id: user.id
        }
      }

      post '/cards', params: card_params
      expect(response).to have_http_status(200)
  
      card = Card.first
  
      expect(card.question).to eq 'What are the six primitive data types?'
      expect(card.answer).to eq 'Number, String, Boolean, Undefined, Null, and Symbol'
    end
  end
  
  #__________UPDATE___________
  describe "PATCH /update" do
    it 'updates a card' do
    card_params = {
      card: {
        question: "What are the six primitive data types?", answer: "Number, String, Boolean, Undefined, Null, and Symbol", 
        topic_id: topic.id,
        user_id: user.id
      }
    }
      post '/cards', params: card_params
      card = Card.first

    updated_card_params = {
      card: {
        question: "What is a string?", 
        answer: "A collection of characters wrapped with quotation marks", 
        topic_id: topic.id,
        user_id: user.id
      }
    }
      patch "/cards/#{card.id}", params: updated_card_params
    
      updated_card = Card.find(card.id)
      expect(response).to have_http_status(200)
      expect(updated_card.question).to eq 'What is a string?'
      expect(updated_card.answer).to eq 'A collection of characters wrapped with quotation marks'
    end
  end
  
  #_________DESTROY___________
  describe "DELETE /destroy" do
    it 'deletes a card' do
      card = user.cards.create(question: "What are the six primitive data types?", answer: "Number, String, Boolean, Undefined, Null, and Symbol", topic_id: topic.id)

      delete "/cards/#{card.id}"
      expect(response).to have_http_status(200)
      cards = Card.all
      expect(cards).to be_empty
    end
  end
end

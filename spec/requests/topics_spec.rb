require 'rails_helper'

RSpec.describe "Topics", type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  # ________INDEX__________
  describe "GET /index" do
    it 'gets a list of items' do 
      topic = user.topics.create(name: 'JavaScript Intro', description: 'Begin your journey in JavaScript with data types, variables and built in methods')

      get '/topics'

      topic = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(topic.first['name']).to eq('JavaScript Intro')
      expect(topic.first['description']).to eq('Begin your journey in JavaScript with data types, variables and built in methods')
    end
  end

  #_______CREATE_________
  describe "POST /create" do
    it "creates a topic" do
      topic_params = {
        topic: {
          name: 'JavaScript Intro', 
          description: 'Begin your journey in JavaScript with data types, variables and built in methods',
          user_id: user.id
        }
      }

      post '/topics', params: topic_params
      expect(response).to have_http_status(200)
  
      topic = Topic.first
  
      expect(topic.name).to eq 'JavaScript Intro'
      expect(topic.description).to eq 'Begin your journey in JavaScript with data types, variables and built in methods'
    end
  end

  #__________UPDATE___________
  describe "PATCH /update" do
    it 'updates a topic' do
    topic_params = {
      topic: {
        name: 'JavaScript Intro', 
        description: 'Begin your journey in JavaScript with data types, variables and built in methods',
        user_id: user.id
      }
    }
      post '/topics', params: topic_params
      topic = Topic.first

    updated_topic_params = {
      topic: {
        name: 'JavaScript Foundations', 
        description: 'Stretching your understanding of JavaScript with concepts like conditionals and arrays'
      }
    }
      patch "/topics/#{topic.id}", params: updated_topic_params
   
      updated_topic = Topic.find(topic.id)
      expect(response).to have_http_status(200)
      expect(updated_topic.name).to eq 'JavaScript Foundations'
      expect(updated_topic.description).to eq 'Stretching your understanding of JavaScript with concepts like conditionals and arrays'
    end
  end

  #_________DESTROY___________
  describe "DELETE /destroy" do
    it 'deletes a topic' do
      topic = user.topics.create(name: 'JavaScript Intro', description: 'Begin your journey in JavaScript with data types, variables and built in methods')

      delete "/topics/#{topic.id}"
      expect(response).to have_http_status(200)
      topics = Topic.all
      expect(topics).to be_empty
    end
  end
end

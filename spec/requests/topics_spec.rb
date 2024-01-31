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


  #__________VALIDATIONS________


  #_________CREATE VALIDATIONS______________
  describe "cannot create a topic without valid attributes" do
    it "doesn't create a topic without a name" do
      topic_params = {
        topic: { 
          description: 'Begin your journey in JavaScript with data types, variables and built in methods',
          user_id: user.id
        }
      }
        post '/topics', params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['name']).to include "can't be blank"
    end

    it "doesn't create a topic without a description" do
      topic_params = {
        topic: { 
          name: "JavaScript Intro",
          user_id: user.id
        }
      }
        post '/topics', params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['description']).to include "can't be blank"
    end

    it "doesn't create a topic without a user id" do
      topic_params = {
        topic: { 
          name: "JavaScript Intro",
          description: "Begin your journey in JavaScript with data types, variables and built in methods"
        }
      }
        post '/topics', params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['user_id']).to include "can't be blank"
    end

    it "doesn't create a topic if name length is less than 3" do
      topic_params = {
        topic: { 
          name: "Ja",
          description: "Begin your journey in JavaScript with data types, variables and built in methods"
        }
      }
        post '/topics', params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['name']).to include "is too short (minimum is 3 characters)"
    end

    it "doesn't create a topic if name length is more than 50" do
      topic_params = {
        topic: { 
          name: "JavaScript Intro and Foundations are totally awesome!!!!!!",
          description: "Begin your journey in JavaScript with data types, variables and built in methods"
        }
      }
        post '/topics', params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['name']).to include "is too long (maximum is 50 characters)"
    end

    it "doesn't create a topic if description length is less than 10" do
      topic_params = {
        topic: { 
          name: "JavaScript Intro",
          description: "Begin"
        }
      }
        post '/topics', params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['description']).to include "is too short (minimum is 10 characters)"
    end
  end


   #_________UPDATE VALIDATIONS______________
   describe "cannot update a topic without valid attributes" do
    it "doesn't update a topic without a name" do
      topic = user.topics.create(name: 'JavaScript Intro', description: 'Begin your journey in JavaScript with data types, variables and built in methods')

      topic_params = {
        topic: { 
          name: '',
          description: 'Begin your journey in JavaScript with data types, variables and built in methods',
          user_id: user.id
        }
      }
        patch "/topics/#{topic.id}", params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['name']).to include "can't be blank"
    end


    it "doesn't update a topic without a description" do
      topic = user.topics.create(name: 'JavaScript Intro', description: 'Begin your journey in JavaScript with data types, variables and built in methods')

      topic_params = {
        topic: { 
          name: 'JavaScript Intro',
          description: '',
          user_id: user.id
        }
      }
        patch "/topics/#{topic.id}", params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['description']).to include "can't be blank"
    end

    it "doesn't update a topic if name length is less than 3" do
      topic = user.topics.create(name: 'JavaScript Intro', description: 'Begin your journey in JavaScript with data types, variables and built in methods')

      topic_params = {
        topic: { 
          name: 'Ja',
          description: 'Begin your journey in JavaScript with data types, variables and built in methods',
          user_id: user.id
        }
      }
        patch "/topics/#{topic.id}", params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['name']).to include "is too short (minimum is 3 characters)"
    end

    it "doesn't update a topic if name length is more than 50" do
      topic = user.topics.create(name: 'JavaScript Intro', description: 'Begin your journey in JavaScript with data types, variables and built in methods')

      topic_params = {
        topic: { 
          name: 'JavaScript Intro and Foundations are totally awesome!!!!!!',
          description: 'Begin your journey in JavaScript with data types, variables and built in methods',
          user_id: user.id
        }
      }
        patch "/topics/#{topic.id}", params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['name']).to include "is too long (maximum is 50 characters)"
    end

    it "doesn't update a topic if description length is less than 10" do
      topic = user.topics.create(name: 'JavaScript Intro', description: 'Begin your journey in JavaScript with data types, variables and built in methods')

      topic_params = {
        topic: { 
          name: 'JavaScript Intro',
          description: 'Begin',
          user_id: user.id
        }
      }
        patch "/topics/#{topic.id}", params: topic_params
        expect(response.status).to eq 422

        topic = JSON.parse(response.body) 
        expect(topic['description']).to include "is too short (minimum is 10 characters)"
    end
  end
end

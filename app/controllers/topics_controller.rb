class TopicsController < ApplicationController
  def index
    topics = Topic.includes(:cards).all
    render json: topics, include: :cards
  end
  

  def create 
    topic = Topic.create(topic_params)
    if topic.valid? 
      render json: topic 
    else
      render json: topic.errors, status: 422
    end
  end

  def update 
    topic = Topic.find(params[:id])
    topic.update(topic_params)
    if topic.valid? 
      render json: topic 
    else
      render json: topic.errors, status: 422
    end
  end

  def destroy 
    topic = Topic.find(params[:id])
    if topic.destroy 
      render json: topic
    end
  end

  private
  def topic_params 
    params.require(:topic).permit(:name, :description, :user_id)
  end
end

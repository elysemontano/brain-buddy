class CardsController < ApplicationController
  def index
    topic = Topic.find(params[:id])
    cards = topic.cards.all 
    render json: cards
  end

  def create 
    card = Card.create(card_params)
    if card.valid? 
      render json: card 
    else 
      render json: card.errors, status: 422
    end
  end

  def update 
    card = Card.find(params[:id])
    card.update(card_params)
    if card.valid?
      render json: card 
    else 
      render json: card.errors, status: 422
    end
  end

  def destroy 
    card = Card.find(params[:id])
    if card.destroy
      render json: card
    end
  end

  private 
  def card_params
    params.require(:card).permit(:user_id, :topic_id, :question, :answer)
  end
end

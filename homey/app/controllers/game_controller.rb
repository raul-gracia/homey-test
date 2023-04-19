class GameController < ApplicationController
  def index; end
  def new
    session[:game_session] = true
    session[:credits] = 10
    redirect_to root_path
  end

  def roll
    game = GameService.new(session[:credits]).roll
    session[:credits] = game[:new_credits_count]

    render json: game
  end

  def cash_out
    current_user.credits += session[:credits]
    current_user.save!
    session[:game_session] = false
    session[:credits] = nil

    redirect_to root_path
  end
end

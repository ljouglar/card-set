class GameController < ApplicationController
  protect_from_forgery :except => :play
  def index
    @games = Game.find(:all)
  end

  def new
    create
  end

  def create
    @game = Game.create
    redirect_to :action => "index"
  end

  def edit
    @game = Game.find(params[:id])
  end
  
  def remove
    Game.find(params[:id]).destroy
    redirect_to :action => "index"
  end
  
  def show
    @game = Game.find(params[:id])
  end
  
  def show2
    @game = Game.find(params[:id])
  end
  
  def play
    @game = Game.find(params[:id])
    if @game.try_set(params[:set].to_a.map{|x|x[1].to_i})
      @game.save
    end
    render :file => 'game/play.rjs', :use_full_path => true
  end
end

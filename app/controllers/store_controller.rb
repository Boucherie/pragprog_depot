class StoreController < ApplicationController

  def increment_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end

  def index
    @products = Product.order(:title)

    @counter = increment_counter 
    @count_message = "You've visited this page #{@counter} times" 
  end
end

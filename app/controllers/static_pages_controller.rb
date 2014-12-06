class StaticPagesController < ApplicationController
  def home
  	@expense = current_user.expenses.build if logged_in?
  end

  def help
  end
  
  def about
  end

  def contact
  end
end

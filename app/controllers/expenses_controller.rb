class ExpensesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
  	 @expense = current_user.expenses.build(expense_params)
    if @expense.save
      flash[:success] = "Expense created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def expense_params
      params.require(:expense).permit(:amount, :description, :shared_user)
    end
end

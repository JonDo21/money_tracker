class ExpensesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	 @expense = current_user.expenses.build(expense_params)
    if @expense.save
      flash[:success] = "Expense created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @expense.destroy
    flash[:success] = "Expense deleted"
    redirect_to request.referrer || root_url
  end

  private

    def expense_params
      params.require(:expense).permit(:amount, :description, :shared_user)
    end

    def correct_user
      @expense = current_user.expenses.find_by(id: params[:id])
      redirect_to root_url if @expense.nil?
    end
end

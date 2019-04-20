class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_authority, only: [:create]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all.order('created_at DESC')
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      current_user.notify('Item has been bought!', 'success')
      head :ok
    else
      @transaction.errors.messages.values.each do |message|
        current_user.notify(message[0], 'error')
      end
      head :not_acceptable
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def validate_authority
      unless params[:user_id] == current_user.id.to_s
        head :forbidden
        current_user.notify('HACKER DETECTED, CALLING INTERPOL', 'error')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.permit(:user_id, :item_id, :quantity)
    end
end

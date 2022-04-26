class PaymentRequestsController < ApplicationController
  before_action :authorize_request
  before_action :find_payment_request, except: %i[create index]
  # GET /payment_requests
  api :GET, '/payment_requests'
  header :Authorization, 'login token', requested: true
  def index
    @payment_requests = @current_user.payment_requests
    render json: @payment_requests, status: :ok
  end

  # POST /payment_requests
  api :POST, '/payment_requests'
  param :full_name, String
  param :amount_cents, String, required: true
  param :amount_currency, String, required: true
  param :iban, String, required: true
  def create
    @payment_request = @current_user.payment_requests.new(full_name: payment_request_params[:full_name], amount_cents: payment_request_params[:amount_cents].to_i, amount_currency: payment_request_params[:amount_currency], iban: payment_request_params[:iban])
    if @payment_request.save
      render json: @payment_request, status: :created
    else
      render json: { errors: @payment_request.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # GET /payment_requests/{id}
  api :GET, '/payment_requests/:id'
  header :Authorization, 'login token', requested: true
  def show
    render json: @payment_request, status: :ok
  end

  private

  def payment_request_params
    params.permit(
      :full_name, :amount_cents, :amount_currency, :iban
    ).with_indifferent_access
  end

  def find_payment_request
    @payment_request = @current_user.payment_requests.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Payment request not found' }, status: :not_found
  end
end

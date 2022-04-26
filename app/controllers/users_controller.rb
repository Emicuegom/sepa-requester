class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  api :GET, '/users'
  header :Authorization, 'login token', requested: true
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  api :GET, '/users/:username'
  header :Authorization, 'login token', requested: true
  def show
    render json: @user, status: :ok
  end

  # POST /users
  api :POST, '/users'
  param :name, String
  param :username, String, required: true
  param :email, String, required: true
  param :password, String, required: true
  param :password_confirmation, String, required: true
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :username, :email, :password, :password_confirmation
    )
  end
end

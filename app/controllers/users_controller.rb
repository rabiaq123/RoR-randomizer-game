class UsersController < ApplicationController
  include SessionsHelper
  include UsersHelper

  before_action :set_user, only: %i[ show destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user.update(bag_contents: "3 quarters, 3 six-sided white die")
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.update(bag_contents: "3 quarters, 3 six-sided white die")
    @user.update(points: 0)
    log_in(@user)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    log_out

    respond_to do |format|
      format.html { redirect_to login_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #####################################
  ##### PLAY GAME ROUTE AND LOGIC #####
  #####################################

  # Play Game route for logged in user
  def play
  end

  # place in cup
  def throw_cup
    current_user.bag_contents = "empty"

    @cup = Cup.new
    @d1, @d2, @d3 = Die.new(6, :white), Die.new(6, :white), Die.new(6, :white)
    @q1, @q2, @q3 = Coin.new(0.25), Coin.new(0.25), Coin.new(0.25)
    @cup.store_all([@d1, @d2, @d3, @q1, @q2, @q3])
    @cup.throw
    set_sideup_values([@d1.sideup, @d2.sideup, @d3.sideup, @q1.sideup, @q2.sideup, @q3.sideup])

    if get_sideup_values.count(:T) == 2 && get_sideup_values.count(6) == 1
      current_user.points += 1
    end

    current_user.save
    render 'play'
  end


  private
    # Use callbacks to share common setup or constraints between actions
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end

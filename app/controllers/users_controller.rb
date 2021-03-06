class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :require_admin_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def logout
    cookies.delete :user
    cookies.delete :validateuser
    cookies.delete :new_user
    cookies.delete :iduser
    redirect_to "/"
  end

  def login
    @user = User.find_by(email: params[:param1],useraa: params[:param2])
    if @user.nil?
        
    else
      @user.useraa = params[:param2]
      @user.save
      cookies[:user] = params[:param1]
      cookies[:validateuser] = @user.admin
      cookies[:iduser] = @user.id
    end
      respond_to do |format|
        format.html
        format.json { render json: @user }
  end
=begin
      if @user.present?
        format.json{render status:'ok'}
      else  
        format.json{render json:@user}
      end
=end
    end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :middle, :useraa)
    end
    def require_login
      if cookies['user'].blank?
        redirect_to "/"
      end
    end

    def require_admin_login
      if cookies['validateuser'].nil?
        username = 0
      end
      if cookies['validateuser'] == 1
        username = 1
      end
      
      if username = 1
        p "Admin Login"
      else
        redirect_to "/"         
      end
    end

end

class ProductsController < ApplicationController
  before_action :require_login
  before_action :require_admin_login, only: [:edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @activeproducts = Product.where(['start_at <= ? AND finish_at >= ?', Time.now, Time.now]).order('start_at ASC')
    @notavailableproducts = Product.where(['start_at >= ?', Time.now]).order('start_at ASC')
    @endedproducts = Product.where(['finish_at <= ?', Time.now]).order('finish_at DESC')
    @myproducts = Product
                      .joins("LEFT JOIN `auctions` ON auctions.product_id = products.id")
                      .joins("LEFT JOIN `users` ON auctions.user_id = users.id")
                      .where("users.id = " + cookies[:iduser])
                      .group("auctions.product_id")
    @user = User.find(cookies[:iduser])
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user = User.find(cookies[:iduser])
    @offerended = 0
    if @product.start_at >= Time.now
      @offerended = 1 #Aun no inicia
      @user.last_seen_at = Time.now
      @user.save
      @current_viewers = User.where("last_seen_at > ?", 5.minutes.ago).count
    end
    if @product.start_at <= Time.now && @product.finish_at >= Time.now
      @offerended = 2 #Activa
      @user.last_seen_at = Time.now
      @user.save
      @current_viewers = User.where("last_seen_at > ?", 5.minutes.ago).count
    end
    if @product.finish_at < Time.now
      @offerended = 3 #Finalizo
      @winners = @product.auctions.select('MAX(auctions.amount) as amount, auctions.user_id').group(:user_id).all.order('amount DESC').limit(@product.qty)
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  def getmax
    @product = Product.find(params[:id])
    if @product.auctions.present?
      @max = @product.auctions.maximum(:amount)
    else
      @max = 0
    end
    respond_to do |format|
       format.html
       format.js {} 
       format.json { 
          render json: {:message => 'success', :price => @max}
      } 
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :price_correa, :qty, :image, :imagenurl, :model, :sku, :finish_at, :start_at)
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

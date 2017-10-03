class ProductsController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :require_admin_login, only: [:edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if @product.finish_at < Time.now
      @offerended = 1
    else
      @offerended = 0
    end

  end

  # GET /products/new
  def new
    @product = Product.new
  end

  def getmax
    @product = Product.find(params[:id])
    @max = @product.auctions.maximum(:amount)
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
      params.require(:product).permit(:name, :description, :price, :price_correa, :qty, :image, :qtycorrea, :finish_at)
    end
 
    def require_login
      if cookies['user'].blank?
        redirect_to "/"
      end
    end

    def require_admin_login
      if cookies['user'].nil?
        username = ""
      else
        username = cookies['user']
      end
      my_string = username
      if my_string.include? "gerardo.ayala"
        p "Admin Login"
      else
        redirect_to "/"         
      end
    end
end

class AuctionsController < ApplicationController
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :require_admin_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_auction, only: [:show, :edit, :update, :destroy]

  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.all
  end

  # GET /auctions/1
  # GET /auctions/1.json
  def show
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
  end

  def saveAuction
    @oferta = params[:param1]
    @idproducto = params[:param2]
    @product = Product.find(@idproducto)
    if @product.finish_at > Time.now
      @auction = Auction.new(user_id: cookies[:iduser],product_id: @idproducto,amount: @oferta)
      respond_to do |format|
        if  @auction.save
          @product = Product.find(params[:param2])
          @max = @product.auctions.maximum(:amount)
           format.html
           format.js {} 
           format.json { 
              render json: {:message => 'success', :price => @max}
           } 
        else
           format.html
           format.js {} 
           format.json { 
              render json: {:message => 'error', :price => @max}
           } 
        end
      end
    else
      respond_to do |format|
         format.html
         format.js {} 
         format.json { 
            render json: {:message => 'fin'}
        } 
      end
    end
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new(auction_params)

    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
        format.json { render :show, status: :created, location: @auction }
      else
        format.html { render :new }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auctions/1
  # PATCH/PUT /auctions/1.json
  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to auctions_url, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:user_id, :product_id, :amount)
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

module ProductsHelper
	def auctionExists(userid, productid)
		@user = User.find_by(email: userid)
		@auctions = Auction.where(user_id: @user).where(product_id: productid)
		button = "No has ofertado por este articulo"
		@auctions.each do |auctions|
			button = "<b>Ya ofertaste</b> por este articulo"
		end
		return button.html_safe
	end
end

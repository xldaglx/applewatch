module ProductsHelper
	def auctionExists(userid, productid)
		@user = User.find_by(email: userid)
		@auctions = Auction.where(user_id: @user).where(product_id: productid)
		button = "No tienes ofertas"
		@auctions.each do |auctions|
			button = "Ya tienes ofertas sobre este producto"
		end
		return button.html_safe
	end
end

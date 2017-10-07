module ProductsHelper
	def auctionExists(userid, productid)
		@auctions = Auction.where(user_id: userid).where(product_id: productid)
		button = "No has ofertado por este articulo"
		@auctions.each do |auctions|
			button = "<b>Ya ofertaste</b> por este articulo"
		end
		return button.html_safe
	end
	def auctionListName(productid)
		@auctions = Auction.where(product_id: productid).order('amount DESC').limit(3)
		button = ""
		@auctions.each do |auctions|
			button = auctions.user.name+"</br>"
		end
		return button.html_safe
	end
end

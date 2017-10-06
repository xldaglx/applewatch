class Product < ApplicationRecord
	has_many :auctions
	has_attached_file :image, :path => ":rails_root/public/products/:filename", :url => "/products/:filename",  default_url: "/products/no-photo.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end

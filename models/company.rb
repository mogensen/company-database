class Company
	include DataMapper::Resource

	property :id,         Serial,  :key => true
	property :created_at, DateTime
	property :updated_at, DateTime
	property :name,       String,  :length => 255 , :required => true
	property :address,    Text                    , :required => true
	property :city,       String,  :length => 255 , :required => true
	property :country,    String,  :length => 255 , :required => true
	property :email,      String,  :length => 255
	property :phone,      String,  :length => 255
	property :avatar_url, String,  :length => 255

	#has n, :directors
	#has n, :owners

	is_versioned :on => :updated_at

	before(:save) { self.updated_at = Time.now }

end


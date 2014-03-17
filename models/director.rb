class Director
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

	belongs_to :company
	validates_presence_of :company, :message => "cannot be empty"
end

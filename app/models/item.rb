class Item < ActiveRecord::Base
  attr_accessible :assettag, :description

  has_many :transactions
end

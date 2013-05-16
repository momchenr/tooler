class Item < ActiveRecord::Base
  attr_accessible :assettag, :description

  has_many :transactions, foreign_key: 'item_id'
end

class Item < ActiveRecord::Base
  attr_accessible :assettag, :description

  has_many :transactions
  has_many :employees, :through => :transactions

  scope :last_transaction, -> { order('created_at DESC').limit(1) }
end

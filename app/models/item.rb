class Item < ActiveRecord::Base
  attr_accessible :assettag, :description

  has_many :transactions
  has_many :employees, :through => :transactions

  scope :checked_out, -> { transactions.last_transaction.checkout }
end

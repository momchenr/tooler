class Item < ActiveRecord::Base
  attr_accessible :assettag, :description

  has_many :transactions
  has_many :employees, :through => :transactions

  def last_transaction
    transactions.order('created_at DESC').first
  end

  def checked_out?
    !last_transaction.status
  end
end

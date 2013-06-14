class Employee < ActiveRecord::Base
  attr_accessible :name, :phone
  
  has_many :transactions
  has_many :items, :through => :transactions
end

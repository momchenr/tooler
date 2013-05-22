class Employee < ActiveRecord::Base
  attr_accessible :name, :phone
  has_many :transactions
end

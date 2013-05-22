class Transaction < ActiveRecord::Base
  attr_accessible :employee_id, :item_id, :status

  belongs_to :employee
  belongs_to :item

  delegate :phone, :name, to: :employee
  delegate :description, :assettag, to: :item
end

class Transaction < ActiveRecord::Base
  attr_accessible :employee_id, :item_id, :status
end

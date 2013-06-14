class Transaction < ActiveRecord::Base
  attr_accessible :employee_id, :item_id, :status

  belongs_to :employee
  belongs_to :item

  delegate :phone, :name, to: :employee
  delegate :description, :assettag, to: :item

  def self.most_recent
    order("created_at DESC").limit(1)
  end

  scope :checkin, where(:status => true)
  scope :checkout, where(:status => false)
end

class Employee < ActiveRecord::Base
  attr_accessible :name, :phone
  
  has_many :transactions, order: 'created_at DESC'
  has_many :items, through: :transactions, uniq: true

  # has_many :checkedout_items,
  #  class_name: 'Item',
  #  source: :item,
  #  through: :transactions,
  #  conditions: { transactions: { status: false } }#
  #  # uniq: true

  def checkedout_items
    items.select(&:checked_out?)
  end
end

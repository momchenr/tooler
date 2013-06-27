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

  def self.search(search)
    if search
      where('name ILIKE ? OR phone ILIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |employee|
        csv << employee.attributes.values_at(*column_names)
      end
    end
  end
end

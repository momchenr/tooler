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

  def self.search(search)
    if search
      where('description ILIKE ? OR assettag ILIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  def self.to_csv(options= {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      employee = find_by_id(row["id"]) || new
      employee.attributes = row.to_hash.slice(*accessible_attributes)
      employee.save!
    end
  end
end

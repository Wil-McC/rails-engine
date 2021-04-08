class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  # has_many :invoice_items, through: :invoices

  scope :paginate, -> (page, per_page = 20) {
    limit(per_page).offset((page - 1) * per_page)
  }

  def all_items
    items
  end

  def self.find_first(str)
    find_all(str).first
  end

  def self.find_all(str)
    where('name ILIKE ?', "%#{str}%")
  end

  def self.top_revenue(limit)
    joins(invoice_items: :transactions)
    .where("transactions.result='success' AND invoices.status='shipped'")
    .group('merchants.id')
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .order('revenue DESC')
    .limit(limit)
  end
end

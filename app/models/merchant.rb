class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  scope :paginate, -> (page, per_page = 20) {
    limit(per_page).offset((page - 1) * per_page)
  }
end

class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.unshipped_revenue(limit)
    joins(invoice_items: :transactions)
    .where("transactions.result='success' AND invoices.status='packaged'")
    .group('invoices.id')
    .select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue')
    .order('potential_revenue DESC')
    .limit(limit)
  end
end

class InvoiceItem < ApplicationRecord
  belongs_to :item_id
  belongs_to :invoice_id
end

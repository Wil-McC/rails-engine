class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_name_revenue
  attributes :name, :revenue
end

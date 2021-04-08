class MerchantTotalSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_revenue
  attributes :revenue
end

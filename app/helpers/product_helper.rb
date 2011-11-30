module ProductHelper
  
  def purchase_label
    "Purchase Now for Only " + number_to_currency(PRODUCT['price'] / 100)
  end
  
end

class Order < ActiveRecord::Base
  
  attr_accessor :stripe_token
  
  before_create :generate_auth_token
  before_create :charge_stripe
  
  validates_presence_of :email, :first, :last
  
  def generate_auth_token
    token = Digest::SHA1.hexdigest(self.email + Time.now.to_s)
    self.authentication_token = token
  end
  
  def charge_stripe
    if stripe_token.present?
      charge = Stripe::Charge.create(
        :amount => PRODUCT['price'].to_i,
        :currency => "usd",
        :card => stripe_token, # obtained with stripe.js
        :description => "Charge for #{PRODUCT['name']}"
      )
      self.stripe_id = charge.id
    else
      raise "No stripe token present"
    end
  end
  
end

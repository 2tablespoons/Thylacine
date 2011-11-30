class ProductController < ApplicationController
  
  before_filter :verify_token, :only => [:thanks, :download]
  
  def index
    @order = Order.new
  end

  def process_order
    @order = Order.new(params[:order])
    if @order.save
      redirect_to thanks_path(:token => @order.authentication_token)
    else
      render :action => :index
    end
  end

  def thanks
    
  end
  
  def download    
    file = File.join(Rails.root, 'app/products', PRODUCT['file'])
    send_file file, :stream => true
  end
  
  protected
  
    def verify_token
      # Some views require the auth token from the order record 
      # This prevents unauthorized downloads and other shenanigans
      # If we don't find the order redirect to the home page
      @order = Order.find_by_authentication_token params[:token]
      redirect_to root_path if @order.blank?
    end

end

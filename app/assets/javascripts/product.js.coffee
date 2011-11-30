# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready -> 
  $("#new_order").submit (event) ->

    stripeResponseHandler = (status, response) -> 
    	form = $('#new_order')
    	if status == 200
        $("#order_last_4_digits").val(response.card.last4)
        $("#order_stripe_token").val(response.id)
        form.submit()
      else
        $("#stripe-error-message").text(response.error.message)
        $("#credit-card-errors").show()
        $("#order_submit").attr("disabled", false)

    # disable the submit button to prevent repeated clicks
    $('#payment_button').attr("disabled", "disabled")
    
    # Check for secure token
    return true if $("#order_stripe_token").val().length > 1
  
    # Amount you want to charge in cents
    amount = 2500 
    
    cardDetails = 
      number: $('#credit_card_number').val()
      cvc: $('#cvv').val()
      exp_month: $('#_expiry_date_2i').val()
      exp_year: $('#_expiry_date_1i').val()
      
    Stripe.createToken cardDetails, amount, stripeResponseHandler
  
    # Prevent the form from submitting with the default action
    return false

module BraintreeHelpers
  def create_braintree_customer(cc_number, expiration_date)
    Braintree::Customer.create(
      first_name: "Jen",
      last_name: "Smith",
      email: 'me@example.com',
      credit_card: {
        number: cc_number,
        expiration_date: expiration_date
      }
    ).customer
  end

  def braintree_credit_card_token(cc_number, expiration_date)
    create_braintree_customer(cc_number, expiration_date).credit_cards[0].token
  end

  def cc_token
    braintree_credit_card_token(TEST_CC_NUMBER, '04/2016')
  end
end

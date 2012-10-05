class DonationsController < ApplicationController
  def new
  end

  def create
    Stripe.api_key = "sk_giwOujcUI3OferKZpqb9fttrVbCnK"

    token = params[:stripeToken]
    name = params[:name]
    company = params[:company]
    description = params[:description]

    @dollar_amount = params[:amount]
    dollars, cents = @dollar_amount.split('.')
    amount = (dollars.to_i * 100) + cents.to_i

    charge = Stripe::Charge.create(:amount => amount, :card => token, :description => "#{company}: #{description}", :currency => 'usd')

    if charge
      Donation.create(:name => name, :company => company, :amount => amount, :description => description)
    end

  rescue Stripe::CardError => e
    # TODO catch this message and print custom one?
    flash[:error] = e.message
    redirect_to new_donation_path
  end
end

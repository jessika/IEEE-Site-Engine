class DonationsController < ApplicationController
  def new
  end

  def create
    Stripe.api_key = "sk_giwOujcUI3OferKZpqb9fttrVbCnK"

    @token = params[:stripeToken]
    @name = params[:name]
    @amount = params[:amount].to_i
    @dollar_amount = "#{@amount / 100}.#{@amount - ((@amount / 100) * 100)}"
    @company = params[:company]
    @description = params[:description]

    charge = Stripe::Charge.create(:amount => @amount, :card => @token, :description => "#{@company}: #{@description}", :currency => 'usd')

    if charge
      Donation.create(:name => @name, :company => @company, :amount => @amount, :description => @description)
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_donation_path
  end
end

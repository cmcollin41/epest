class LeadsController < ApplicationController
  def index
  	@lead = Lead.new
  end

  def create
  	@lead = Lead.new(lead_params)
  	if @lead.save
  		redirect_to @lead  	
  	else
  		render :index
  	end
  end

  def show
  	@lead = Lead.find(params[:id])
  	property = Rubillow::PropertyDetails.deep_search_results({ address: @lead.street_address, citystatezip: @lead.zip })
  	sqft = property.lot_size_square_feet
  	@acres = (sqft.to_f / 43560).round(2)

  	if @acres <= 0.25
  		@price = 32.5
  	elsif @acres >= 0.26 && @acres <= 0.5
  		@price = 35
  	elsif @acres >= 0.51 && @acres <= 1
  		@price = 37.25
  	else
  		@price = 40
  	end
  	@lead.quote = @price
    @lead.save
  end

  def update
    @lead = Lead.find(params[:id])
    @lead = Lead.find(params[:id])
    @lead.phone = params[:lead][:phone]
    if @lead.save(validate: false)
      redirect_to lead_path, notice: "Vance will be in touch with you shortly!"
    else
      redirect_to lead_path, notice: "Something went wrong. Call Vance!"
    end

    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    reminder = "You have a new lead! They live at #{@lead.street_address}, #{@lead.city} #{@lead.zip}. Their phone number is #{@lead.phone}. They have been quoted at $#{@lead.quote}/month."
    message1 = @client.account.messages.create(
      :from => @twilio_number,
      :to => 7025693888,
      :body => reminder,
    )
    message2 = @client.account.messages.create(
      :from => @twilio_number,
      :to => 7024999802,
      :body => reminder,
    )
    message3 = @client.account.messages.create(
      :from => @twilio_number,
      :to => 8018507800,
      :body => reminder,
    )

  end


  private

  def lead_params
  	params.require(:lead).permit(:street_address, :city, :st, :zip, :email, :phone, :first_name, :last_name, :quote)
  end
end

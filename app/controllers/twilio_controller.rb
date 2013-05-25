class TwilioController < ApplicationController

  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
      render 'process_sms.xml.erb', :content_type => 'text/xml'
    end
  
  def twilio_create
    @transaction = Transaction.new(:item_id => params[:Body], :employee_id => params[:From], :status => true)
    @transaction.save
  end

end

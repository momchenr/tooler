class TwilioController < ApplicationController

  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
      render 'process_sms.xml.erb', :content_type => 'text/xml'
    end
  
  def twilio_create
    @transaction = Transaction.new(:item => params[:Body], :employee => params[:From])
    @transaction.save
  end

end

class TwilioController < ApplicationController

  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
      render 'process_sms.xml.erb', :content_type => 'text/xml'
    end
  
  def create
    @transaction = Transaction.new(:item_id => 12345, :employee_id => 7173803550, :status => true)
    @transaction.save
  end

end

class TwilioController < ApplicationController

  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
      render 'process_sms.xml.erb', :content_type => 'text/xml'
    end
  
  def create
    phone_number = params[:From][/\d+/].to_s
    employee = Employee.where(phone: phone_number.to_s).first
    if employee
      @transaction = Transaction.new(:item_id => params[:Body], :employee_id => employee[:id], :status => true)
      @transaction.save
    end
  end

end

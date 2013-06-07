class TwilioController < ApplicationController

  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
      render 'process_sms.xml.erb', :content_type => 'text/xml'
  end

  def create
    phone_number = params[:From][/\d+/].to_s
    item_asset = params[:Body].str.split(/\s+/).last.to_s

    if params[:Body][/^ci/]
      item_status = true
    end

    if params[:Body][/^co/]
      item_status = false
    end

    employee = Employee.where(phone: phone_number.to_s).first
      if employee
        @transaction = Transaction.new(:item_id => item_asset, :employee_id => employee[:id], :status => item_status)
        @transaction.save
      end
  end

end

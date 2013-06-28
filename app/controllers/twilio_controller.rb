class TwilioController < ApplicationController

  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
      render 'process_sms.xml.erb', :content_type => 'text/xml'
  end

  def create
    phone_number = params[:From][/\d{10}\z/].to_s
    item_asset = params[:Body].split.last.upcase

    if params[:Body][/^ci/i]
      item_status = true
    end

    if params[:Body][/^co/i]
      item_status = false
    end

    employee = Employee.where(phone: phone_number.to_s).first
    item = Item.where(assettag: item_asset.to_s).first

    if employee && !item.last_transaction.status
      # generate checkin for last employee that had it
      @transaction = Transaction.new(:item_id => item[:id], :employee_id => item.last_transaction.employee[:id], :status => true)
      @transaction.save
      # generate checkout for incoming twilio message
      @transaction = Transaction.new(:item_id => item[:id], :employee_id => employee[:id], :status => item_status)
      @transaction.save
    elsif employee && item.last_transaction.status
      # if item is currently checkedin, just make a new checkout
      @transaction = Transaction.new(:item_id => item[:id], :employee_id => employee[:id], :status => item_status)
      @transaction.save
    end
  end

end

class ContactUsController < ApplicationController
  def index
  end

  def create
    if (invalid?(:email) || invalid?(:message))
      flash[:error] = t(:email_required) if invalid?(:email)
      flash[:error] = t(:message_required) if invalid?(:message)
    else
      ContactUs.contacting(params[:email], params[:message]).deliver
      flash[:notice] = t(:message_sent_successfully)
    end
    render 'index'
  end
  
  private
  def invalid?(key)
    params[key].nil? || params[key].empty?
  end
end

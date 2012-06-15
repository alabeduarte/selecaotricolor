require 'spec_helper'
describe ContactUsController do
  let(:mail_message) { mock(:mail_message).as_null_object}
  before do      
    ContactUs.stub(:contacting).with(anything).and_return(mail_message)
  end
  describe "create notification" do
    it "should send email to admin user" do
      email = 'test@t.com'
      message = 'Any sugestion'
      ContactUs.should_receive(:contacting).with(email, message)
      mail_message.should_receive(:deliver)
      
      post :create, :email => email, :message => message
      flash[:notice].should == I18n.t(:message_sent_successfully)
      response.should be_success
    end
    
    context 'when email is nil or blank' do
      it "should NOT send email when email is nil" do
        ContactUs.should_not_receive(:contacting).with(anything)
        post :create, :email => nil, :message => 'any content'
        flash[:error].should == I18n.t(:email_required)
      end

      it "should NOT send email when email is empty" do
        ContactUs.should_not_receive(:contacting).with(anything)
        post :create, :email => '', :message => 'any content'
        flash[:error].should == I18n.t(:email_required)
      end
    end
    
    context 'when message is nil or blank' do
      it "should NOT send email when content is nil" do
        ContactUs.should_not_receive(:contacting).with(anything)
        post :create, :email => 'test@t.com', :message => nil
        flash[:error].should == I18n.t(:message_required)
      end

      it "should NOT send email when content is empty" do
        ContactUs.should_not_receive(:contacting).with(anything)
        post :create, :email => 'test@t.com', :message => ''
        flash[:error].should == I18n.t(:message_required)
      end
    end    
    
  end
  
end
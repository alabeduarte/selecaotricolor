class ContactUs < ActionMailer::Base
  
  def contacting(email, message)
    @sender = email
    @message = message
    mail(from: email, to: "alabeduarte@gmail.com", subject: t(:some_contact))
  end
end

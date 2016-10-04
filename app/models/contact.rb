class Contact < MailForm::Base

	attribute :name,      :validate => true
  	attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  	attribute :message
    attribute :id_number
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Aegis Inquiry",
      :to => "cdyap@outlook.com",
      :from => %("#{name}, #{id_number}" <#{email}>)
    }
  end
end

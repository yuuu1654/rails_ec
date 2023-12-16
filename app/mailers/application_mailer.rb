# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@jewelrylabo.com'
  layout 'mailer'
end

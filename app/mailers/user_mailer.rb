class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation
    @greeting = "登録完了しました！"

    mail to: "m220274@gmail.com"
  end
end

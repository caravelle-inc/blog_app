class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation(email)
    @greeting = "登録完了しました！"

    mail(:subject => "登録完了のお知らせ", to: email)
  end
end

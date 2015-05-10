class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def registration_confirmation(email)
    @greeting = "登録完了しました！"

    mail (:subject => "登録完了のお知らせ", to: email)
  end
end

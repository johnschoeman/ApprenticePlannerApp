class UserMailer < ApplicationMailer
  def weekly_summary
    @user = params[:user]
    @entries = @user.last_weeks_entries
    mail(to: @user.email, subject: "Weekly Summary")
  end
end

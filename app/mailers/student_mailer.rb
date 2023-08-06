class StudentMailer < ApplicationMailer
    def registration_mail
        @student=params[:user]
        mail(to: @student.email, subject: "Welcome to RCB")
    end

    def reactivation_mail
        @student=params[:user]
        mail to: @student.email, subject: "Account Reactivation"
    end

end

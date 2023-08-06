class StudentController < ApplicationController
    before_action :find_students, only:[:list, :active, :suspended]
    # after_action :pagination, only:[:list, :active]
    def list        
        if params[:filter]=="active"
            @student=@student.where(:status=>1)
        elsif params[:filer]=="suspended"
            @student=@student.where(:status=>2)
        end

        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction=params[:direction] || "desc"
            @student=@student.order("#{sort_column} #{sort_direction}")
        end

        @student=@student.paginate(page: params[:page], per_page: 10)
    end

    def new
        @student=User.new
    end

    def create
        @student=User.new(student_params)
        @student.status=1
        @student.role_type=2
        @student.password=SecureRandom.alphanumeric(8)

        if @student.save
            StudentMailer.with(user: @student).registration_mail.deliver_now
            redirect_to root_path, notice: "Student #{@student.first_name} is registered"
        else
            render :new
        end
    end

    def student_params
        params.require(:user).permit(:first_name, :last_name, :age, :date_of_birth, :email)
    end

    def active
        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction=params[:direction] || "desc"
            @student=@student.order("#{sort_column} #{sort_direction}")
        end
        @student=@student.where(:status=>1).paginate(page: params[:page], per_page: 10)
    end

    def find_students
        @student=User.where(:role_type => 2)
    end

    def suspend
        @student=User.find(params[:id])
        @student.suspend!
        redirect_to students_active_path, notice: "student suspended successfully"
    end

    def suspended
        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction=params[:direction] || "desc"
            @student=@student.order("#{sort_column} #{sort_direction}")
        end
        @student=@student.where(:status=>2).paginate(page: params[:page], per_page: 10)
    end

    def send_reactivation_mail
        @student=User.find(params[:id])
        if @student.suspended?
            StudentMailer.with(user: @student).reactivation_mail.deliver_now
            redirect_to student_suspended_path, notice: 'Reactivation Email sent to student'
        else
            redirect_to suspended_students_path, alert: 'This student is not suspended.'
        end
    end

    def reactivate
        @student=User.find(params[:id])
        if @student.suspended?
            @student.reactivate!
            redirect_to root_path, notice: "Account reactivated successfully. You can now login."
        else
            redirect_to root_path, alert: 'Invalid reactivation link.'
        end
    end

end

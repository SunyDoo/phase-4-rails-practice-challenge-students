class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_created_response

    # GET /students
    def index
      students = Student.all
      render json: students
    end
  
    # GET /students/:id
    def show
      student = find_student
      render json: student, status: :ok
    end
  
    # POST /students
    def create
      student = Student.create!(student_params)
      render json: student, status: :created
    end
  
    # PATCH /students
    def update
      student = find_student
      student.update(student_params)
      render json: student, status: :accepted
    end
  
    # DELETE /students
    def destroy
      student = find_student
      student.destroy
      head :no_content
    end
  
    private
  
    def student_params
      params.permit(:name, :age, :major, :instructor_id)
    end
  
    def find_student
      Student.find(params[:id])
    end
  
    def render_not_found_response
      render json: { error: "student not found" }, status: :not_found
    end

    def render_not_created_response
        render json: { errors: "validation errors" }, status: :unprocessable_entity
    end

end

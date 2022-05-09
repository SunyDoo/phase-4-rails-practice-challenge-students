class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_created_response

    # GET /instructors
    def index
      instructors = Instructor.all
      render json: instructors
    end
  
    # GET /instructors/:id
    def show
      instructor = find_instructor
      render json: instructor, status: :ok
    end
  
    # POST /instructors
    def create
      instructor = Instructor.create!(instructor_params)
      render json: instructor, status: :created
    end
  
    # PATCH /instructors
    def update
      instructor = find_instructor
      instructor.update(instructor_params)
      render json: instructor, status: :accepted
    end
  
    # DELETE /instructors
    def destroy
      instructor = find_instructor
      instructor.destroy
      head :no_content
    end
  
    private
  
    def instructor_params
      params.permit(:name)
    end
  
    def find_instructor
      Instructor.find(params[:id])
    end
  
    def render_not_found_response
      render json: { error: "instructor not found" }, status: :not_found
    end

    def render_not_created_response
        render json: { errors: "validation errors" }, status: :unprocessable_entity
    end
    
end

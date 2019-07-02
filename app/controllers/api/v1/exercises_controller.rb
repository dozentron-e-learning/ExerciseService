class Api::V1::ExercisesController < ApplicationController
  before_action :set_api_v1_exercise, only: %i[show update destroy download download_hidden download_stub]

  # GET /api/v1/exercises
  def index
    @api_v1_exercises = Api::V1::Exercise.all

    render json: @api_v1_exercises
  end

  # GET /api/v1/exercises/1
  def show
    render json: @api_v1_exercise
  end

  # POST /api/v1/exercises
  def create
    @api_v1_exercise = Api::V1::Exercise.new(api_v1_exercise_params)

    if @api_v1_exercise.save
      render json: @api_v1_exercise, status: :created, location: @api_v1_exercise
    else
      render json: @api_v1_exercise.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/exercises/1
  def update
    if @api_v1_exercise.update(api_v1_exercise_params)
      render json: @api_v1_exercise
    else
      render json: @api_v1_exercise.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/exercises/1
  def destroy
    @api_v1_exercise.destroy
  end

  def download
    send_file @api_v1_exercise.exercise_test.path
  end

  def download_hidden
    send_file @api_v1_exercise.exercise_hidden_test.path
  end

  def download_stub
    send_file @api_v1_exercise.exercise_stub.path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_exercise
      @api_v1_exercise = Api::V1::Exercise.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_exercise_params
      params.fetch(:api_v1_exercise, {}).permit *Api::V1::Exercise::STRONG_PARAMETERS
    end
end

class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @questions = Question.all
    render 'questions/index'
  end

  def show 
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    json_file_path = Rails.root.join('app', 'views', 'questions', 'javascript', 'fetch.json')
    json_data = File.read(json_file_path)
    if @question.save
      parsed_json = JSON.parse(json_data)
      redirect_to question_url(@question), notice: 'Quesjkbskstion was successfully created.'
      Rails.logger.info("Parsed JSON: #{parsed_json.inspect}")
    else
      render :new
    end
  end
  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question was successfully destroyed.'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end
end

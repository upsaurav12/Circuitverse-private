class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @questions = Question.all
    if current_user.admin?
      render 'questions/index'
    else 
      render 'questions/user'
    end
  end

  def show 
    @question = Question.find(params[:id])
    #json_file_path = Rails.root.join('app', 'views', 'questions', 'javascript', 'fetch.json')
    #json_data = File.read(json_file_path)
    #parsed_json = JSON.parse(json_data)
    #render json: @question.to_json
  end

  def new
    @question = Question.new
  end
  def create
    @question = Question.new(question_params)

    #@question.content = MARKDOWN_PARSER.render(@question.content)
    #Rails.logger.info("Received JSON data: #{params[:question].to_json}")
      # Log the received JSON data
      # Assign values from parsed JSON to your model or do other processing as needed      
      if @question.save
        render json: { status: 'success', message: 'Question created successfully' }, status: :created
        #redirect_to question_url(@question), notice: 'Quesjkbskstion was successfully created.'
      else
        render json: { status: 'error', message: @question.errors.full_messages.join(', ') }, status: :unprocessable_entity
        #render :new
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
    params.require(:question).permit(:title, :content, :name, :timePeriod, :clockEnabled, :projectId, :focussedCircuit, :orderedTabs, scopes: [])
  end
end

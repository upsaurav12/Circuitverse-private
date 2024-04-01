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
    @question.circuit_data = JSON.parse('{
      "name":"Untitled",
      "timePeriod":500,
      "clockEnabled":true,
      "projectId":"PNJWPFpvnR2wa0sHSQ7W",
      "focussedCircuit":47885142395,
      "orderedTabs":["47885142395"],
      "scopes":[
        {
          "layout":{"width":100,"height":60,"title_x":50,"title_y":13,"titleEnabled":true},
          "verilogMetadata":{"isVerilogCircuit":false,"isMainCircuit":false,"code":"// Write Some Verilog Code Here!","subCircuitScopeIds":[]},
          "allNodes":[
            {"x":10,"y":0,"type":1,"bitWidth":1,"label":"","connections":[2]},
            {"x":10,"y":0,"type":1,"bitWidth":1,"label":"","connections":[3]},
            {"x":-10,"y":-10,"type":0,"bitWidth":1,"label":"","connections":[0]},
            {"x":-10,"y":10,"type":0,"bitWidth":1,"label":"","connections":[1]},
            {"x":20,"y":0,"type":1,"bitWidth":1,"label":"","connections":[]},
            {"x":10,"y":0,"type":0,"bitWidth":1,"label":"","connections":[]}
          ],
          "id":47885142395,
          "name":"Main",
          "Input":[
            {
              "x":410,"y":60,"objectType":"Input","label":"",
              "direction":"RIGHT","labelDirection":"LEFT","propagationDelay":0,
              "customData":{
                "nodes":{"output1":0},
                "values":{"state":1},
                "constructorParamaters":["RIGHT",1,{"x":0,"y":20,"id":"eB342mAc6WpcQeRxAwEH"}]
              }
            },
            {
              "x":410,"y":80,"objectType":"Input","label":"","direction":"RIGHT","labelDirection":"LEFT",
              "propagationDelay":0,"customData":{
                "nodes":{"output1":1},
                "values":{"state":1},
                "constructorParamaters":["RIGHT",1,{"x":0,"y":40,"id":"hqSnVMWErwiVrpYhvSKG"}]
              }
            }
          ],
          "Output":[
            {
              "x":580,"y":70,"objectType":"Output","label":"","direction":"LEFT","labelDirection":"RIGHT",
              "propagationDelay":0,"customData":{
                "nodes":{"inp1":5},
                "constructorParamaters":["LEFT",1,{"x":100,"y":20,"id":"mPRJCmLElX1f5Vto7YST"}]
              }
            }
          ],
          "OrGate":[
            {
              "x":490,"y":70,"objectType":"OrGate","label":"","direction":"RIGHT","labelDirection":"LEFT",
              "propagationDelay":10,
              "customData":{
                "constructorParamaters":["RIGHT",2,1],
                "nodes":{"inp":[2,3],"output1":4}
              }
            }
          ],
          "restrictedCircuitElementsUsed":[],
          "nodes":[]
        }
      ]
    }')

    #@question.content = MARKDOWN_PARSER.render(@question.content)
    #Rails.logger.info("Received JSON data: #{params[:question].to_json}")
      # Log the received JSON data
      # Assign values from parsed JSON to your model or do other processing as needed      
      if @question.save
          Rails.logger.info("Question with circuit data saved successfully: #{@question}")
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

  def progress
  render 'questions/progress'
end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :name, :timePeriod, :clockEnabled, :projectId, :focussedCircuit, :orderedTabs, scopes: [])
  end
end

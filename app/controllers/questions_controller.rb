class QuestionsController < ApplicationController
  before_filter :get_blast

  def index
    @questions = @blast.questions
  end

  def new
    @question = @blast.questions.build
  end

  def show

  end

  def create
    @question = @blast.questions.build(question_params)

    if @question.save
      flash[:notice] = "Successfully created question"
      redirect_to blast_path(@blast)
    else
      render :new
    end
  end

  private

  def get_blast
    @blast = Blast.find(params[:blast_id])
  end

  def question_params
    params.require(:question).permit(:prompt, :citizen_attribute, :autoresponse)
  end
end

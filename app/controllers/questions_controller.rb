class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    respond_with(@question)
  end

  def new
    @question = Question.new
    respond_with(@question)
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.save
    respond_with(@question)
  end

  def update
    @question.update(question_params)
    respond_with(@question)
  end

  def destroy
    @question.destroy
    respond_with(@question)
  end

  def random
    category = params[:category]
    questions = Question.where(:category => category)
    random_selection = Random::rand(questions.length)
    @question = questions[random_selection]
  end

  def solve
    @current_user = User.find(session[:user_id])
    @question = Question.find(params[:id])
    if @question.answer == params[:answer]
      @current_user.score += 100
      flash[:success] = 'اجابة صحيحة'
      if @current_user.score > @current_user.high_score
        @current_user.high_score = @current_user.score
      end
    else
      flash[:error] = "اجابة خاطئة حاول مرة اخرى"
      @current_user.lifes -= 1

    end
    @current_user.save
    if @current_user.lifes > 0
      redirect_to random_questions_path(:category => @question.category)
    else
      flash[:error] = ""
      redirect_to game_over_home_index_path(:score => @current_user.score)
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :option1, :option2, :option3, :option4, :answer, :category)
    end
end

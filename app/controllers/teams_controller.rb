class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[show edit update destroy change_authority]
  before_action :destroy_authority, only: [:destroy]
  before_action :edit_authority, only: %i[edit update]

  def index
    @teams = Team.all
  end

  def show
    @working_team = @team
    # binding.irb
    change_keep_team(current_user, @team)
  end

  def new
    @team = Team.new
  end

  def edit
    # binding.irb
  end

  def create
    @team = Team.new(team_params)
    @team.owner = current_user
    if @team.save
      @team.invite_member(@team.owner)
      redirect_to @team, notice: I18n.t('views.messages.create_team')
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_team')
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: I18n.t('views.messages.update_team')
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_team')
      render :edit
    end
  end

  def destroy
    @team.destroy
    # binding.irb
    redirect_to teams_url, notice: I18n.t('views.messages.delete_team')
  end

  def dashboard
    @team = current_user.keep_team_id ? Team.find(current_user.keep_team_id) : current_user.teams.first
  end
  
  def change_authority
    @team.update(owner_id: params[:owner_id])
    @user = User.find(@team.owner_id)
    ChangeAuthorityMailer.change_authority_mail(@user).deliver
    redirect_to team_path, notice: 'You have successfully change the authority'
  end

  private

  def set_team
    @team = Team.friendly.find(params[:id])
  end

  def team_params
    params.fetch(:team, {}).permit %i[name icon icon_cache owner_id keep_team_id]
  end
  
  def destroy_authority
    unless (@team.owner.id == @team.owner_id) || (current_user.id = @team.assign.id)
      redirect_to teams_url
    end
  end
  
  def edit_authority
    unless @team.owner.id == current_user.id
      redirect_to teams_url
    end
  end
  
  # def change_authority
    
end

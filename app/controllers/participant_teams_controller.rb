class ParticipantTeamsController < ApplicationController
  before_action :set_participant_team, only: [:show, :edit, :update, :destroy]

  # GET /participant_teams
  # GET /participant_teams.json
  def index
    @participant_teams = ParticipantTeam.all
  end

  # GET /participant_teams/1
  # GET /participant_teams/1.json
  def show
  end

  # GET /participant_teams/new
  def new
    @participant_team = ParticipantTeam.new
  end

  # GET /participant_teams/1/edit
  def edit
  end

  # POST /participant_teams
  # POST /participant_teams.json
  def create
    @participant_team = ParticipantTeam.new(participant_team_params)

    respond_to do |format|
      if @participant_team.save
        format.html { redirect_to @participant_team, notice: 'Participant team was successfully created.' }
        format.json { render :show, status: :created, location: @participant_team }
      else
        format.html { render :new }
        format.json { render json: @participant_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participant_teams/1
  # PATCH/PUT /participant_teams/1.json
  def update
    respond_to do |format|
      if @participant_team.update(participant_team_params)
        format.html { redirect_to @participant_team, notice: 'Participant team was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant_team }
      else
        format.html { render :edit }
        format.json { render json: @participant_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participant_teams/1
  # DELETE /participant_teams/1.json
  def destroy
    @participant_team.destroy
    respond_to do |format|
      format.html { redirect_to participant_teams_url, notice: 'Participant team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant_team
      @participant_team = ParticipantTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_team_params
      params.require(:participant_team).permit(:team_id, :participant_id)
    end
end

class EventAdminsController < ApplicationController
  before_action :set_event_admin, only: [:show, :edit, :update, :destroy]

  # GET /event_admins
  # GET /event_admins.json
  def index
    @event_admins = EventAdmin.all
  end

  # GET /event_admins/1
  # GET /event_admins/1.json
  def show
  end

  # GET /event_admins/new
  def new
    @event_admin = EventAdmin.new
  end

  # GET /event_admins/1/edit
  def edit
  end

  # POST /event_admins
  # POST /event_admins.json
  def create
    @event_admin = EventAdmin.new(event_admin_params)

    respond_to do |format|
      if @event_admin.save
        format.html { redirect_to @event_admin, notice: 'Event admin was successfully created.' }
        format.json { render :show, status: :created, location: @event_admin }
      else
        format.html { render :new }
        format.json { render json: @event_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_admins/1
  # PATCH/PUT /event_admins/1.json
  def update
    respond_to do |format|
      if @event_admin.update(event_admin_params)
        format.html { redirect_to @event_admin, notice: 'Event admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_admin }
      else
        format.html { render :edit }
        format.json { render json: @event_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_admins/1
  # DELETE /event_admins/1.json
  def destroy
    @event_admin.destroy
    respond_to do |format|
      format.html { redirect_to event_admins_url, notice: 'Event admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_admin
      @event_admin = EventAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_admin_params
      params.require(:event_admin).permit(:event_id, :user_id)
    end
end

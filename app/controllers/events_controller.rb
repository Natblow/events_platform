class EventsController < ApplicationController
  load_and_authorize_resource except: :myevents
  before_action :authenticate_user!, except: [:index, :show]
  before_action :attendee?, only: :show

  # GET /events or /events.json
  def index
    today = Date.today
    @events = Event.where(time: today..) #Events from today or the future

    @markers = @events.geocoded.map do |event|
      {
        id: event.id,
        title: event.title,
        lng: event.longitude,
        lat: event.latitude,
        address: event.address,
      }
    end
  end

  def myevents
    @myevents = Event.where(user_id: current_user.id)
  end

  # GET /events/1 or /events/1.json
  def show
    session[:previous_url] = request.fullpath #url for user to come back after signing in
    @single_event = Event.where(id: params[:id])
    @attending = Attendee.find_by(event_id: params[:id] , user_id: current_user)
    @attendees = Attendee.joins(:user).where(event_id: params[:id])

    @marker = @single_event.geocoded.map do |event|
      {
        id: event.id,
        title: event.title,
        lng: event.longitude,
        lat: event.latitude,
        address: event.address,
      }
    end
  end

  # GET /events/new
  def new
    # @event = Event.new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to show_event_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    redirect_to events_path, notice: "Not Authorized To Edit This Event" if @event.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_event
    #   @event = Event.find(params[:id])
    # end

    def attendee?
      if session[:login_successful_for_attend]
        session[:login_successful_for_attend] = nil
        repost(attendee_event_path, options: {authenticity_token: :auto})
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :address, :time, :description, :image, :remove_image, :image_cache, :user_id)
    end
end

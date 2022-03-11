class AttendeesController < ApplicationController
  before_action :set_attendee, only: %i[ destroy ]
  before_action :already_attending?, only: %i[ create ]

  # POST /events/1/attendees or /events/1/attendees.json
  def create
    if !current_user
     session[:creating_attendee] = true
     redirect_to user_session_path
   else
      @attendee = current_user.attendees.build({event_id: params[:id]})

      respond_to do |format|
        AttendeeMailer.with(event: @attendee).notify_event_creator.deliver_now

        if @attendee.save
          format.html { redirect_to @attendee.event, notice: "You have successfully registered for the event!" }
          format.json { render :show, status: :created, location: @attendee }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @attendee.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE events/1/attendees/1 or events/1/attendees/1.json
  def destroy
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to @attendee.event, notice: "You unregistered for the event successfully" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendee
      @attendee = Attendee.find_by(event_id: params[:id])
    end

    def already_attending?
      if current_user != nil && Attendee.exists?(user_id: current_user.id, event_id: params[:id])
        respond_to do |format|
          format.html { redirect_to event_path(params[:id]), alert: "You are already registered for the event!" }
          format.json { render :show, status: :created, location: @attendee }
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def attendee_params
      params.require(:attendee).permit(:user,:event)
    end
end

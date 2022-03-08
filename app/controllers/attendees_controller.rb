class AttendeesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_attendee, only: %i[ destroy ]

  # POST /events/1/attendees or /attendees.json
  def create
    if current_user.nil?
     # Store the form data in the session so we can retrieve it after login
     session[:attendee] = params
     # Redirect the user to register/login
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

  # DELETE /attendees/1 or /attendees/1.json
  def destroy
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to @attendee.event, notice: "Attendee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendee
      @attendee = Attendee.find_by(event_id: params[:id])
    end

    def after_sign_in_path_for(resource_or_scope)
      if session[:attendee].present?

        # save list
        @attendee = current_user.attendees.create(session[:attendee]["attendee"])

        # clear session
        session[:attendee] = nil

        #redirect
        flash[:notice] = "Sweet, logged in. Nice list, btw :)"
        events_path(@attendee.event)
        # stored_location_for(resource_or_scope)

    else
      #if there is not temp list in the session proceed as normal
        super
      end
      # stored_location_for(resource_or_scope) || super
    end

    # Only allow a list of trusted parameters through.
    def attendee_params
      params.require(:attendee).permit(:user,:event)
    end
end

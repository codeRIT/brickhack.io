class ParticipantsController < ApplicationController
  # GET /apply
  def index
    redirect_to new_participant_path
  end

  # GET /apply/1
  # GET /apply/1.json
  def show
    @participant = Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /apply/new
  # GET /apply/new.json
  def new
    @participant = Participant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /apply/1/edit
  def edit
    @participant = Participant.find(params[:id])
  end

  # POST /apply
  # POST /apply.json
  def create
    params[:participant] = convert_school_name_to_id params[:participant]
    @participant = Participant.new(params[:participant])

    respond_to do |format|
      if @participant.save
        Mailer.application_confirmation_email(@participant).deliver
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render json: @participant, status: :created, location: @participant }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apply/1
  # PUT /apply/1.json
  def update
    params[:participant] = convert_school_name_to_id params[:participant]
    @participant = Participant.find(params[:id])

    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apply/1
  # DELETE /apply/1.json
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to participants_url }
      format.json { head :no_content }
    end
  end

  # GET /apply/schools
  def schools
    if params[:name].blank? || params[:name].length < 3
      head 400
      return
    end
    schools = School.where('name LIKE ?', "%#{params[:name]}%").limit(20).select(:name).all
    render json: schools.map(&:name)
  end

  private

  def convert_school_name_to_id(participant)
    if participant[:school_name]
      school = School.where(name: participant[:school_name]).first
      if school.blank?
        school = School.create(name: participant[:school_name])
      end
      participant[:school_id] = school.id
      participant.delete :school_name
    end
    participant
  end
end

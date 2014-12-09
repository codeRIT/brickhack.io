class ParticipantsController < ApplicationController
  # GET /participants
  # GET /participants.json
  def index
    redirect_to new_participant_path
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    @participant = Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/1/edit
  def edit
    @participant = Participant.find(params[:id])
  end

  # POST /participants
  # POST /participants.json
  def create
    params[:participant] = convert_school_name_to_id params[:participant]
    @participant = Participant.new(params[:participant])

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render json: @participant, status: :created, location: @participant }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participants/1
  # PUT /participants/1.json
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

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to participants_url }
      format.json { head :no_content }
    end
  end

  # GET /participants/schools
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

class RegistrationsController < ApplicationController
  # GET /apply
  def index
    redirect_to new_registration_path
  end

  # GET /apply/1
  # GET /apply/1.json
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /apply/new
  # GET /apply/new.json
  def new
    @registration = Registration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /apply/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /apply
  # POST /apply.json
  def create
    params[:registration] = convert_school_name_to_id params[:registration]
    @registration = Registration.new(params[:registration])

    respond_to do |format|
      if @registration.save
        Mailer.delay.application_confirmation_email(@registration.id)
        format.html { redirect_to @registration, notice: 'Registration was successfully created.' }
        format.json { render json: @registration, status: :created, location: @registration }
      else
        format.html { render action: "new" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apply/1
  # PUT /apply/1.json
  def update
    params[:registration] = convert_school_name_to_id params[:registration]
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apply/1
  # DELETE /apply/1.json
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url }
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

  def convert_school_name_to_id(registration)
    if registration[:school_name]
      school = School.where(name: registration[:school_name]).first
      if school.blank?
        school = School.create(name: registration[:school_name])
      end
      registration[:school_id] = school.id
      registration.delete :school_name
    end
    registration
  end
end

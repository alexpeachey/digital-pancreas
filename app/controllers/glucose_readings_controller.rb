class GlucoseReadingsController < ApplicationController
  # GET /glucose_readings
  # GET /glucose_readings.json
  def index
    @glucose_readings = GlucoseReading.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @glucose_readings }
    end
  end

  # GET /glucose_readings/1
  # GET /glucose_readings/1.json
  def show
    @glucose_reading = GlucoseReading.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @glucose_reading }
    end
  end

  # GET /glucose_readings/new
  # GET /glucose_readings/new.json
  def new
    @glucose_reading = GlucoseReading.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @glucose_reading }
    end
  end

  # GET /glucose_readings/1/edit
  def edit
    @glucose_reading = GlucoseReading.find(params[:id])
  end

  # POST /glucose_readings
  # POST /glucose_readings.json
  def create
    @glucose_reading = GlucoseReading.new(params[:glucose_reading])

    respond_to do |format|
      if @glucose_reading.save
        format.html { redirect_to @glucose_reading, notice: 'Glucose reading was successfully created.' }
        format.json { render json: @glucose_reading, status: :created, location: @glucose_reading }
      else
        format.html { render action: "new" }
        format.json { render json: @glucose_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /glucose_readings/1
  # PUT /glucose_readings/1.json
  def update
    @glucose_reading = GlucoseReading.find(params[:id])

    respond_to do |format|
      if @glucose_reading.update_attributes(params[:glucose_reading])
        format.html { redirect_to @glucose_reading, notice: 'Glucose reading was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @glucose_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /glucose_readings/1
  # DELETE /glucose_readings/1.json
  def destroy
    @glucose_reading = GlucoseReading.find(params[:id])
    @glucose_reading.destroy

    respond_to do |format|
      format.html { redirect_to glucose_readings_url }
      format.json { head :ok }
    end
  end
end

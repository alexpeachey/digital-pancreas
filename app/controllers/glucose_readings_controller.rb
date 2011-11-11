class GlucoseReadingsController < ApplicationController
  before_filter :set_user
  before_filter :load_meal_codes
  before_filter :load_reading, only: [:show,:edit,:update,:destroy]

  def index
    @glucose_readings = @user.glucose_readings

    respond_to do |format|
      format.html
      format.json { render json: @glucose_readings }
    end
  end

  def show

    respond_to do |format|
      format.html
      format.json { render json: @glucose_reading }
    end
  end

  def new
    @glucose_reading = @user.glucose_readings.build

    respond_to do |format|
      format.html
      format.json { render json: @glucose_reading }
    end
  end

  def edit
  end

  def create
    @glucose_reading = @user.glucose_readings.build(params[:glucose_reading])

    respond_to do |format|
      if @glucose_reading.save
        format.html { redirect_to @glucose_reading, notice: 'Glucose Reading Logged!' }
        format.json { render json: @glucose_reading, status: :created, location: @glucose_reading }
      else
        format.html { render action: "new" }
        format.json { render json: @glucose_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @glucose_reading.update_attributes(params[:glucose_reading])
        format.html { redirect_to @glucose_reading, notice: 'Glucose Reading Updated!' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @glucose_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @glucose_reading.destroy

    respond_to do |format|
      format.html { redirect_to glucose_readings_url, notice: 'Glucose Reading Deleted!' }
      format.json { head :ok }
    end
  end
  
  private
  def meal_codes
    {
      '1. Before Breakfast' => 1,
      '2. After Breakfast' => 2,
      '3. Before Lunch' => 3,
      '4. After Lunch' => 4,
      '5. Before Dinner' => 5,
      '6. After Dinner' => 6,
      '7. Before Bed' => 7
    }
  end
  
  def set_user
    @user = current_user
  end
  
  def load_meal_codes
    @meal_codes = meal_codes
  end
  
  def load_reading
    @glucose_reading = @user.glucose_readings.find(params[:id])
  end
end

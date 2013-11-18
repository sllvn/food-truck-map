class Admin::FoodTrucksController < AdminController
  # GET /food_trucks
  # GET /food_trucks.json
  def index
    @food_trucks = FoodTruck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_trucks }
    end
  end

  # GET /food_trucks/new
  # GET /food_trucks/new.json
  def new
    @food_truck = FoodTruck.new

    respond_to do |format|
      format.html
      format.json { render json: @food_truck }
    end
  end

  # GET /food_trucks/1/edit
  def edit
    @food_truck = FoodTruck.find(params[:id])
  end

  # POST /food_trucks
  # POST /food_trucks.json
  def create
    @food_truck = FoodTruck.new(params[:food_truck])
    @food_truck.id = FoodTruck.maximum(:id).next

    respond_to do |format|
      if @food_truck.save
        format.html { redirect_to admin_food_trucks_path, notice: 'Food truck was successfully created.' }
        format.json { render json: @food_truck, status: :created, location: @food_truck }
      else
        format.html { render action: "new" }
        format.json { render json: @food_truck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /food_trucks/1
  # PUT /food_trucks/1.json
  def update
    @food_truck = FoodTruck.find(params[:id])

    respond_to do |format|
      if @food_truck.update_attributes(params[:food_truck])
        format.html { redirect_to admin_food_trucks_path(), notice: "Food truck #{@food_truck.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food_truck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_trucks/1
  # DELETE /food_trucks/1.json
  def destroy
    @food_truck = FoodTruck.find(params[:id])
    @food_truck.destroy

    respond_to do |format|
      format.html { redirect_to admin_food_trucks_url, notice: "Food truck was successfully deleted." }
      format.json { head :no_content }
    end
  end
end

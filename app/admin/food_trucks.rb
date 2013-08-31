ActiveAdmin.register FoodTruck do
  index do
    column :id
    column :name do |food_truck|
      link_to food_truck.name, admin_food_truck_path(food_truck)
    end
    column :updated_at
    actions
  end
end

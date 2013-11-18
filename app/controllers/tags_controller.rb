class TagsController < ApplicationController
  def index
    @tags = FoodTruck.tag_counts_on(:tags)
    render json: @tags, root: false
  end
end

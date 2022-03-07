require 'rails_helper'

RSpec.describe ImagesHelper, type: :helper do

  describe "#current_selected_tag_id" do
    it "returns nil when current_selected_tag_id is empty" do
      controller.params[:current_selected_tag_id] = ''
      expect(helper.current_selected_tag_id).to be_nil 
    end
  
    it "returns params[:tag_id]" do
      tag_id = rand(1..100)
      controller.params[:tag_id] = tag_id
      expect(helper.current_selected_tag_id).to eq(tag_id)
    end
  end

  describe "#query_params" do
    it "only returns params with value" do
      controller.params[:tag_id] = ''
      controller.params[:name] = Faker::Lorem.word
      controller.params[:sort_by] = 'asc'
      expect(helper.query_params.keys).to match_array(['name', 'sort_by'])
    end
  end

end

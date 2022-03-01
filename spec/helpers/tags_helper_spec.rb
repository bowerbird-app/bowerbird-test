require 'rails_helper'

RSpec.describe TagsHelper, type: :helper do

  describe "#query_params" do
    it "only returns params with value" do
      controller.params[:name] = Faker::Lorem.word
      controller.params[:sort_by] = ''
      expect(helper.query_params.keys).to match_array(['name'])
    end
  end

end

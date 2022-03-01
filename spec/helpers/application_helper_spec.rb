require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do

  describe "#current_sort_by" do
    it "returns asc by default" do
      expect(helper.current_sort_by).to eq('asc') 
    end
  
    it "returns desc" do
      controller.params[:sort_by] = 'desc'
      expect(helper.current_sort_by).to eq('desc') 
    end
  
    it "always return asc if sort_by params is not asc or desc" do
      controller.params[:sort_by] = 'somethingwrong'
      expect(helper.current_sort_by).to eq('asc') 
    end
  end

  describe "#reverse_sort_by" do
    it "returns desc when sort_by is asc" do
      controller.params[:sort_by] = 'asc'
      expect(helper.reverse_sort_by).to eq('desc') 
    end

    it "returns asc when sort_by is desc" do
      controller.params[:sort_by] = 'desc'
      expect(helper.reverse_sort_by).to eq('asc') 
    end

    it "returns desc when sort_by is not defined" do
      expect(helper.reverse_sort_by).to eq('desc') 
    end
  
    it "always return desc if sort_by params is not asc or desc" do
      controller.params[:sort_by] = 'somethingwrong'
      expect(helper.reverse_sort_by).to eq('desc') 
    end
  end
end

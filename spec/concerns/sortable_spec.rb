require 'rails_helper'

RSpec.describe Sortable, type: :helper do
  include Sortable

  context 'params[:sort_by]=asc' do
    
    it 'should should name ascending' do
      images = create_list(:image, 3)
      controller.params[:sort_by] = 'asc'
      records = name_sortable(Image.all)
      expect(records.first).to eq(images.sort_by(&:name).first)
      expect(records.last).to eq(images.sort_by(&:name).last)
    end
  end

  context 'params[:sort_by]=desc' do
    
    it 'should should name ascending' do
      images = create_list(:image, 3)
      controller.params[:sort_by] = 'desc'
      records = name_sortable(Image.all)
      expect(records.first).to eq(images.sort_by(&:name).last)
      expect(records.last).to eq(images.sort_by(&:name).first)
    end
  end
end
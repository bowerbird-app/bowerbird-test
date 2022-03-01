require "rails_helper"

RSpec.describe TagImageJob, type: :job do
  describe "#perform_later" do
    it "enqueue tag image job" do
      ActiveJob::Base.queue_adapter = :test
      image = create(:image)
      expect {
        TagImageJob.perform_later(image.id)
      }.to have_enqueued_job
    end
  end

  describe "#perform_now" do
    it "tags an image" do
      ActiveJob::Base.queue_adapter = :test
      image = create(:image)
      expect {
        TagImageJob.perform_now(image.id)
      }.to change { image.tags.count }
    end
  end
end
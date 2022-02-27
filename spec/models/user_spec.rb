require 'rails_helper'

RSpec.describe User, type: :model do
  # NOTE: Skipping devise related tests. Should have been test in the gem itself.
  it { should have_many(:images) }
end

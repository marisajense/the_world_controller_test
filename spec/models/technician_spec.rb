require 'rails_helper'

RSpec.describe Technician, type: :model do
  let(:technician) { FactoryGirl.create(:technician) }

  describe "Something" do
    it "Does something" do
      technician
    end
  end
end

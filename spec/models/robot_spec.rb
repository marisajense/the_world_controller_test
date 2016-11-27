require 'rails_helper'

RSpec.describe Robot, type: :model do
  let(:robot) { FactoryGirl.create(:robot, :good) }
  let(:evil_robot) { FactoryGirl.create(:robot, :evil) }

  describe 'abilities' do
    it 'greets humans if friendly' do
      expect(robot.greet).to eq("Hello Human")
    end
    it 'attacks humans if not friendly' do
      expect(evil_robot.attack).to eq(true)
    end
  end
end

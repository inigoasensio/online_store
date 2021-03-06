require 'rails_helper'

RSpec::describe OrderItem, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'attributes' do
    it { is_expected.to allow_mass_assignment_of(:tracking_number) }
    it { is_expected.to allow_mass_assignment_of(:currency) }
    it { is_expected.to allow_mass_assignment_of(:quantity) }
    it { is_expected.to allow_mass_assignment_of(:size) }
    it { is_expected.to allow_mass_assignment_of(:status) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:tracking_number) }
  end

  describe 'callbacks' do
  end
end

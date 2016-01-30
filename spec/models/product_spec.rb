require 'rails_helper'

RSpec::describe Product, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:supplier) }
    it { is_expected.to belong_to(:category) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:quantity_unit) }

    it { is_expected.to validate_attachment_presence(:image) }
    it { is_expected.to validate_attachment_content_type(:image).
      allowing('image/png', 'image/jpeg').
      rejecting('text/plain', 'text/xml') }
    it { is_expected.to validate_attachment_size(:image).less_than(1.megabytes) }

  end
end


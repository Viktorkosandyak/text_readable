require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations content' do
    it { should validate_length_of(:content).is_at_least(5) }
  end

  it "is not valid without a user_id" do
    subject.user_id = ''
    expect(subject).to_not be_valid
  end

end

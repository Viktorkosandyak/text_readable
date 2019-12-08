require 'rails_helper'

RSpec.describe User, type: :model do

  before do
      @user =  build(:user)
  end
    
  subject { @user }

  context 'associations' do
    it { should have_many(:posts) }
  end

  context 'validations' do
    it { should validate_presence_of(:email) }
  end

  it "is not valid without a email" do
    subject.email = ''
    expect(subject).to_not be_valid
  end

end
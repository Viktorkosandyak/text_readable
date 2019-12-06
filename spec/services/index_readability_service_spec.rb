# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IndexReadabilityService, type: :service do
  let(:content) { build(:post).content }

  describe 'when we pass valid text' do
    let(:readability_index) { IndexReadabilityService.new(content).calculate }

    it 'return readability index' do
      expect(readability_index).to eq(24)
    end
  end

  describe 'when sentence is easier' do
    let(:content) { 'PostgreSQL is a powerful, open source object-relational database system.' }
    let(:readability_index) { IndexReadabilityService.new(content).calculate }

    it 'return readability index 0' do
      expect(readability_index).to eq(0)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IndexReadabilityService, type: :service do
  let(:content) { build(:post).content }

  describe 'when we pass valid english text' do
    let(:readability_index) { IndexReadabilityService.new(content).call }

    it 'return readability index' do
      expect(readability_index).to eq(24)
    end
  end

  describe 'when sentence is easier' do
    let(:content) { 'PostgreSQL is a powerful, open source object-relational database system.' }
    let(:readability_index) { IndexReadabilityService.new(content).call }

    it 'return readability index 0' do
      expect(readability_index).to eq(0)
    end
  end
end
# Однією з родзинок української мови є те, що вона багата на зменшувальні форми. Навіть слово вороги має зменшувально-пестливу форму, яка вживається в гімні України. Пам’ятаєте: .згинуть наші вороженьки, як роса на сонці.
# 71

# PostgreSQL allows columns of a table to be defined as variable-length multidimensional arrays.
# 24

# Премьера продолжения сериала \"Екатерина 3. Самозванцы\" 2019 года в главной роли Марина Александрова. В третьей части показан самый сложный период правления Екатерины Великой, затрагивающий 1774-1776 годы.
# 55
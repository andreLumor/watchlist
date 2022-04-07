require 'rails_helper'

RSpec.describe GetAssetValueService, type: :model do
  describe '#value'do
    context 'with valid asset' do
      subject(:value) { described_class.new(asset, source_index).value }
      let(:asset) { 'PETR3' }

      context 'with source index = 0' do
        let(:source_index) { 0 }
        it 'returns value from first source', :vcr  do 
          expect(value).to eq(3589)
        end
      end

      context 'with source index = 1' do
        let(:source_index) { 1 }
        it 'returns value from second source', :vcr  do
          expect(value).to eq(3586)
        end
      end

      context 'with source index = 2' do
        let(:source_index) { 2 }
        it 'returns value from third source', :vcr  do
          expect(value).to eq(3590)
        end
      end
    end

    context 'with invalid asset' do
      let(:asset) { 'LALALA123' }
      it 'raises access error', :vcr  do 
        expect { described_class.new(asset, 0).value }.to raise_error('Access error')
      end
    end
  end
end

# frozen_string_literal: true

require './lib/enumerables'
RSpec.describe Enumerable do
  let(:arr) { [] }

  describe '#my_each' do
    it 'returns elements of array if block is given' do
      expect([1, 2, 3, 4, 5].my_each { |num| num }).to eql([1, 2, 3, 4, 5])
    end

    it 'returns enumerator if no block is given' do
      arr_block = [1, 2, 3, 4, 5]
      expect(arr_block.my_each).to be_a(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'returns elements numerical position' do
      [2, 3, 5, 7].my_each_with_index { |_elem, idx| arr << idx }
      expect(arr).to eql([0, 1, 2, 3])
    end
    it 'returns elements of an array' do
      [2, 3, 5, 7].my_each_with_index { |elem, _idx| arr << elem}
      expect(arr).to eql([2, 3, 5, 7])
    end
    it 'returns enumerator when no block is given' do
      expect([2, 3, 5, 7].my_each_with_index).to be_a(Enumerator)
    end
  end
end
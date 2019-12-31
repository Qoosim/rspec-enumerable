# frozen_string_literal: true

require './lib/enumerables.rb'
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

end
require 'spec_helper'

describe Array do
  context '#product' do
    subject { ["a", "b", "c"].product [1, 2] }
    let(:expected) { [["a", 1], ["a", 2], ["b", 1], ["b", 2], ["c", 1], ["c", 2]] }
    specify { should eq expected }
  end
  context '#product error' do
    let(:messup) { [].product [1,2] }
    specify { expect { messup }.to raise_error Array::ProductWithEmptyArray }
  end
end
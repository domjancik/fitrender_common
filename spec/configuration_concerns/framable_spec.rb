require 'spec_helper'

describe Fitrender::ConfigurationConcerns::Framable do
  class TestFramable
    include Fitrender::Configurable
    include Fitrender::ConfigurationConcerns::Framable
  end

  before :example do
    @framable = TestFramable.new
  end

  it 'supports setting a single frame' do
    @framable.option_set_value('frames', '3')
    expect(@framable.frames).to eq([3])
  end

  it 'supports setting multiple frame separated by commas' do
    @framable.option_set_value('frames', '1,3,5')
    expect(@framable.frames).to include(1,3,5)
    expect(@framable.frames.length).to eq(3)
  end

  it 'supports setting frame ranges' do
    @framable.option_set_value('frames', '3-5,8-10')
    expect(@framable.frames).to include(3,4,5,8,9,10)
    expect(@framable.frames.length).to eq(6)

  end

  it 'supports mixing frame ranges and single frames' do
    @framable.option_set_value('frames', '1,3-5,7')
    expect(@framable.frames).to include(1,3,4,5,7)
    expect(@framable.frames.length).to eq(5)
  end

  it 'deals with duplicates' do
    @framable.option_set_value('frames', '3-5,4-7,6')
    expect(@framable.frames).to include(3,4,5,6,7)
    expect(@framable.frames.length).to eq(5)
  end
end

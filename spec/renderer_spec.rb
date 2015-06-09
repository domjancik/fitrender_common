require 'spec_helper'

describe Fitrender::Adaptor::Renderer do

  OPTION_NAME = 'option'
  OPTION_DEFAULT = 'default'
  OPTION_DESCRIPTION = 'description'

  class TestGenerator < Fitrender::Adaptor::Generator
    def initialize
      super

      option_add OPTION_NAME, OPTION_DEFAULT, OPTION_DESCRIPTION
    end
  end

  NAME = 'name'
  EXTENSION = 'extension'
  GENERATOR = TestGenerator.new
  VERSION = '1'

  before :context do
    @renderer = Fitrender::Adaptor::Renderer.new NAME, EXTENSION, GENERATOR, VERSION
  end

  def get_deserialized
    hash = @renderer.to_hash
    Fitrender::Adaptor::Renderer.from_hash(hash)
  end

  it 'has a working to_hash and from_hash methods, excluding generator options' do
    deserialized = get_deserialized

    expect(deserialized.id).to eq(@renderer.id)
    expect(deserialized.extension).to eq(@renderer.extension)
    expect(deserialized.version).to eq(@renderer.version)
  end

  it 'provides serialization of generator options' do
    deserialized = get_deserialized

    expect(deserialized.generator_options).to eq(@renderer.generator_options)
  end

  it 'presents the options of the generator' do
    @renderer.generator.options_list.each do |option|
      expect(@renderer.generator_options).to include(option)
    end
  end
end
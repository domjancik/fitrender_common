require 'spec_helper'

describe Fitrender::Adaptor::Renderer do
  NAME = 'name'
  EXTENSION = 'extension'
  GENERATOR = nil
  VERSION = '1'

  before :context do
    @renderer = Fitrender::Adaptor::Renderer.new NAME, EXTENSION, GENERATOR, VERSION
  end

  it 'has a working to_hash and from_hash methods (generator is not expected to be serialized)' do
    hash = @renderer.to_hash
    deserialized = Fitrender::Adaptor::Renderer.from_hash(hash)

    expect(deserialized.name).to eq(@renderer.name)
    expect(deserialized.extension).to eq(@renderer.extension)
    expect(deserialized.version).to eq(@renderer.version)
  end
end
require 'spec_helper'

describe Fitrender::Adaptor::BaseAdaptor do
  it 'has a version number' do
    expect(Fitrender::Common::VERSION).not_to be nil
  end
end

describe Fitrender::Adaptor::Node do
  ID = 'node_identifier'
  STATE = Fitrender::Adaptor::States::NODE_STATE_IDLE
  ATTRIBUTES = { attr_one: 'value_one', attr_two: 'value_two' }

  before :context do
    @node = Fitrender::Adaptor::Node.new(ID, STATE, ATTRIBUTES)
  end

  it 'holds given values' do
    expect(@node.id).to eq(ID)
    expect(@node.state).to eq(STATE)
    expect(@node.attributes).to eq(ATTRIBUTES)
  end

  it 'serializes into a hash' do
    hash = @node.to_hash
    expect(hash[:id]).to eq(@node.id)
    expect(hash[:state]).to eq(@node.state)
    expect(hash[:attributes]).to eq(@node.attributes)
  end

  it 'deserializes from a hash' do
    hash = {
        id: ID,
        state: STATE,
        attributes: ATTRIBUTES
    }

    node = Fitrender::Adaptor::Node.from_hash(hash)

    expect(node.id).to eq(ID)
    expect(node.state).to eq(STATE)
    expect(node.attributes).to eq(ATTRIBUTES)
  end
end
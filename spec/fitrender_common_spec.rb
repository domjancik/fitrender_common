require 'spec_helper'

describe Fitrender::Adaptor::BaseAdaptor do
  RENDERER_NAME = 'Renderer'
  RENDERER_EXTENSION = '.render'
  RENDERER_NAME_2 = 'Other renderer'

  before :example do
    @adaptor = Fitrender::Adaptor::BaseAdaptor.new
    @scene = Fitrender::Adaptor::Scene.new
    @scene.renderer = RENDERER_NAME
    @renderer = Fitrender::Adaptor::Renderer.new(RENDERER_NAME, RENDERER_EXTENSION, nil)
  end

  it 'has a version number' do
    expect(Fitrender::Common::VERSION).not_to be nil
  end

  it 'supports adding renderers' do
    expect(@adaptor.renderers.count).to eq(0)
    @adaptor.add_renderer @renderer
    expect(@adaptor.renderers.count).to eq(1)
    expect(@adaptor.renderers).to include(@renderer)
  end

  it 'detects renderer from a scene' do
    @adaptor.add_renderer @renderer
    expect(@adaptor.detect_renderer(@scene)).to eq(@renderer)
  end

  it 'throws an error when the renderer is not found' do
    expect { @adaptor.detect_renderer(@scene) }.to raise_error(Fitrender::RendererNotFoundError)
  end
end

describe Fitrender::Adaptor::Node do
  ID = 'node_identifier'
  STATE = Fitrender::Adaptor::States::NODE_STATE_IDLE
  ATTRIBUTES = { attr_one: 'value_one', attr_two: 'value_two' }

  before :context do
    @node = Fitrender::Adaptor::Node.new(ID, STATE, ATTRIBUTES)
  end

  def expect_values(node)
    expect(node.id).to eq(ID)
    expect(node.state).to eq(STATE)
    expect(node.attributes).to eq(ATTRIBUTES)
  end

  it 'holds given values' do
    expect_values(@node)
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

    expect_values(node)
  end

  it 'deserializes from a string keyed hash' do
    hash = {
        'id' => ID,
        'state' => STATE,
        'attributes' => ATTRIBUTES
    }

    node = Fitrender::Adaptor::Node.from_hash(hash)

    expect_values(node)
  end
end
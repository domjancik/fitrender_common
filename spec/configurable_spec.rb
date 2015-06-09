require 'spec_helper'

EXISTING_OPTION = 'existing_option'
NONEXISTING_OPTION = 'nonexisting_option'
DESCRIPTION = 'description text'
DEFAULT_VALUE = 'default'
OTHER_VALUE = 'other'

# Basic variant

class Configurable
  include Fitrender::Configurable
end

class ConfigurablePreset
  include Fitrender::Configurable

  def initialize
    super
    option_add EXISTING_OPTION, DEFAULT_VALUE, DESCRIPTION
  end
end

describe Configurable do
  before :example do
    @object = ConfigurablePreset.new
  end

  def has_option?(object, option_id)
    object.options_list.any? { |option| option.id.eql?(option_id) }
  end

  it 'can add options' do
    barebones_obj = Configurable.new
    expect(barebones_obj.options_list).to be_empty
    barebones_obj.option_add EXISTING_OPTION, DEFAULT_VALUE, DESCRIPTION
    expect(barebones_obj.options_list.size).to eq(1)
    expect(has_option?(barebones_obj, EXISTING_OPTION)).to eq(true)
  end

  it 'retrieves default values' do
    option = @object.option_get EXISTING_OPTION
    expect(option.id).to eq(EXISTING_OPTION)
    expect(option.value).to eq(DEFAULT_VALUE)
    expect(option.default).to eq(DEFAULT_VALUE)
    expect(option.description).to eq(DESCRIPTION)

    expect(@object.option_value EXISTING_OPTION).to eq(DEFAULT_VALUE)
  end

  it 'can set config values' do
    expect(@object.option_value EXISTING_OPTION).to eq(DEFAULT_VALUE)
    @object.option_set_value(EXISTING_OPTION, OTHER_VALUE)
    expect(@object.option_value EXISTING_OPTION).to eq(OTHER_VALUE)
  end

  it 'cannot set nonexistent config values' do
    expect { @object.option_set_value('nonexistant_name', 'value') }.to raise_error(Fitrender::NotFoundError)
  end
end

# File backed variant

class ConfigurableWithFile
  include Fitrender::ConfigurableWithFile

  def initialize
    super
    option_add EXISTING_OPTION, DEFAULT_VALUE, DESCRIPTION
  end
end

describe ConfigurableWithFile do
  def get_instance
    ConfigurableWithFile.new
  end

  around :example do |example|
    @object = get_instance
    expect(FileTest.exists? @object.config_filename).to eq(false)
    example.run
    File.delete @object.config_filename
  end

  it 'loads a changed value in a new instance' do
    expect(@object.option_value EXISTING_OPTION).to eq(DEFAULT_VALUE)
    @object.option_set_value(EXISTING_OPTION, OTHER_VALUE)
    expect(@object.option_value EXISTING_OPTION).to eq(OTHER_VALUE)

    other_instance = get_instance
    expect(other_instance.option_value EXISTING_OPTION).to eq(OTHER_VALUE)
  end
end
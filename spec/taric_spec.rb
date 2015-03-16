require 'spec_helper'

describe Taric do
  it 'has a version number' do
    expect(Taric::VERSION).not_to be nil
  end

  context 'when delegating to client' do
    before do
      stub_get(Taric::Operation::LolStatus::SHARDS).to_return(body: fixture('shards.json'))
    end

    it 'should get resource' do
      Taric.shards
      expect(a_get(Taric::Operation::LolStatus::SHARDS)).to have_been_made
    end

    it 'should be the same' do
      expect(Taric.shards).to eq(Taric.client.shards)
    end
  end
end

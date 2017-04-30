require 'spec_helper'

describe Taric::Operation::Match do
  let(:client) {Taric.client(api_key:'test')}

  describe '#match' do
    let(:id) {1733750076}
    let(:url) {expand_template(Taric::Operation::Match::MATCH_V3.template_url, {matchId: id})}

    before {stub_get(url).to_return(body: fixture('match-v3.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.match(match_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.match(match_id: id).body
      expect(result).to be_a Hash
      expect(result['gameId']).to eq(id)
    end
  end

  describe '#match_timeline' do
    let(:id) { 2455977577 }
    let(:url) {expand_template(Taric::Operation::Match::MATCH_TIMELINE_V3.template_url, {matchId: id})}

    before {stub_get(url).to_return(body: fixture('match_timeline-v3.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.match_timeline(match_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.match_timeline(match_id: id).body
      expect(result).to be_a Hash
      expect(result['frames']).to be_an (Array)
    end
  end

  describe '#matchlist' do
    let(:account_id) { 47910 }
    let(:url) { expand_template(Taric::Operation::Match::MATCHLIST_V3.template_url, {accountId: account_id}) }

    before {stub_get(url).to_return(body: fixture('matchlist-v3.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.matchlist(account_id: account_id)
      expect(a_get(url)).to have_been_made
    end
  end

  describe '#matchlist_recent' do
    let(:account_id) { 47910 }
    let(:url) { expand_template(Taric::Operation::Match::MATCHLIST_RECENT_V3.template_url, {accountId: account_id}) }

    before {stub_get(url).to_return(body: fixture('matchlist_recent-v3.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.matchlist_recent(account_id: account_id)
      expect(a_get(url)).to have_been_made
    end
  end

end
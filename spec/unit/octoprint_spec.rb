RSpec.describe Octoprint do
  let(:url) { 'https://example.com' }
  let(:api_key) { '123ABC' }
  
  subject { Octoprint.new url, api_key }
  
  describe '#initialize' do
    it 'sets an URL and an API key at initialization' do
      expect(subject.instance_variable_get(:@url)).to eq url
      expect(subject.instance_variable_get(:@api_key)).to eq api_key
    end
  end

  describe '#api' do
    it 'is an Octoprint::API object' do
      expect(subject.api).to be_kind_of Octoprint::API
    end

    it 'lazily assigns api to @api' do
      expect(subject.instance_variable_get(:@api)).to be_nil
      subject.api
      expect(subject.instance_variable_get(:@api)).to be_kind_of Octoprint::API
    end
  end
end

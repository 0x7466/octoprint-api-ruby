RSpec.describe Octoprint::API do
  let(:url) { 'https://example.com' }
  let(:api_key) { '123ABC' }
  let(:invalid_api_key) { '123ABCinvalid' }

  let(:mock_version_response) { '{"api": "0.1", "server": "1.5.0"}' }
  
  subject { Octoprint::API.new url, api_key }

  before do
    # Valid version request
    stub_request(:get, [url, 'api', 'version'].join('/')).
      with(headers: { 'X-Api-Key' => api_key }).
      to_return(status: 200, body: mock_version_response, headers: { 'Content-Type' => 'application/json' })
  
    # Unauthorized request
    stub_request(:get, [url, 'api', 'version'].join('/')).
      with(headers: { 'X-Api-Key' => invalid_api_key }).
      to_return(status: 401, body: 'Invalid API key')

    # Invalid request but authorized (404)
    stub_request(:get, [url, 'api', 'invalid'].join('/')).
      with(headers: { 'X-Api-Key' => api_key }).
      to_return(status: 404, body: '')
  end
  
  describe '#initialize' do
    it 'sets an URL and an API key at initialization' do
      expect(subject.instance_variable_get(:@url)).to eq url
      expect(subject.instance_variable_get(:@api_key)).to eq api_key
    end
  end

  describe '#method_missing' do
    it 'tries to request server for undefined methods' do
      expect(subject.version).to eq JSON.parse mock_version_response
    end

    it 'raises a Octoprint::ResponseError if unauthorized' do
      subject = Octoprint::API.new url, invalid_api_key

      expect {
        subject.version
      }.to raise_error(Octoprint::ResponseError)
    end

    it 'raises a NoMethodError if invalid request' do
      expect {
        subject.invalid
      }.to raise_error(NoMethodError)
    end
  end

  describe '#respond_to_missing?' do
    it 'is true for valid api requests' do
      expect(subject.respond_to?(:version)).to be true
    end

    it 'is false for invalid api requests' do
      expect(subject.respond_to?(:invalid)).to be false
    end
  end

  context 'private' do
    describe '#_connection' do
      let(:connection) { subject.send :_connection }

      it 'lazily assigns @_connection' do
        expect(subject.instance_variable_get(:@_connection)).to be_nil
        subject.send :_connection
        expect(subject.instance_variable_get(:@_connection)).to be_kind_of Faraday::Connection
      end

      it 'sets X-Api-Key' do
        expect(connection.headers['X-Api-Key']).to eq api_key
      end

      it 'sets Content-Type to application/json' do
        expect(connection.headers['Content-Type']).to eq 'application/json'
      end
    end

    describe '#parse' do
      it 'parses JSON' do
        raw_json_string = '{"hello": "world"}'
        json_string = { "hello" => "world" }

        expect(subject.send(:parse, raw_json_string)).to eq json_string
      end
    end

    describe '#convert_method_name_into_http_path' do
      it 'replaces underscores (_) with slashes (/)' do
        method_name = 'he_llo_wor_ld'
        path_name = 'he/llo/wor/ld'
        expect(subject.send(:convert_method_name_into_http_path, method_name)).to eq path_name
      end

      it 'accepts symbols but does return string' do
        method_name = :he_llo_wor_ld
        path_name = 'he/llo/wor/ld'
        expect(subject.send(:convert_method_name_into_http_path, method_name)).to eq path_name
      end
    end

    describe '#generate_api_path' do
      it 'converts string to path string and prepends api/' do
        method_name = 'hello_world'
        api_path = 'api/hello/world'
        expect(subject.send(:generate_api_path, method_name)).to eq api_path
      end
    end

    describe '#name_qualified_for_api_request?' do
      it 'is false if name begins with underscore (_)' do
        method_name = '_not_qualified'
        expect(subject.send(:name_qualified_for_api_request?, method_name)).to be false
      end

      it 'is true if name does not start with underscore (_)' do
        method_name = 'qualified_name'
        expect(subject.send(:name_qualified_for_api_request?, method_name)).to be true
      end
    end
  end
end

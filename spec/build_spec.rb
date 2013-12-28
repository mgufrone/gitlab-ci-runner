require_relative 'spec_helper'
require_relative '../lib/build'

describe 'Build' do
  describe :run do
    let(:build) { GitlabCi::Build.new(build_data) }

    before { build.run }

    it { build.trace.should include 'php -v' }
    it { build.trace.should include 'HEAD is now at dd889e3' }
    it { build.trace.should include 'sudo apt-get install poppler-utils'}
    it { build.state.should == :success }
  end
  
  def build_data
    {
      commands: ['php -v'],
      project_id: 0,
      id: 9312,
      ref: 'dd889e3494c1ca74be571481bf4aacfe0202034a',
      repo_url: 'https://github.com/mgufrone/pdf-to-html'
    }
  end
end


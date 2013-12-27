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
  describe :run_with_ftp do
    let(:build) { GitlabCi::Build.new(build_ftp_data) }

    it { build.trace.should include 'php -v' }
    it { build.trace.should include 'HEAD is now at 895a9ba' }
    # it { build.trace.should include 'sudo apt-get install poppler-utils'}
    it { build.trace.should include 'git config git-ftp.staging.user gitlab_ci_runner'}
    it { build.trace.should include 'git config git-ftp.staging.password git'}
    it { build.trace.should include 'git config git-ftp.staging.url 103.27.207.4/public_html/'}
    it { build.trace.should include 'git config git-ftp.staging.insecure 1'}
    it { build.trace.should include "git config git-ftp.staging.deployedsha1file #{Digest::MD5.digest('project-1')}"}
    it { build.trace.should include "git ftp staging init"}
    it { build.state.should == :success }

  end
  def build_ftp_data
    {
      commands:['php -v'],
      project_id: 1,
      id: 9415,
      ref: '895a9ba4ed594acabefaed0a6408184d83eb051c',
      repo_url:'git@terapkan.com:gufron/test-script.git'
    }
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


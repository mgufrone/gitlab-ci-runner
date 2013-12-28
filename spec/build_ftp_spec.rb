require_relative 'spec_helper'
require_relative '../lib/build'

describe 'BuildFtp' do
  describe :run do
    let(:build) { GitlabCi::Build.new(build_data) }

    before { build.run }
    it { build.trace.should include 'php -v' }
    it { build.trace.should include 'HEAD is now at 03e7cae' }
    it { build.trace.should include 'git config git-ftp.staging.username gitlab_ci_runner'}
    it { build.trace.should include 'git config git-ftp.staging.password git'}
    it { build.trace.should include 'git config git-ftp.staging.url ftp://103.27.207.4/public_html/'}
    # it { build.trace.should include 'git config git-ftp.staging.insecure 1'}
    it { build.trace.should include "git config git-ftp.staging.deployedsha1file #{Digest::MD5.hexdigest('project-1').to_s}"}
    it { build.trace.should include "git ftp init -s staging"}
    it { build.state.should == :success }

  end
  
  def build_data
    {
      commands:['php -v'],
      project_id: 1,
      id: 9415,
      ref: '03e7cae86fb42db704fc6d930ed49fbad4db6790',
      repo_url:'git@terapkan.com:gufron/test-script.git'
    }
  end
end


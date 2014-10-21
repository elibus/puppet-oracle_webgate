require 'spec_helper'

describe 'oracle_webgate_exists' do
  it { should run.with_params('/tmp','10.1.4').and_return(false) }
end

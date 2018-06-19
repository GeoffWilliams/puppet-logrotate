require 'spec_helper'
describe 'logrotate' do
  context 'with default values for all parameters' do
    it { should contain_class('logrotate') }
  end
end

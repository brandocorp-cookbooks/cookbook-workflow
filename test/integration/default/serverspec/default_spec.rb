require_relative 'spec_helper'

describe file('/opt/workflow') do
  it { should be_directory }
end

describe user('workflow') do
  it { should exist }
end
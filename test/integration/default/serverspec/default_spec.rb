require_relative 'spec_helper'

describe file('/opt/workflow') do
  it { is_expected.to be_directory }
end

describe user('workflow') do
  it { is_expected.to exist }
end

describe group('workflow') do
  it { is_expected.to exist }
end

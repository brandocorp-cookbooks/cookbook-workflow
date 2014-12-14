require 'chefspec'

describe 'cookbook-workflow::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates the workflow directory' do
    expect(chef_run).to create_directory('workflow')
  end

  it 'creates the workflow user' do
    expect(chef_run).to create_user('workflow')
  end
end
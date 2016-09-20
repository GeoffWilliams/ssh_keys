require 'spec_helper'
describe 'sshkeys::install_keypair', :type => :define do
  let :pre_condition do
    '
    $concat_basedir = "/tmp/concat"
    class { "sshkeys": }'
  end
 
  # mock the file function, adapted from
  # https://github.com/TomPoulton/rspec-puppet-unit-testing/blob/master/modules/foo/spec/classes/bar_spec.rb

  # FIXME how to replace the function?

  before(:each) do
    Puppet::Functions.create_function(:'sshkeys::sshkey') do
      def sshkey
        'DEADBEEF'
      end
    end

    # replace puppet's file() function with one that always returns a fixed string
    #MockFunction.new('sshkeys::sshkey') { |f|
    #  f.stubs(:call).returns('DEADBEEF')
    #}
  end

  context "compiles ok" do
    let :title do
      "alice@mylaptop.localdomain"
    end
    it { should compile }
  end

end

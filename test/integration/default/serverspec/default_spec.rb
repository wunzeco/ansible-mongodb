require 'spec_helper'

describe group('mongodb') do
  it { should exist }
end

describe user('mongodb') do
  it { should exist }
  it { should belong_to_group 'mongodb' }
end

describe package('mongodb-org') do
  it { should be_installed }
end

describe file('/var/lib/mongodb') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'mongodb' }
end

describe file('/etc/mongod.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end

describe service('mongod') do
  it { should be_enabled }
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
end

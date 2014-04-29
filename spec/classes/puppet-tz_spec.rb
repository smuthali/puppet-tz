require 'spec_helper'
describe 'puppet-tz' do
	let :default_params do
		{
			:timezone	=>	'UTC'
		}
	end

		it { should contain_class('puppet-tz::params').with_timezone('') }

		describe "For supported operatingsystem: Ubuntu" do
			let (:facts) { {:operatingsystem => 'Ubuntu'} }
			it { should contain_package('tzdata').with_ensure('installed') }

			it { should contain_exec('Setting Timezone').with(
				:command 	=>	'echo ${timezone}|sudo tee /etc/timezone;sudo dpkg-reconfigure --frontend noninteractive tzdata',
				:logoutput 	=>	'on_failure',
				:path 		=>	'/usr/bin:/usr/sbin:/bin:/usr/local/bin',
				:require 	=>	'Package[tzdata]',
				) }
		end

		['Redhat', 'CentOS'].each do |operatingsystem|
			let :facts do
				{
					:operatingsystem	=>	operatingsystem,
				}
			end
			
			describe "For support operatingsystem: #{operatingsystem}" do
				it { should contain_package('tzdata').with_ensure('installed') }
				it { should contain_file('/etc/sysconfig/clock').with(
					:ensure  	=>	'file',
					:content	=>	'`${timezone}\n`',
					:owner		=>	'root',
					:group		=>	'root',
					:mode		=>	'0644',
					:before		=>	'File[/etc/localtime/${zoneinfo}]',
					) }

				it { should contain_file('/etc/localtime').with(
					:ensure 	=>	'link',
					:target		=>	'/usr/share/zoneinfo/${timezone}',
					:owner		=>	'root',
					:group		=>	'root',
					:mode		=>	'0644',
					:require 	=>	'File[/etc/sysconfig/clock]',
					)	}
			end
			end
end
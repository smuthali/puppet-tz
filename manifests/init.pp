class puppet-tz (
    $timezone = 'UTC',
    #notice("The timezone string value is: '${timezone}'"),
    ) inherits puppet-tz::params {
				#notice(" The tz string is: '${timezone}'")
			    case $::operatingsystem {
	        "ubuntu": {
	        	package {
	        	    'tzdata':
	        	        ensure      => installed,
	        	    }
	        	notice(" The tz string is: '${timezone}'")
	        	exec {
	        	    'Setting Timezone':
	        	        command     => "echo ${timezone}|sudo tee /etc/timezone;sudo dpkg-reconfigure --frontend noninteractive tzdata",
	        	        logoutput   => on_failure,
	        	        path   		=> '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
	        	        require     => Package['tzdata'];
	        		}
	        	}

	        redhat, centos: {
	        	package {
	        	    'tzdata':
	        	        ensure      => installed,
	        	    }
	        	file {
	        	    '/etc/sysconfig/clock':
	        	        ensure  	=> file,
	        	        content 	=> "`${timezone}\n`",
	        	        owner   	=> 'root',
	        	        group   	=> 'root',
	        	        mode    	=> '0644',
	        	        before 		=> File['/etc/localtime/${zoneinfo}'];
	        	}
	        	file {
	        	    '/etc/localtime/`${timezone}`':
	        	        ensure  	=> link,
	        	        target  	=> '/usr/share/zoneinfo',
	        	        owner   	=> 'root',
	        	        group   	=> 'root',
	        	        mode    	=> '0644',
	        	        require 	=> File[ '/etc/sysconfig/clock' ];
	        	}
	        }
	        default: {
	            fail("Unsupported platform: ${::operatingsystem}")
	        }
	    }
	}
# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include getmail::install
class getmail::install {

  $getmail_url = 'http://pyropus.ca/software/getmail/old-versions/getmail-5.14.tar.gz'

  archive { '/tmp/getmail-5.14.tar.gz':
    ensure        => present,
    extract       => true,
    extract_path  => '/tmp',
    source        => $getmail_url,
    cleanup       => true,
    checksum      => '03cc39ca8a5533abc8e88f460a251f92f2f2e2c3',
    checksum_type => 'sha1',
    notify        => Exec['Install getmail'],
  }

  class {'python':
    version    => '2.7',
    ensure     => present,
    pip        => 'present',
    virtualenv => 'present',
  }

  exec { 'Install getmail':
    command     => 'python2 setup.py install',
    cwd         => '/tmp/getmail-5.14',
    path        => '/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/local/bin',
    refreshonly => true,
    require     => Class['python'],
  }
}

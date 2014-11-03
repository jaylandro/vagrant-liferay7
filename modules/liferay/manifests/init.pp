class liferay {
  require java, mysql

  $install_path = "/opt/liferay"

  exec {"stop-liferay":
    command => "${install_path}/liferay-portal-7.0-ce-m2/tomcat-7.0.42/bin/catalina.sh stop",
    onlyif => "test -f ${install_path}/liferay-portal-7.0-ce-m2/tomcat-7.0.42/bin/catalina.sh",
    path => ["/usr/bin", "/bin"],
  }

  exec {"clean-liferay":
    command => "rm -fR ${install_path}/*",
    path => ["/usr/bin", "/bin"],
    require => Exec["stop-liferay"]
  }

  package {"wget":
    ensure => present
  }

  exec {"get-liferay":
    command => "wget http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/7.0.0%20M2/liferay-portal-tomcat-7.0-ce-m2-20141017162509960.zip -O /home/vagrant/liferay.zip",
    cwd => "/home/vagrant",
    path => ["/usr/bin", "/bin"],
    require => Package["wget"],
    timeout => 600
  }

  package {"unzip":
    ensure => present
  }

  file {"${install_path}":
    ensure => "directory"
  }

  exec {"unzip-liferay":
    command => "unzip /home/vagrant/liferay.zip",
    cwd => "${install_path}",
    require => [Exec["get-liferay"], Package["unzip"], File["${install_path}"], Exec["clean-liferay"]],
    path => ["/usr/bin", "/bin"],
  }

  file {"portal-ext.properties":
    path => "${install_path}/liferay-portal-7.0-ce-m2/tomcat-7.0.42/webapps/ROOT/WEB-INF/classes/portal-ext.properties",
    source => "puppet:///modules/liferay/portal-ext.properties",
    require => Exec["unzip-liferay"]
  }

  exec {"start-liferay":
    command => "${install_path}/liferay-portal-7.0-ce-m2/tomcat-7.0.42/bin/catalina.sh start",
    onlyif => "test -f ${install_path}/liferay-portal-7.0-ce-m2/tomcat-7.0.42/bin/catalina.sh",
    path => ["/usr/bin", "/bin"],
    require => File["portal-ext.properties"]
  }
}
class mysql::service {

    include mysql::install

    $service_name = "mysql"

    service { "$service_name":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        enable => true,
        require => Exec["install-db"],
        notify => Exec["set-root-password"]
    }
}

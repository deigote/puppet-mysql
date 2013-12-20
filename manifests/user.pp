define mysql::user($user, $password, $database, $host = 'localhost', $privileges = 'ALL PRIVILEGES') {

    include mysql

    $grant_sql = "GRANT $privileges ON $database.* TO '$user'@'$host' IDENTIFIED BY '$password';"

    exec { "grant-$user-to-database-$database-$host":
        command => "echo \"$grant_sql\" | mysql -u root -p$mysql::install::root_pwd",
	    require => Mysql::Database["$database"],
    } 

    exec { "flush-priviliges-$user-$database-$host"
    	command => "echo \"flush privileges;\" | mysql -u root -p$mysql::install::root_pwd",
    	require => Mysql::Database["$database"],
    }
    
}

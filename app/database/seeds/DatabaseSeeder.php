<?php

class DatabaseSeeder extends Seeder {
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
            Eloquent::unguard();

            // Create the default
            $this->call('UserTableSeeder');
            $this->call('RoleTableSeeder');
            $this->call('RoleAssignmentsSeeder');
    }

}

/**
 * This function creates the default roles on the system
 */
class UserTableSeeder extends Seeder {
    public function run() {
        
        $default_users = array(
            array(
                'firstname'=>'Sandeep',
                'lastname' => 'Gill',
                'email' => 'sandeep@lingellearning.com',
                'city'=>'Melbourne',
                'country'=>'AU',
                'organisation'=>'Lingel Learning',
                'description'=>'Sample desc',
                'picture'=>'',
                'suspended'=>0,
                'username'=>'sandeep.gill',
                'password'=>Hash::make('password')
            ),
        );
        DB::table('users')->insert($default_users);
    }
}


/**
 * This function creates the default roles on the system
 */
class RoleTableSeeder extends Seeder {
    public function run() {
        
        // Drop the table if it exists
        DB::table('roles')->delete();
        
        $default_roles = array(
            array(
                'name'=>'admin'
            ),
            array(
                'name'=>'prouser'
            ),
            array(
                'name'=>'enduser'
            )
        );
        DB::table('roles')->insert($default_roles);
    }
}


/**
 * This function creates the default roles on the system
 */
class RoleAssignmentsSeeder extends Seeder {
    public function run() {
        
        $default_roles = array(
            array(
                'user_id'=>1,
                'role_id'=>1,
                'createdby'=>1
            ),
        );
        DB::table('role_assignments')->insert($default_roles);
    }
}

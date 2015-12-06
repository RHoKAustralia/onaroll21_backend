<?php

use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('users', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->string('username')->unique();
                $table->string('password');
                $table->string('firstname');
                $table->string('lastname');
                $table->string('email');
                $table->string('city');
                $table->string('country');
                $table->string('organisation');
                $table->string('description');
                $table->string('picture');
                $table->boolean('suspended');
                $table->timestamps();
            });
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
            Schema::dropIfExists('users');
	}

}
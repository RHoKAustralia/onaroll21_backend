<?php

use Illuminate\Database\Migrations\Migration;

class CreateRoleTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('roles', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->string('name');
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
            //
            Schema::dropIfExists('roles');
	}

}
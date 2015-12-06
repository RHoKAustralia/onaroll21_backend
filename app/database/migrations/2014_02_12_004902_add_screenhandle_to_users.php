<?php

use Illuminate\Database\Migrations\Migration;

class AddScreenhandleToUsers extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
             Schema::table('users',function($table){
                $table->string('screenhandle')->after('password')->default('');
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
	}

}
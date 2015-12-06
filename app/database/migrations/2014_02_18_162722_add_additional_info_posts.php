<?php

use Illuminate\Database\Migrations\Migration;

class AddAdditionalInfoPosts extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
             Schema::table('posts',function($table){
                $table->binary('thumbnail')->after('status')->nullable();
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
<?php

use Illuminate\Database\Migrations\Migration;

class AddSurveyFieldToGroups extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
             Schema::table('groups',function($table){
                $table->integer('survey')->after('outcome')->nullable();
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
<?php

use Illuminate\Database\Migrations\Migration;

class AddPostSurveyFieldToGroups extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
             Schema::table('groups',function($table){
                $table->integer('postsurvey')->after('survey')->nullable();
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
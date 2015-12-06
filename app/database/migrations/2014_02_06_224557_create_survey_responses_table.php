<?php

use Illuminate\Database\Migrations\Migration;

class CreateSurveyResponsesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('survey_response', function($table)
            {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->integer('user_id')->unsigned();
                $table->integer('group_id')->unsigned();
                $table->integer('survey_id')->unsigned();
                $table->string('type');
                $table->binary('response');
                $table->foreign('user_id')
                       ->references('id')->on('users')
                       ->onDelete('cascade');
                $table->foreign('group_id')
                       ->references('id')->on('groups')
                       ->onDelete('cascade');
                $table->foreign('survey_id')
                        ->references('id')->on('surveys')
                        ->onDelete('cascade');
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
            Schema::dropIfExists('survey_response');
	}

}
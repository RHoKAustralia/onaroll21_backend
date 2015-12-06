<?php

use Illuminate\Database\Migrations\Migration;

class CreateSurveyMessageTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		//
            Schema::create('survey_messages', function($table)
            {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->integer('survey_id')->unsigned();
                $table->binary('premessage');
                $table->binary('postmessage');
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
            Schema::dropIfExists('survey_messages');
	}

}
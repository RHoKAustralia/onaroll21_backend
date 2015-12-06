<?php

use Illuminate\Database\Migrations\Migration;

class CreateWellbeingTrackerTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('wellbeing_tracks', function($table)
            {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->integer('user_id')->unsigned();
                $table->integer('group_id')->unsigned();
                $table->integer('task_id')->unsigned();
                $table->string('mood');
                $table->foreign('user_id')
                       ->references('id')->on('users')
                       ->onDelete('cascade');
                $table->foreign('group_id')
                       ->references('id')->on('groups')
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
            Schema::dropIfExists('wellbeing_tracks');
	}

}
<?php

use Illuminate\Database\Migrations\Migration;

class CreateUserLoginTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		//
            Schema::create('user_log', function($table)
            {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->integer('user_id')->unsigned();
                $table->string('type');
                $table->foreign('user_id')
                       ->references('id')->on('users')
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
            Schema::dropIfExists('user_log');
	}

}
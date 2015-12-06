<?php

use Illuminate\Database\Migrations\Migration;

class CreateMessagesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('messages', function($table)
            {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->integer('from')->unsigned();
                $table->integer('to')->unsigned();
                $table->foreign('from')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->foreign('to')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->string('message',5000);
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
            Schema::dropIfExists('messages');
	}

}
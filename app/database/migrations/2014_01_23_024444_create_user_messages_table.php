<?php

use Illuminate\Database\Migrations\Migration;

class CreateUserMessagesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('user_messages', function($table)
            {
                $table->engine = 'InnoDB';
                $table->integer('user_id')->unsigned();
                $table->integer('message_id')->unsigned();
                $table->foreign('user_id')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->foreign('message_id')
                        ->references('id')->on('messages')
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
            Schema::dropIfExists('user_messages');
	}

}
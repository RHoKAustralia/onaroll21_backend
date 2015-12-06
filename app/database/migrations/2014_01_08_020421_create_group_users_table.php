<?php

use Illuminate\Database\Migrations\Migration;

class CreateGroupUsersTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('group_users', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->integer('group_id')->unsigned();
                $table->integer('user_id')->unsigned();
                $table->foreign('group_id')
                        ->references('id')->on('groups')
                        ->onDelete('cascade');
                $table->foreign('user_id')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->primary(array('group_id','user_id'));
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
            Schema::dropIfExists('group_users');
	}

}
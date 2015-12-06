<?php

use Illuminate\Database\Migrations\Migration;

class CreatePostsTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('posts', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->integer('group_id')->unsigned();
                $table->integer('user_id')->unsigned();
                $table->integer('task_id')->unsigned();
                $table->foreign('group_id')
                        ->references('id')->on('groups')
                        ->onDelete('cascade');
                $table->foreign('user_id')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->foreign('task_id')
                        ->references('id')->on('tasks')
                        ->onDelete('cascade');
                $table->string('statustype');
                $table->string('status');
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
            Schema::dropIfExists('posts');
	}

}
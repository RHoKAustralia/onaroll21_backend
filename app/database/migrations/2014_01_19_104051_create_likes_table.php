<?php

use Illuminate\Database\Migrations\Migration;

class CreateLikesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('likes', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->integer('post_id')->unsigned();
                $table->integer('user_id')->unsigned();
                $table->foreign('post_id')
                        ->references('id')->on('posts')
                        ->onDelete('cascade');
                $table->foreign('user_id')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->unique('post_id','user_id');
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
            Schema::dropIfExists('likes');
	}

}
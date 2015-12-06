<?php

use Illuminate\Database\Migrations\Migration;

class CreateUserTasksTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('user_tasks', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->integer('user_id')->unsigned();
                $table->integer('group_id')->unsigned();
                $table->integer('outcome_id')->unsigned();
                $table->integer('task_id')->unsigned();
                $table->foreign('user_id')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->foreign('group_id')
                        ->references('id')->on('groups')
                        ->onDelete('cascade');
                $table->foreign('outcome_id')
                        ->references('id')->on('outcomes')
                        ->onDelete('cascade');
                $table->foreign('task_id')
                        ->references('id')->on('tasks')
                        ->onDelete('cascade');
                $table->timestamps();
                //$table->unique('user_id','group_id','outcome_id','task_id');
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
            Schema::dropIfExists('user_tasks');
	}

}
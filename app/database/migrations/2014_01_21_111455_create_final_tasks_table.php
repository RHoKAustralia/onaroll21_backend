<?php

use Illuminate\Database\Migrations\Migration;

class CreateFinalTasksTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('final_task', function($table)
            {
                $table->engine = 'InnoDB';
                $table->integer('outcome_id')->unsigned();
                $table->integer('task_id')->unsigned();
                $table->foreign('outcome_id')
                        ->references('id')->on('outcomes')
                        ->onDelete('cascade');
                $table->foreign('task_id')
                        ->references('id')->on('tasks')
                        ->onDelete('cascade');
                $table->unique('outcome_id','task_id');
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
            Schema::dropIfExists('final_task');
	}

}
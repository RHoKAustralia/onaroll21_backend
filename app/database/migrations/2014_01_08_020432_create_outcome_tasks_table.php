<?php

use Illuminate\Database\Migrations\Migration;

class CreateOutcomeTasksTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('outcome_tasks', function($table)
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
                $table->primary(array('outcome_id','task_id'));
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
            Schema::dropIfExists('outcome_tasks');
	}

}
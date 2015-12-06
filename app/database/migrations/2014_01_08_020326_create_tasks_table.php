<?php

use Illuminate\Database\Migrations\Migration;

class CreateTasksTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
             Schema::create('tasks', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->integer('number');
                $table->string('name');
                $table->string('description');
                $table->string('didyouknow');
                $table->string('reference');
                $table->integer('suspended');
                $table->integer('createdby');
                $table->integer('author');
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
            Schema::dropIfExists('tasks');
	}

}
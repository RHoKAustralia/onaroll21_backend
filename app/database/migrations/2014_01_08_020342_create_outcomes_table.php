<?php

use Illuminate\Database\Migrations\Migration;

class CreateOutcomesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('outcomes', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->string('name');
                $table->string('description');
                $table->integer('type');
                $table->integer('taskcount');
                $table->integer('createdby');
                $table->boolean('suspended');
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
            Schema::dropIfExists('outcomes');
	}

}
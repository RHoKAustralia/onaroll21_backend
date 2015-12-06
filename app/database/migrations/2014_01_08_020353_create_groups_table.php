<?php

use Illuminate\Database\Migrations\Migration;

class CreateGroupsTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('groups', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->string('name');
                $table->string('description');
                $table->integer('outcome');
                $table->string('thumbnail');
                $table->integer('timestart');
                $table->integer('timeend');
                $table->integer('createdby');
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
            Schema::dropIfExists('groups');
	}

}
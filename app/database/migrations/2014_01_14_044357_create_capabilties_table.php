<?php

use Illuminate\Database\Migrations\Migration;

class CreateCapabiltiesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('capabilities', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->string('name');
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
            Schema::dropIfExists('capabilities');
	}

}
<?php

use Illuminate\Database\Migrations\Migration;

class CreateRoleCapabiltiesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('role_capabilities', function($table)
            {
                $table->engine = 'InnoDB';
                
                $table->increments('id');
                $table->integer('role_id')->unsigned();
                $table->integer('capability_id')->unsigned();
                $table->foreign('role_id')
                        ->references('id')->on('roles')
                        ->onDelete('cascade');
                $table->foreign('capability_id')
                        ->references('id')->on('capabilities')
                        ->onDelete('cascade');
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
            Schema::dropIFExists('role_capabilities');
	}

}
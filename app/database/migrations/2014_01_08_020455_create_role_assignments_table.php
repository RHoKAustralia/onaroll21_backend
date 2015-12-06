<?php

use Illuminate\Database\Migrations\Migration;

class CreateRoleAssignmentsTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
            //
            Schema::create('role_assignments', function($table)
            {
                $table->engine = 'InnoDB';
                $table->integer('user_id')->unsigned();
                $table->integer('role_id')->unsigned();
                $table->foreign('user_id')
                        ->references('id')->on('users')
                        ->onDelete('cascade');
                $table->foreign('role_id')
                        ->references('id')->on('roles')
                        ->onDelete('cascade');
                $table->integer('createdby');
                $table->primary(array('user_id','role_id'));
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
            Schema::dropIfExists('role_assignments');
	}

}
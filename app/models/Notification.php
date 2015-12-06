<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class Notification extends Eloquent {

    protected $table='notifications';

	// use these like Notification::TYPE_MESSAGE
	const TYPE_NEWGROUPMESSAGE = 'newgroupmessage';
	const TYPE_MESSAGE = 'message';
	const TYPE_NEWLIKE = 'newlike';
	const TYPE_NEWCOMMENT = 'newcomment';
	const TYPE_NEWCOMMENTOTHER = 'newcommentother';
	const TYPE_NEWGROUPMEMBER = 'newgroupmember';
	const TYPE_MISSIONPENDING = 'missionpending';
	const TYPE_FIRSTCOMPLETE = 'firstcomplete';

}



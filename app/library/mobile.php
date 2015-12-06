<?php
/**
 * Created by PhpStorm.
 * User: Jai
 * Date: 20/08/2015
 * Time: 4:03 PM
 */

namespace mobile;

use Auth;
use DB;

/**
 * adds player id to user unless the playerid is already existence.
 *
 * @param $playerId
 *
 * @return boolien true or false
 */
function writeMobilePNtoDB($playerId)
{
	$user = Auth::user();

	$device = DB::table('devices')->where('player_id', $playerId)->where('user_id', $user['id'])->first();

	if (count($device) == 1)
	{

		DB::table('devices')
			->where('user_id', $user['id'])->where('player_id', $playerId)
			->update(array('active' => 1));
	}

	// check the condition if the playerid is already existence . if not insert a new record, otherwise dont insert

	$ret = false;

	if (count($device) != 1)
	{
		$oneSignal = file_get_contents('https://onesignal.com/api/v1/players/' . $playerId);

		$oneSignal = json_decode($oneSignal);
/*		$oneSignal = json_decode('
			{"device_model":"abc",
			"id":"123456",
			"tags":"abc,def,ghi"}');*/

		// initialize the device array data
		$deviceArray = array(
			'user_id'   => $user['id'],
			'device'    => $oneSignal->device_model,
			'player_id' => $oneSignal->id,
			'raw_data'  => json_encode($oneSignal),
			'tags'      => json_encode($oneSignal->tags)
		);

		// insert the record into the table

		DB::table('devices')->insertGetId(
			$deviceArray
		);

		DB::table('users')
			->where('id', $user['id'])
			->update(array('push_notification' => 1));

		$ret = true;
	}

	return $ret;
}
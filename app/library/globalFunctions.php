<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * TODO: Write description
 * @param type $s
 * @return type
 */
function makeClickableLinks($text) {
    //  return preg_replace('@(https?://([-\w\.]+[-\w])+(:\d+)?(/([\w/_\.#-]*(\?\S+)?[^\.\s])?)?)@', '<a href="$1" target="_blank">$1</a>', $s);
    $reg_exp = "/(http|https|ftp|ftps)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/";

    if(preg_match($reg_exp, $text, $url)) {
        return preg_replace($reg_exp, '<a href="'.$url[0].'" rel="nofollow">'.$url[0].'</a>', $text);

    } else {
        return $text;
    }
}

/**
 * Shortcut for Laravel trans() function
 * @param type $string
 * @return type
 */
function t($string)
{
    return trans($string);
}

function sendEmail(array $data,$type='contactus') {
    if($type=='contactus')
        $to='enquiries@onaroll21.com';
    else
        $to='support@onaroll21.com';
    $data['to'] = $to;
    switch($type) {
        case 'contactus': 
            Mail::send( 'emails.contactus', $data, function($message) use ($data)
            {
                    $message->to( $data['to'] )->from( $data['email'],$data['name'] )->subject($data['subject']);
            });
            break;
        case 'report': 
            Mail::send( 'emails.report', $data, function($message) use ($data)
            {
                    $message->to( $data['to'] )->from( $data['email'],$data['name'] )->subject($data['subject']);
            });
            break;
    }
}

/**
 * 
 * @param type $words
 * @param type $stopwords
 * @return type
 */
function filter_stopwords($words, $stopwords) {
    foreach ($words as $pos => $word) {
            if (!in_array(strtolower($word), $stopwords, TRUE)) {
                    $filtered_words[$pos] = $word;
            }
    }

    return $filtered_words;
}


/**
 * 
 * @param type $words
 * @return int
 */
function word_freq($words) {
    $frequency_list = array();
    foreach ($words as $pos => $word) {

            $word = strtolower($word);
            if (array_key_exists($word, $frequency_list)) {
                    ++$frequency_list[$word];
            }
            else {
                    $frequency_list[$word] = 1;
            }
    }

    return $frequency_list;
}

/**
 *
 * This function takes two date times, strips off the time
 * and returns the days difference
 *
 * @param $from first date
 * @param $to second date
 *
 * @return integer with the number of days based only on the date
 */
function daysDiff($from, $to) {
	$first_date = new DateTime($from->format('Y-m-d'));
	$second_date = new DateTime($to->format('Y-m-d'));
	$offset = $second_date->diff($first_date);
	return $offset->days;
}




/**
 *
 * This function will get and return the full hostname of the web-app
 * 
 * @param none
 *
 * @return  string with the full hostname and protocol
 */

function siteURL()
{
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
    $domainName = $_SERVER['HTTP_HOST'].'/';
    return $protocol.$domainName;
}

// define full site url
define( 'SITE_URL', siteURL() );

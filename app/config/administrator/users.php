<?php
/**
 * The edit fields array
 *
 * @type array
 */
return array(
        /**
     * Model title
     *
     * @type string
     */
    'title' => 'Users',
    
    /**
 * The singular name of your model
 *
 * @type string
 */
'single' => 'group',
    
    /**
 * The class name of the Eloquent model that this config represents
 *
 * @type string
 */
'model' => 'Group',
    
    'columns' => array(
        'name' => array(
            'title' => 'name',
            'type'=>'text',
        ),
    ),
    'edit_fields' => array(
        'name' => array (
            'title' => 'name',
            'type' => 'text'
        )
    )
);
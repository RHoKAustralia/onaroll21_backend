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
    'title' => 'Teams',
    
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
        'description' => array(
            'title'=>'description',
            'type'=>'textarea'
        ),
        'users' => array(
            'title' => 'users',
            'type'=>'int'
        )
        
    ),
    'edit_fields' => array(
        'name' => array (
            'title' => 'name',
            'type' => 'text'
        ),
        'description'=>array(
            'title'=>'description',
            'type'=>'markdown'
        )
    )
);
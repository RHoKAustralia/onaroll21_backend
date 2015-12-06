 <!DOCTYPE html>
  <html>
    <head>
      <!--Import Google Icon Font-->
      <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.3/css/materialize.min.css">
        
       
        <link href="{{Request::root()}}/css/material_admin.css" rel="stylesheet" type="text/css"/>
        
        

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
        
        <div class="main">
        
        <div class="content-container">
        <!-- BEGIN TEMPLATE CONTENT -->
            
        <!-- BEGIN NAV -->
        
            <nav>
                <ul id="slide-out" class="side-nav">
                    <li><a href="/admin/site">Site Settings</a></li>
                    
                    <li class="no-padding">
                      <ul class="collapsible collapsible-accordion">
                        <li>
                          <a class="collapsible-header">User<i class="mdi-navigation-arrow-drop-down"></i></a>
                          <div class="collapsible-body">
                            <ul>
                              <li><a href="/users/manage">Manage users</a></li>
                              <li><a href="/user/add">Add a user</a></li>
                            </ul>
                          </div>
                        </li>
                      </ul>
                    </li>
                    <li class="no-padding">
                      <ul class="collapsible collapsible-accordion">
                        <li>
                          <a class="collapsible-header">Team<i class="mdi-navigation-arrow-drop-down"></i></a>
                          <div class="collapsible-body">
                            <ul>
                              <li><a href="/groups/manage">Manage teams</a></li>
                              <li><a href="/group/add">Create a team</a></li>
                            </ul>
                          </div>
                        </li>
                      </ul>
                    </li>
                    <li class="no-padding">
                      <ul class="collapsible collapsible-accordion">
                        <li>
                          <a class="collapsible-header">Mission<i class="mdi-navigation-arrow-drop-down"></i></a>
                          <div class="collapsible-body">
                            <ul>
                              <li><a href="/task/add">Manage missions</a></li>
                              <li><a href="/tasks/manage">Add new mission</a></li>
                            </ul>
                          </div>
                        </li>
                      </ul>
                    </li>
                    <li class="no-padding">
                      <ul class="collapsible collapsible-accordion">
                        <li>
                          <a class="collapsible-header">Mission Collection<i class="mdi-navigation-arrow-drop-down"></i></a>
                          <div class="collapsible-body">
                            <ul>
                              <li><a href="/outcome/add">Manage </a></li>
                              <li><a href="/outcomes">Add a new mission collection</a></li>
                            </ul>
                          </div>
                        </li>
                      </ul>
                    </li>
                    <li class="no-padding">
                      <ul class="collapsible collapsible-accordion">
                        <li>
                          <a class="collapsible-header">Roles<i class="mdi-navigation-arrow-drop-down"></i></a>
                          <div class="collapsible-body">
                            <ul>
                              <li><a href="/roles">Assign Roles </a></li>
                            </ul>
                          </div>
                        </li>
                      </ul>
                    </li>
                     <li class="no-padding">
                      <ul class="collapsible collapsible-accordion">
                        <li>
                          <a class="collapsible-header">Survey<i class="mdi-navigation-arrow-drop-down"></i></a>
                          <div class="collapsible-body">
                            <ul>
                              <li><a href="/surveys">Manage Survey </a></li>
                              <li><a href="/survey/add">Add Survey </a></li>
                            </ul>
                          </div>
                        </li>
                      </ul>
                    </li>
                    <li><a href="/logout">Log out</a></li>
                  </ul>
                  <ul class="right hide-on-med-and-down">
                    <li><a href="/admin/site">Site Settings</a></li>
                    
                    <li><a class="dropdown-button" href="#!" data-activates="dropdown1">User<i class="mdi-navigation-arrow-drop-down right"></i></a></li>
                    <ul id='dropdown1' class='dropdown-content'>
                      <li><a href="/users/manage">Manage User</a></li>
                      <li><a href="/user/add">Add user</a></li>
                      
                    </ul>
                    
                    <li><a class="dropdown-button" href="#!" data-activates="dropdown2">Team<i class="mdi-navigation-arrow-drop-down right"></i></a></li>
                    <ul id='dropdown2' class='dropdown-content'>
                      <li><a href="/groups/manage">Manage Team</a></li>
                      <li><a href="/group/add">Create team</a></li>
                      
                    </ul>
                    
                    <li><a class="dropdown-button" href="#!" data-activates="dropdown3">Mission<i class="mdi-navigation-arrow-drop-down right"></i></a></li>
                    <ul id='dropdown3' class='dropdown-content'>
                      <li><a href="/tasks/manage">Manage Mission</a></li>
                      <li><a href="/task/add">Create Mission</a></li>
                      
                    </ul>
                    
                    <li><a class="dropdown-button" href="#!" data-activates="dropdown4">Mission Collection<i class="mdi-navigation-arrow-drop-down right"></i></a></li>
                    <ul id='dropdown4' class='dropdown-content'>
                      <li><a href="/outcomes">Manage </a></li>
                      <li><a href="/outcome/add">Create Mission Collection</a></li>
                      
                    </ul>
                    
                     <li><a href="/roles">Assign Roles</a></li>
                     
                     <li><a class="dropdown-button" href="#!" data-activates="dropdown5">Survey<i class="mdi-navigation-arrow-drop-down right"></i></a></li>
                    <ul id='dropdown5' class='dropdown-content'>
                      <li><a href="/surveys">Manage Survey </a></li>
                      <li><a href="/survey/add">Create Survey</a></li>
                      
                    </ul>
                     
                     <li><a href="/logout">Log Out</a></li>
                  </ul>
                  <a href="#" data-activates="slide-out" class="button-collapse"><i class="mdi-navigation-menu"></i></a>
              </nav>
            
              <!-- END NAV -->
              
              <!-- BEGIN CONTENT HOLDER -->
              
              
              <div class="container">
                  
                  <div class="card-panel content-wrapper">
                      
                      
                      @yield('content')
                  
                  </div>
                  
              </div>
              
              
              
              <!-- END CONTENT HOLDER -->

        
        
        
        <!-- END TEMPLATE CONTENT -->
        
        </div>
            
        </div>
        
        
      <!--Import jQuery before materialize.js-->
      <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
       <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.3/js/materialize.min.js"></script>
        
        <script src="{{Request::root()}}/scripts/material_admin.js" type="text/javascript"></script>
        
        
        
        
     
        
        
        <script src="//cdnjs.cloudflare.com/ajax/libs/ckeditor/4.2/ckeditor.js"></script>
      
    </body>
  </html>
        
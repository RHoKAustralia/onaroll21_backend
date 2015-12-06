<html>
    <head>
        <script type="text/javascript">
            function load() {
                console.log('Function works');
                if(window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                } else {
                    xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
                }
                
                xmlhttp.onreadystatechange = function() {
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        document.getElementById('content').innerHTML = xmlhttp.responseText;
                    }
                    
                }
                
                xmlhttp.open('GET','index.inc.php',true);
                xmlhttp.send();
            }
            
            function findmatch() {
                console.log('Finding now');
                var val = this.value;
                if(window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                } else {
                    xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
                }
                
                xmlhttp.onreadystatechange = function() {
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        document.getElementById('results').innerHTML = xmlhttp.responseText;
                    }
                }
                
                xmlhttp.open('GET','search.inc.php?search_text='+document.search.search_text.value,true);
                xmlhttp.send();
            }
            
        </script>
    </head>
    <body>
        
        <div id="content">
            This is ajax page
        </div>
        <form id="search" name="search">
            Type a name: <br />
            <input type="text" id="search_text" name="keyword" onkeyup="findmatch()" />
        </form>
        <div id="results">
            
        </div>
        <input type="submit" onclick="javascript:load();" value="Load">
    </body>
</html>
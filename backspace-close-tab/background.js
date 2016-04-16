//Written by David Cashin

chrome.storage.sync.get({allKeys: false}, function(settings) {
        //record the first tap of a potential double tap as well as the time between those taps
        var alreadyPressed = false;
        var initialTime = 0;
        document.addEventListener('keydown', function () {
            var elementType = document.activeElement.type;

            //make sure we aren't typing something in a textbox or text area    
            if (window.event.keyCode == 8 && elementType != "text" && elementType != "textarea" && !hasTextRole(document.activeElement)) {  
                //backspace key detected
                var currentTime = new Date().getTime();
                var timeSinceFirstPress = currentTime - initialTime;
                if(alreadyPressed && timeSinceFirstPress < 350){
                    //double-tap of duration lt 350ms detected
                    window.close();            
                    alreadyPressed = false;
                }else{
                    //prime for next tap being a potential double tap
                    alreadyPressed = true;
                    initialTime = new Date().getTime();
                }
            }
        });

        //searches nonconventional dom structure for a role with 'textbox' value (ie, facebook)
        function hasTextRole(domNode){
            var hasRole = false;

            if(domNode.getAttribute("role") == "textbox"){
                hasRole = true;
            }

            return hasRole;
        }

    });


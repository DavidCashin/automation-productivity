//Written by David Cashin

chrome.storage.sync.get({allKeys: false}, function(settings) {
        //record the first tap of a potential double tap as well as the time between those taps
        var alreadyPressed = false;
        var initialTime = 0;
        document.addEventListener('keydown', function () {            
            if (window.event.keyCode == 8) {
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
});


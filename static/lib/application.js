(function () {
    var dependancies = ['uimaker', 'realtime', 'music'];
    
    function define_application (uimaker, realtime, music) {
        var $content = jQuery('#content');
    
        jQuery('.tabbed').each(uimaker('tabs'));
        jQuery('.accordion').each(uimaker('accordion'));
 
        $content.hide().delay(250).fadeIn(1500);
    }

    define('application', dependancies, define_application);
})();

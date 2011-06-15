(function () {
    var dependancies = ['uimaker', 'realtime'];
    
    function define_application (uimaker, realtime) {
        var $content = jQuery('#content');
    
        jQuery('.tabbed').each(uimaker('tabs'));
        jQuery('.accordion').each(uimaker('accordion'));
 
        $content.hide().delay(750).fadeIn(3000);
    }

    define('application', dependancies, define_application);
})();

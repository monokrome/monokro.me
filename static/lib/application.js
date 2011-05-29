define('application', ['uimaker'], function define_application (uimaker) {
    var $content = jQuery('#content');

    jQuery('.tabbed').each(uimaker('tabs'));
    jQuery('.accordion').each(uimaker('accordion'));

    $content.hide().delay(750).fadeIn(3000);
});

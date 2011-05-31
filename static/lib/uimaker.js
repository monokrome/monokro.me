define('uimaker', [], function define_uimaker () {
    var ui_options = {
        accordion: {
            'disabled': true,
            'active': true,
            'clearStyle': true,
            'collapsible': true,
            'fillSpace': true,
            'navigation': true,

            'no-default': function make_collapsed ()
            {
                this.active = -1;
            },
            'no-auto-height': function no_auto_height ()
            {
                this.autoHeight = false;
            }
        },
        
        tabs: {
        }
    };

    function make_ui (type)
    {
        var ui_provider = (function ui_provider () {
            var options = {},
                potential_options = ui_options[type],
                option, option_name;

            for (option in potential_options)
            {
                if (jQuery(this).hasClass(option)) {
                    if (typeof potential_options[option] == 'function')
                    {
                        potential_options[option].apply(options,[this]);
                    }
                    else
                    {
                        options[option] = potential_options[option];
                    }
                }
            }

            $(this)[type](options);
        });

        return ui_provider;
    }

    return make_ui;
});

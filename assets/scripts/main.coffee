window.scrollTo(0, 1)

avatar_size_large = 288
avatar_size_small = 144

avatar_defaults =
  '#code':
    'background-position-x': -80
    'background-position-y': -165

  '#music':
    'background-position-x': -190
    'background-position-y': -120

  '#blog':
    'background-position-x': -260
    'background-position-y': -140

module_targets =
  '#code': 'http://github.com/monokrome'
  '#music': ->
  '#blog': 'http://twitter.com/#!/monokrome'

create_link = (selector) ->
  (jQuery selector).click ->
    target = module_targets[selector]

    if typeof target != 'function'
      document.location.href = target
    else
      target(jQuery selector)

create_animation = (selector) ->
  $avatar = jQuery (selector + ' .avatar')

  (jQuery selector).hover ->
    $avatar.css 'position', 'relative'

    animate_to =
      height: avatar_size_large
      width: avatar_size_large
      left: (((avatar_size_large - avatar_size_small) / 2) * -1)
      top: (((avatar_size_large - avatar_size_small) / 2) * -1)
      backgroundPosition: (avatar_defaults[selector]['background-position-x'] + ((avatar_size_large - avatar_size_small) / 2)) + 'px ' +
                            (avatar_defaults[selector]['background-position-y'] + ((avatar_size_large - avatar_size_small) / 2)) + 'px'

    $avatar.stop().animate animate_to

  , ->
    animate_to =
      height: avatar_size_small
      width: avatar_size_small
      position: 'relative'
      left: 0
      top: 0
      backgroundPosition: avatar_defaults[selector]['background-position-x'] + 'px ' +
                          avatar_defaults[selector]['background-position-y'] + 'px'

    $avatar.stop().animate animate_to

initialize_application = ->
  for selector of module_targets
    create_link selector
    create_animation selector

jQuery initialize_application


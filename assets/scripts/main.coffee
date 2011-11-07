avatar_size_large = 288
avatar_size_small = 144

avatar_defaults =
  '#code':
    background:
      x: -80
      y: -165

  '#music':
    background:
      x: -170
      y: -120

  '#blog':
    background:
      x: -270
      y: -140

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
    $avatar.height avatar_size_large
    $avatar.width avatar_size_large

    $avatar.css 'position', 'relative'
    $avatar.css 'left', (((avatar_size_large - avatar_size_small) / 2) * -1)
    $avatar.css 'top', (((avatar_size_large - avatar_size_small) / 2) * -1)

    $avatar.css 'background-position-x', avatar_defaults[selector].background.x + ((avatar_size_large - avatar_size_small) / 2)
    $avatar.css 'background-position-y', avatar_defaults[selector].background.y + ((avatar_size_large - avatar_size_small) / 2)

  , ->
    $avatar.height avatar_size_small
    $avatar.width avatar_size_small

    $avatar.css 'position', 'relative'
    $avatar.css 'left', 0
    $avatar.css 'top', 0

    $avatar.css 'background-position-x', avatar_defaults[selector].background.x
    $avatar.css 'background-position-y', avatar_defaults[selector].background.y

initialize_application = ->
  for selector of module_targets
    create_link selector
    create_animation selector

jQuery initialize_application


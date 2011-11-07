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

initialize_application = ->
  for selector of module_targets
    create_link selector

jQuery initialize_application


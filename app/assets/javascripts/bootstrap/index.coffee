#= require ./bootstrap.min
#= require ./tab
$('.tabbed-nav a').click (e)->
  e.preventDefault()
  $(this).tab('show')

ready = ->
  $('.show_all_comments').on('click', showComments)

  $('#new_volunteer_id').select2()
  $(document).on('change', '#new_volunteer_id', assignVolunteer)

showComments = ->
  elem = $('.task-comments')
  return if elem.hasClass('loading')
  elem.addClass 'loading'
  $.ajax(
    url: elem.data('url')
    success: (result) =>
      elem.removeClass 'loading'
      elem.html(result)
    error: (error, response) =>
      elem.removeClass('loading')
  )

assignVolunteer = ->
  form = $(this).closest('form')
  $.ajax({
    url:  form.attr('action'),
    method: form.attr('method'),
    data: form.serialize(),
    success: (result) => 
      widget = $(this).closest('.volunteers');
      widget.html(result)
      # need to reinitialize because it's a new DOM node
      $('#new_volunteer_id').select2()
  })


$(document).on 'ready', ready
$(document).on 'page:load', ready

$(document).on('ready page:load', function () {
  $('.comment-reply').on('click', function () {
    $(this).closest('.comment').find('.reply-form').toggle()
    return false;
  });
});
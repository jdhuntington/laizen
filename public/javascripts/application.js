;(function($) {
  $(document).ready(function() {
    $('#new_comment').ajaxForm({
      target: '#comments',
      resetForm: true,
      targetAction: 'append'
    });
  });

})(jQuery);

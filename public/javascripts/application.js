;(function($) {

  $(document).ready(function() {
    $('#new_comment').ajaxForm({
      target: '#comments',
      resetForm: true,
      targetAction: 'append'
    });


    var buildForm = function(action, filename, lineNumTuple, authenticityToken) {
      var form = $('<form action=\"' + action + '\" method=\"post\">');
      form.append($('<textarea name=\"comment[content]\" />'));
      form.append($('<input type=\"submit\" value=\"Add Comment\" />'));
      form.append($('<input type=\"hidden\" value=\"' + filename + '\" name=\"comment[path]\" />'));
      form.append($('<input type=\"hidden\" value=\"' + lineNumTuple + '\" name=\"comment[line]\" />'));
      form.append($('<input type=\"hidden\" value=\"' + authenticityToken + '\" name=\"authenticity_token\" />'));
      return form;
    };

    var prepCommentHoldingArea = function(diffDisplay) {
      var td = $(diffDisplay).closest('td');
      if(td.find('div.diff-comments').length == 0) td.append($('<div class=\"diff-comments\" />'));
      return td.find('div.diff-comments');
    };


    $('div.diff-content').click(function() {
      var diffCommentsArea = prepCommentHoldingArea(this);

      var fileName = $(this).closest('table').find('tr.filename td').html();
      var lineNumTuple = $(this).closest('tr').attr('data-line-num-tuple');
      var form = buildForm(commitCommentUri, fileName, lineNumTuple, authenticityToken);

      var container = $('<div class=\"new-diff-comment\"  />');
      container.append(form);

      diffCommentsArea.append(container);

      $(form).ajaxForm({
        target: diffCommentsArea,
        targetAction: 'append',
        success: function() {
          $(container).remove();
        }
      });
    });


  });
})(jQuery);

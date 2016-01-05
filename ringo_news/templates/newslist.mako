<%
import datetime
from ringo.lib.helpers import prettify
from ringo_news.model import News
%>
% if news:
  <h2>${_(h.get_item_modul(request, News).get_label(plural=True))}</h2>
<table id="newslisting" class="table table-condensed table-striped table-hover">
  <thead>
    <tr>
      <th>${_(h.get_item_modul(request, News).get_label())}</th>
      <th width="10"><span class="glyphicon glyphicon-check"></span></th>
    </tr>
  </thead>
  <tbody>
    % for newsitem in news:
    <tr id="newsentry_${newsitem.id}">
      <td>
        <strong>${prettify(request, newsitem.date)} ${prettify(request, newsitem.subject)}</strong>
        <p>${newsitem.text.replace('\n', '<br>') | n}
        </p>
      </td>
      <td>
        % if s.has_permission("read", newsitem, request):
          <a href="#" class="linkmarkasread" title="${_('Mark this item as read')}"><span class="glyphicon glyphicon-check"></span></a></td>
        % endif
    </tr>
    % endfor
  </tbody>
</table>

<script>
var application_path = getApplicationPath();
var language = getDTLanguage(getLanguageFromBrowser());
var newslist = $('#newslisting').dataTable( {
       "oLanguage": {
         "sUrl":  application_path + "/ringo-static/js/datatables/i18n/"+language+".json"
       },
       "bPaginate": false,
       "bLengthChange": false,
       "bFilter": false,
       "bSort": false,
       /* Disable initial sort */
       "aaSorting": [],
       "bInfo": false,
       "bAutoWidth": true
 });

$('.linkmarkallasread').click( function () {
  $("#newslisting tbody tr").each(function(index) {
    var row = $(this);
    var id = $(row).attr("id").split("_")[1];
    markNewsAsRead(row, id);
  });
});

$('.linkmarkasread').click( function () {
  var row = $(this).closest("tr").get(0);
  var id = $(row).attr("id").split("_")[1];
  markNewsAsRead(row, id);
});

function markNewsAsRead(row, id) {
  $.ajax({
    headers : {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json'
    },
    url : '${request.application_url}/rest/news/'+id+'/markasread',
    type : 'PUT',
    success : function(response, textStatus, jqXhr) {
      /* TODO: Try to animate the deletion of the column. Tried to
      call the final deletion as a callback which does not work. (ti)
      <2014-01-30 12:35> */
      $('#newsentry_'+id).hide(1000);
      console.log("News successfully marked as read!");
    },
    error : function(jqXHR, textStatus, errorThrown) {
      // log the error to the console
      console.log("The following error occured: " + textStatus, errorThrown);
    },
    complete : function() {
      newslist.fnDeleteRow(row);
    }
  });
};
</script>
%endif

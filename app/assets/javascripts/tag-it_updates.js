$(document).ready(function() {
  var tagsUpdate = function(event, ui) {
    // do something special
    //console.log($("#myTags").tagit("assignedTags"));
    if (ui.duringInitialization) {return}
    var preexistingtags = [1,2,3]
    var tags_array = $("#myTags").tagit("assignedTags");
    var data = {tags: tags_array};
    //console.log(data);
    $.ajax({
        url: '/bills/' + billuid + '/update',
        type: 'PUT',
        data: data,
        success: function(result) {
          console.log(result);
            // Do something with the result
        }
    });
  }

  var config = {
    allowSpaces: true,
    afterTagAdded: tagsUpdate,
    afterTagRemoved: tagsUpdate
  }
  if($("#myTags").length)
    $("#myTags").tagit(config);
});
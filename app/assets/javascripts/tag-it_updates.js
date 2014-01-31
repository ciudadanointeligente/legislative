$(document).ready(function() {
  var tagsUpdate = function(event, ui) {
    // do something special
    if (ui.duringInitialization) {return}
    var tags_array = $("#myTags").tagit("assignedTags");
    var data = {tags: tags_array};
    $.ajax({
        url: '/bills/' + billuid + '/update',
        type: 'PUT',
        data: data,
        success: function(result) {
          // do something with the result
          // console.log(result);
        }
    });
  }

  // Options
  // for more customization check: https://github.com/aehlke/tag-it
  var config = {
    availableTags: ["deporte", "desarrollo", "educación", "pobreza", "salud", "seguridad"],
    autocomplete: {delay: 0, minLength: 2},
    allowSpaces: true,
    afterTagAdded: tagsUpdate,
    afterTagRemoved: tagsUpdate
  }
  if($("#myTags").length)
    $("#myTags").tagit(config);
});
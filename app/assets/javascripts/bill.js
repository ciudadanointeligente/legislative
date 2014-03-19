// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  var tagsUpdate = function(event, ui) {
    // do something special
    if (ui.duringInitialization) {return}
    var tags_array = $("#myTags").tagit("assignedTags");
    var data = {tags: tags_array};
    $.ajax({
        url: '/'+path_bill+'/'+billuid,
        type: 'PUT',
        data: data
    })
    .done(function(msg){
      console.log('done: '+msg)
    })
    .fail(function(msg){
      console.log('fail: '+msg)
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
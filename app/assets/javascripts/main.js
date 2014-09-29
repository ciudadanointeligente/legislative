// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  if( $('#bills-related').length )
  {
    $('#bills-related li').each(function(index){
        var li = $( this );
        var bill_id = $( this ).data('id');
        var reg = /\d{1,4}\-\d{2}/
        
        if ( reg.test(bill_id) ) {

          var jqxhr = $.getJSON( "//billit.ciudadanointeligente.org/bills/"+bill_id+".json", function(){}) 
            .done(function(data) {
              var url_link = '<a href="//congresoabierto.cl/proyectos/'+data.uid+'" target="_blank">'+data.title+'</a>';
              $(li).html(url_link);
            })
            .fail(function( jqxhr, textStatus, error ) {
              var err = textStatus + ', ' + error;
              console.log( "Request Failed: " + err);
            });
        }

    })
  }
})
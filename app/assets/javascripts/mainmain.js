$(document).ready(function(){
  // set up hover panels
  // although this can be done without JavaScript, we've attached these events
  // because it causes the hover to be triggered when the element is tapped on a touch device
  $('.hover').hover(function(){
    $(this).addClass('flip');
  },function(){
    $(this).removeClass('flip');
  });

  $('.tags-tooltip').tooltip({
    selector: "[data-toggle=tooltip]",
    container: "tags-tooltip"
  });

  //update value in range select
  var val = $('#range').val(), output  = $('#value-range');  

  output.html(val);  

  $('#range').change(function(){  
    output.html(this.value);  
  });

});

function generateGraph(freq,chartId) {
  var data = {
    labels : [
      "", "", "", "", "",
      "", "", "", "", "",
      "", ""
      ],
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        data : freq
      }
      ]
  }

  var options = {
    scaleShowLabels : false,
    barStrokeWidth : 0,
    scaleShowGridLines : false,
    animation : false,
      scaleGridLineColor : "rgba(0,0,0,0)",
      pointDot : false
  }

  if(document.getElementById(chartId)) {
    var ctx = document.getElementById(chartId).getContext("2d");
    var myNewChart = new Chart(ctx).Line(data, options);
  }
}
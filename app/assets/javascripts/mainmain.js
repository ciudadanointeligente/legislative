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

  $('.green-votes-bar').mouseover(function(e){
    $('span.positive').removeAttr('style','');
    $('span.against').attr('style','background-color:#FFF; opacity:0.8;');
    $('span.abstention').attr('style','background-color:#FFF; opacity:0.8;');
  }).mouseout(function(){
    $('span.against').removeAttr('style','');
    $('span.abstention').removeAttr('style','');
  });

  $('.red-votes-bar').mouseover(function(e){
    $('span.against').removeAttr('style','');
    $('span.positive').attr('style','background-color:#FFF; opacity:0.8;');
    $('span.abstention').attr('style','background-color:#FFF; opacity:0.8;');
  }).mouseout(function(){
    $('span.positive').removeAttr('style','');
    $('span.abstention').removeAttr('style','');
  });

  $('.blue-votes-bar').mouseover(function(e){
    $('span.abstention').removeAttr('style','');
    $('span.against').attr('style','background-color:#FFF; opacity:0.8;');
    $('span.positive').attr('style','background-color:#FFF; opacity:0.8;');
  }).mouseout(function(){
    $('span.positive').removeAttr('style','');
    $('span.against').removeAttr('style','');
  });

});

function generateGraph(freq) {
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

  if(document.getElementById("myChartInt")) {
    var ctx = document.getElementById("myChartInt").getContext("2d");
    var myNewChart = new Chart(ctx).Bar(data, options);
  }
}
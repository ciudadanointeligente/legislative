window.onload = function()
{    
  var x = 1,
      highest = Math.max.apply(Math, freq),
      medium = Math.ceil( highest/2 ),
      nro_elements = freq.length,
      d = '';
  
  freq.forEach(function(event) {
    var posX = x;
        height = 200;
        posX = 58*posX+32;
        posX2 = 58*(x+1)+32;
        posY = height-(event*20),
        posY2 = height-(freq[x]*20),
        d = '';

    createPoints(posX, posY, highest, event);
    
    if(posY2)
    {
      d = 'M'+posX+','+posY+' L'+posX2+','+posY2;
    
      var shape = document.createElementNS("http://www.w3.org/2000/svg", "path");
      shape.setAttributeNS(null, "d", d);
      shape.setAttributeNS(null, "class", "first_set");

      document.getElementById('surfaces').appendChild(shape);
      
      x +=1;
    }

  });

  function createPoints(posX, posY, highest, event) {

    var shape = document.createElementNS("http://www.w3.org/2000/svg", "circle"),
        shape1 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
        
    shape.cx.baseVal.value = posX;
    shape.cy.baseVal.value = posY;
    shape.r.baseVal.value = 3;
    shape.setAttributeNS(null, "class", "shadow");
    shape.setAttributeNS(null, "stroke", "#AAA");
    shape.setAttributeNS(null, "stroke-width", "4");
    shape.setAttributeNS(null, "stroke-opacity", "1");
    shape.setAttributeNS(null, "style", "fill: url(#gradientShadow);");
    
    document.getElementById('points').appendChild(shape);

    shape1.cx.baseVal.value = posX;
    shape1.cy.baseVal.value = posY;
    shape1.setAttributeNS(null, "class", "plain");
    shape1.setAttributeNS(null, "data-value", event);
    shape1.r.baseVal.value = 3;
    
    document.getElementById('points').appendChild(shape1);

  }

  function isBigEnough(element, index, array) {
    return (element > 0);
  }

  display_graph = freq.some(isBigEnough);
  
  if( !display_graph ) {
    var d = document.getElementById("timeline"); 
        d.innerHTML = 'No se han registrado movimientos en el último año';
  }

  $(".showmebutton").click(function(e) {
    e.preventDefault();
    $( ".showmecontent" ).toggle();
  });

  //svg animation
  $('svg.graph .points circle.plain').each( function(index) {
    // For each plain circle...
    $(this).on('mouseenter', function(event) {
      showTooltip(this);
      // Grow shadow point when mouse enters the point
      $(this).prev().stop(true, false ).animate( {
        svgR: 12,
        svgStrokeOpacity: 0,
        svgStrokeWidth: 0,
      }, 200 );
    }).on('mouseleave', function(event) {
      hideTooltip();
      // Shrink shadow point when mouse leaves the point
      $(this).prev().stop(true, false ).animate( {
        svgR: 5,
        svgStrokeOpacity: 1,
        svgStrokeWidth: 4
      }, 200 );
    });
  });
}

function showTooltip( dataPoint )
{
  tooltip = $('#tooltip');
  dataPoint = $(dataPoint);

  // Set the data-set title, using the group element
  tooltip.find('#tooltip-title').text( dataPoint.parent().data('setname') );

  // Set the value for this data point
  tooltip.find('.value-part').text( dataPoint.data('value') );

  // Determine whether to switch tooltip to the left, because of small screen
  tooltipX = dataPoint.offset().left + 10;
  tooltipY = dataPoint.offset().top + 40;

  // Check if tooltip fits, with a extra border of 10 px
  if( tooltipX + tooltip.outerWidth(true) + 10 > $(window).width() )
  {
    tooltipX = dataPoint.offset().left - tooltip.outerWidth(true);

    tooltip.addClass('right');

    // Adjust SVG pointer
    $('#tooltip-triangle').attr('transform', 'scale(-1,1) translate(-11,0)' );
  }
  else
  {
    tooltip.removeClass('right');
    $('#tooltip-triangle').attr('transform', '' );
  }

  tooltip.stop( true, true ).delay(100).animate( {
    top: tooltipY,
    left: tooltipX
  }, 0 ).fadeIn('fast');
}

function hideTooltip()
{
  // Hide popover and stop animating the bar
  $('#tooltip').stop(true, true).delay(200).fadeOut('fast' );
}
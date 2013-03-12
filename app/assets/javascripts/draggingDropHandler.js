DraggingDropHandler = function(soccerField) {
  this.soccerField = soccerField;
  this.correctPlayers = 0;
}

DraggingDropHandler.prototype.init = function() {
  this.initSlots();
  this.disable($('#send_button'));
}

DraggingDropHandler.prototype.initSlots = function() {
  $('#slot').html('');
  var handler = this;
  var size = this.soccerField.slotSize();
  for(var i=0; i < size; i++) {
    var item = '<div id=' + i + '></div>';
    $(item).data('number', i).appendTo('#slot').droppable({
      accept: '.team',
      hoverClass: 'hovered',
      drop: handler.onDrop
    });
  }
  $('<div id="gk"><p></p></div>').appendTo("#soccerField").droppable({
    accept: '.goal_keeper',
    hoverClass: 'hovered',
    drop: handler.onDrop
  });
}

DraggingDropHandler.prototype.disable = function(button) {
  button.attr('disabled', 'disabled');
	button.addClass("disabled");
}

DraggingDropHandler.prototype.handle = function(player) {
  if (player.enabled) {
    var handler = this;
    $('#' + player.id).draggable({
      containment: '#soccerField',
      stack: 'move',
      appendTo: 'body',
      helper: 'clone',
      revert: true,
      drag: handler.onDrag
    });
    $('#' + player.id).mousedown(function() {
      $('#slot').css('display', 'block');
      $('#positionMap').css('display', 'block');
    });
    $('#' + player.id).mouseup(function() {
      $('#slot').css('display', 'none');
      $('#positionMap').css('display', 'none');
    });
  }
}

DraggingDropHandler.prototype.onDrop = function(event, ui) {
  this.correctPlayers++;
  var target = '';//this.getCurrentTarget();
	ui.draggable.appendTo('#soccerField');
	ui.draggable.addClass('correct');
	ui.draggable.css('position', 'absolute');
  ui.draggable.position( { of: target, my: 'left top', at: 'left top' } );
  ui.draggable.draggable('option', 'revert', false);
}

DraggingDropHandler.prototype.getCurrentTarget = function() {
  return $(this);
}

DraggingDropHandler.prototype.onDrag = function(event, ui) {
}

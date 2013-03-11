DraggingDropHandler = function(soccerField) {
  this.soccerField = soccerField;
}

DraggingDropHandler.prototype.init = function() {
  this.initSlots();
  this.disable($('#send_button'));
}

DraggingDropHandler.prototype.initSlots = function() {
  $('#slot').html('');
  var size = this.soccerField.slotSize();
  for(var i=0; i < size; i++) {
    var item = '<div id=' + i + '></div>';
    $(item).data('number', i).appendTo('#slot').droppable({});
  }
}

DraggingDropHandler.prototype.disable = function(button) {
  button.attr('disabled', 'disabled');
	button.addClass("disabled");
}

DraggingDropHandler.prototype.handle = function(player) {
  if (player.enabled) {
    $('#' + player.id).draggable({});
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



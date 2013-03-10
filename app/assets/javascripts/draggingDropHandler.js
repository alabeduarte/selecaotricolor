DraggingDropHandler = function(soccerField) {
  this.soccerField = soccerField;
}

DraggingDropHandler.prototype.init = function() {
  this.initSlots();
  this.disable($('#send_button'));
}

DraggingDropHandler.prototype.initSlots = function() {
  $('#slot').html('');
  for(var i=0; i < this.soccerField.slotSize(); i++) {
    var item = '<div id=' + i + '></div>';
    $(item).data('number', i).appendTo('#slot').droppable({});
  }
}

DraggingDropHandler.prototype.disable = function(button) {
  button.attr('disabled', 'disabled');
	button.addClass("disabled");
}

DraggingDropHandler.prototype.handle = function(player) {

}



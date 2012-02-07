var correctPlayers = 0;
var matrix;
var matrixModel;
var goalKeeper;
function init_soccer_field() {
  
  // Reset the game
  correctPlayers = 0;
  $('#player').html('');
  $('#slot').html('');

  // Create the soccer players
  var players = createPlayers();

  // Create the positions
  var slots = createSlots();

  // Matrix
  createMatrix(slots);

  // Matrix Model
  createMatrixModel(slots);
}

function load_soccer_field() {
  
  // Reset the game
  $('#emptySlot').html('');

  // Create the positions
  var slots = createEmptySlots();

  // Matrix
  createMatrix(slots);

  // Matrix Model
  createMatrixModel(slots);
}

function createMatrix(slots) {
  // Matrix
  matrix = new Array(7);
  for(var i = 0; i < matrix.length; i++) {
    matrix[i] = new Array(5);  
  }

  for(var i = 0; i < (slots.length-1); i++) {
    for(var x = 0; x < matrix.length; x++) {
      for(var y = 0; y < matrix[x].length; y++) {
        matrix[x][y] = slots[i];
        i++;
      }
    }
  }
}

function createMatrixModel(slots) {
  // Matrix
  matrixModel = new Array(7);
  for(var i = 0; i < matrixModel.length; i++) {
    matrixModel[i] = new Array(5);  
  }

  for(var i = 0; i < (slots.length-1); i++) {
    for(var x = 0; x < matrixModel.length; x++) {
      for(var y = 0; y < matrixModel[x].length; y++) {
        matrixModel[x][y] = '';
        i++;
      }
    }
  }
}

function print() {
  var output = '';
  for(var x = 0; x < matrixModel.length; x++) {
    for(var y = 0; y < matrixModel[x].length; y++) {
      output += '[' + x + ', ' + y + '] = ' + matrixModel[x][y] + ' <br/>';
    }
  }

  $('#matrix').html(output);
}

function addElementInSoccerField(element, player) {
  for(var x = 0; x < matrix.length; x++) {
    for(var y = 0; y < matrix[x].length; y++) {
      if (matrix[x][y] == element) {
        matrix[x][y] = '*';
        matrixModel[x][y] = player;
      }
    }
  }
}

function isSelected(element) {
  	for(var x = 0; x < matrixModel.length; x++) {
    	for(var y = 0; y < matrixModel[x].length; y++) {
      		if (matrixModel[x][y] == element) {
        		return true;
      		}
    	}
  	}
	return false;
}


function createPlayers() {
	var players = new Array();
    var uri = '/players.json';
  	$.getJSON(uri, function(data) {
		$.each(data, function(i, allPlayers) {
			$.each(allPlayers, function(j, player) {
				var playerId = i+1;
			    $('<div id=' + player.id + '><p>' 
						+ player.number +
						'</p><span id="playerName_' + playerId + '" class="playerName">' + player.name + '</span></div>')
						.data('number', i).appendTo('#player').draggable( {
			      containment: '#soccerField',
			      stack: '#player div',
			      cursor: 'move',
			      revert: true
			    });
	  		});
      });		
	});
	
	return players;
}

function createSlots() {
  var slots = new Array();
  for ( var i = 1; i <= 35; i++ ) {
    slots[i-1] = i;
  }
                
  for ( var i = 1; i <= slots.length; i++ ) {
    var index = i-1;
    $('<div id=' + i + '></div>').data('number', i).appendTo('#slot').droppable( {
      accept: '#player div',
      hoverClass: 'hovered',
      drop: handlePlayerDrop
    } );
  }
  
  $('<div id="gk">' + 'GK' + '</div>').data('number', i).appendTo('#soccerField').droppable( {
    accept: '#player div',
    hoverClass: 'hovered',
    drop: handlePlayerDrop
  } );
  return slots;
}

function createEmptySlots() {
  var slots = new Array();
  for ( var i = 1; i <= 35; i++ ) {
    slots[i-1] = i;
  }
                
  for ( var i = 1; i <= slots.length; i++ ) {
    var index = i-1;
    $('<div id="' + i + '" class="emptySlot" ></div>').appendTo('#emptySlot');
  }
  
  $('<div id="gk">' + 'GK' + '</div>').data('number', i).appendTo('#soccerField');
  return slots;
}

function handlePlayerDrop(event, ui) {
  var element = $(this).attr('id');
  var player = ui.draggable.attr('id');
  if (element == $('#gk').attr('id')) {
    goalKeeper = player;
  }
  if (correctPlayers < 10) {
    ui.draggable.addClass('correct');
    ui.draggable.draggable('disable');
    $(this).droppable('disable');
    ui.draggable.position( { of: $(this), my: 'left top', at: 'left top' } );
    ui.draggable.draggable('option', 'revert', false);  
    
    if (player != goalKeeper) {
      correctPlayers++;
      addElementInSoccerField(element, player);
    }
  }
  if (goalKeeper) {
    if (correctPlayers == 10) {
      correctPlayers++;      
    }
  }
}

function convertMatrixModelToJson() {
  var json = '[';
  for(var x = 0; x < matrixModel.length; x++) {
	var element = 0;
    for(var y = 0; y < matrixModel[x].length; y++) {
      element = matrixModel[x][y]? matrixModel[x][y]: 0;
	  if (element != 0) {
      	json += ' { "formation": { ';
      	json += '         "player": "' + element + '"';
      	json += '         , ';
      	json += '         "x": "' + x + '"';
      	json += '         , ';
      	json += '         "y": "' + y + '"';
      	json += '     } ';
      	json += ' } ';
      	if ((y+1) < matrixModel[x].length) {
        	json += ' , ';
      	}
	  }
    }
    if (element != 0) {
      if ((x+1) < matrixModel.length) {
        json += ' , ';
      }
    }
  }  

  if (goalKeeper) {
	if (element > 0) {
      json += ' , ';
	}
    json += ' { "formation": { ';
    json += '         "player": "' + goalKeeper + '"';
    json += '         , ';
    json += '         "x": "' + -1 + '"';
    json += '         , ';
    json += '         "y": "' + -1 + '"';
    json += '     } ';
    json += ' } ';  
  }

  json += ' ] ';
  return json;
}

function send() {
	if (correctPlayers == 11) {
		var json = convertMatrixModelToJson();
		var request = $.ajax({
  					  			url:          "/send",
								dataType:     "json",
								type:         "POST",
								contentType:  "application/json; charset=UTF-8;",
								data:         json,
								complete: formationSent
							});
	} else {
		cSimpleAlert('Selecione os 11 jogadores!');
	}
}

function formationSent() {
	$('#send_button').removeClass("btn danger send").addClass("btn disabled send")
	$('#send_button').attr('disabled', 'disabled');
	$('#send_button').html('Pronto! A sua escalação foi enviada!')
}

function cAlert(title, msg) {
	document.getElementById("dialog-message").title = title;
	cSimpleAlert(msg);
}

function cSimpleAlert(msg) {
	document.getElementById("custom-alert-message").innerHTML = msg;
	$(function() {
		$( "#dialog-message" ).dialog({
			modal: true,
			buttons: {
				OK: function() {
					$(this).dialog("close");
				}
			}
		});
	});
}
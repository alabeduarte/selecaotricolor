var correctGoalKeeper = 0;
var correctPlayers = 0;
var matrix;
var matrixModel;
var goalKeeper;
function init_soccer_field() {
  	// Reset the game
  	correctPlayers = 0;
  	//$('#player').html('');
  	$('#slot').html('');

  	// Create the soccer players
  	var players = createPlayers();

  	// Create the positions
  	var slots = createSlots();

  	// Matrix
  	createMatrix(slots);

  	// Matrix Model
  	createMatrixModel(slots);
	desableSenderButton();
}

function init_soccer_field_to_first_team() {
  	// Reset the game
  	correctPlayers = 0;
  	//$('#player').html('');
  	$('#slot').html('');

  	// Create the soccer players
  	var players = createEnabledAllPlayers();

  	// Create the positions
  	var slots = createSlots();

  	// Matrix
  	createMatrix(slots);

  	// Matrix Model
  	createMatrixModel(slots);
	desableSenderButton();
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
  matrix = new Array(8);
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
  matrixModel = new Array(8);
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

function addElementInSoccerField(slot, player) {
  for(var x = 0; x < matrix.length; x++) {
    for(var y = 0; y < matrix[x].length; y++) {
      if (matrix[x][y] == slot) {
        matrix[x][y] = slot + "_";
        matrixModel[x][y] = player;
      }
    }
  }
}

function isAvailable(slot) {
	for(var x = 0; x < matrix.length; x++) {
    	for(var y = 0; y < matrix[x].length; y++) {
      		if (matrix[x][y] == slot+'_') {
        		return false;
      		}
    	}
  	}
	return true;
}

function removeElementInSoccerField(player) {
  for(var x = 0; x < matrixModel.length; x++) {
    for(var y = 0; y < matrixModel[x].length; y++) {	  
      if (matrixModel[x][y] == player) {		
        matrix[x][y] = matrix[x][y].replace('_', '');
        matrixModel[x][y] = '';
		correctPlayers--;
      }
    }
  }
}

function createEnabledAllPlayers() {
	var players = new Array();
    var uri = '/bahia_squad.json';
  	$.getJSON(uri, function(data) {
		$.each(data, function(i, allPlayers) {
			$.each(allPlayers, function(j, player) {
				var playerId = i+1;			
								
				var playerDiv = '#' + player.id;
				var positionDivName = '';
				var positionDivClass = '';

				if (player.position_mapper.code == 'G') {					
					positionDivName = '#goalkeepers';					
				} else if (player.position_mapper.code == 'DD') {
					positionDivName = '#right_back';										
				} else if (player.position_mapper.code == 'DC') {
					positionDivName = '#defender';
				} else if (player.position_mapper.code == 'DE') {
					positionDivName = '#left_back';
				} else if (player.position_mapper.code == 'MDC') {
					positionDivName = '#midfield_defense';
				} else if (player.position_mapper.code.substring(0, 1) == 'M') {
					positionDivName = '#midfield';
				} else if (player.position_mapper.code.substring(0, 1) == 'A') {
					positionDivName = '#forwards';
				}
				
				if (player.position_mapper.code == 'G') {					
					positionDivClass = 'goal_keeper';
				} else {
					positionDivClass = 'team';
				}
				
				$('<div id=' + player.id + '></div>').appendTo(positionDivName);					
				$(playerDiv).addClass(positionDivClass);
				
				$('<p>' + '&nbsp' + '</p>').appendTo(playerDiv);
				$('<span id="playerName_' + playerId + '">' + player.name + '</span>')
					.addClass('playerName').appendTo(playerDiv);				
				$(playerDiv).addClass('enabled');
				$(playerDiv).data('number', i).appendTo(positionDivName).draggable( {
			    	containment: '.droppable-area',
				    stack: '#player div',
			      	cursor: 'move',
					appendTo: 'body',
					helper: 'clone',
			      	revert: true
				});
				$(playerDiv).mousedown(function () {
					$('#slot').css('display', 'block');
					$('#positionMap').css('display', 'block');
				});
				$(playerDiv).mouseup(function () {
					$('#slot').css("display","none");
					$('#positionMap').css('display', 'none');
				});
				$(playerDiv).addClass('player');
				
	  		});
      });		
	});
	
	return players;
}

function createPlayers() {
	var players = new Array();
    var uri = '/bahia_squad.json';
  	$.getJSON(uri, function(data) {
		$.each(data, function(i, allPlayers) {
			$.each(allPlayers, function(j, player) {
				var playerId = i+1;			
								
				var playerDiv = '#' + player.id;
				var positionDivName = '';
				var positionDivClass = '';

				if (player.position_mapper.code == 'G') {					
					positionDivName = '#goalkeepers';					
				} else if (player.position_mapper.code == 'DD') {
					positionDivName = '#right_back';										
				} else if (player.position_mapper.code == 'DC') {
					positionDivName = '#defender';
				} else if (player.position_mapper.code == 'DE') {
					positionDivName = '#left_back';
				} else if (player.position_mapper.code == 'MDC') {
					positionDivName = '#midfield_defense';
				} else if (player.position_mapper.code.substring(0, 1) == 'M') {
					positionDivName = '#midfield';
				} else if (player.position_mapper.code.substring(0, 1) == 'A') {
					positionDivName = '#forwards';
				}
				
				if (player.position_mapper.code == 'G') {					
					positionDivClass = 'goal_keeper';
				} else {
					positionDivClass = 'team';
				}
				
				$('<div id=' + player.id + '></div>').appendTo(positionDivName);					
				$(playerDiv).addClass(positionDivClass);
				
				$('<p>' + '&nbsp' + '</p>').appendTo(playerDiv);
				$('<span id="playerName_' + playerId + '">' + player.name + '</span>')
					.addClass('playerName').appendTo(playerDiv);
				
				if (player.enabled) {
					$(playerDiv).addClass('enabled');
					$(playerDiv).data('number', i).appendTo(positionDivName).draggable( {
				    	containment: '#soccerField',
					    stack: '#player div',
				      	cursor: 'move',
						appendTo: 'body',
						helper: 'clone',
				      	revert: true
					});
					$(playerDiv).mousedown(function () {
						$('#slot').css('display', 'block');
						$('#positionMap').css('display', 'block');
					});
					$(playerDiv).mouseup(function () {
						$('#slot').css("display","none");
						$('#positionMap').css('display', 'none');
					});
				} else {
					$(playerDiv).addClass('disabled');
				}
				$(playerDiv).addClass('player');
				
	  		});
      });		
	});
	
	return players;
}

function createSlots() {
  var slots = new Array();
  for ( var i = 1; i <= 40; i++ ) {
    slots[i-1] = i;
  }
                
  for ( var i = 1; i <= slots.length; i++ ) {
    var index = i-1;
    $('<div id=' + i + '></div>').data('number', i).appendTo('#slot').droppable( {
      accept: '.team',
      hoverClass: 'hovered',
      drop: handlePlayerDrop
    } );
  }
  
  $('<div id="gk">' + '<p></p>' + '</div>').data('number', i).appendTo('#soccerField').droppable( {
    accept: '.goal_keeper',
    hoverClass: 'hovered',
    drop: handlePlayerDrop
  } );
  return slots;
}

function createEmptySlots() {
  var slots = new Array();
  for ( var i = 1; i <= 40; i++ ) {
    slots[i-1] = i;
  }
                
  for ( var i = 1; i <= slots.length; i++ ) {
    var index = i-1;
    $('<div id="' + i + '" class="emptySlot" ></div>').appendTo('#emptySlot');
  }
  
  $('<div id="gk">' + '' + '</div>').data('number', i).appendTo('#soccerField');
  return slots;
}

function handlePlayerDrop(event, ui) {		
	var slot = $(this).attr('id');
  	var player = ui.draggable.attr('id');
  	if (slot == $('#gk').attr('id')) {
		if (correctGoalKeeper > 0) {
			return;
		}
    	goalKeeper = player;
  	}

  	if (correctPlayers < 10 || isPlayerPositionChange(ui)) {
		if (isAvailable(slot)) {
			ui = dropPlayer($(this), ui, slot);  
		    if (player != goalKeeper) {
		      correctPlayers++;
		      addElementInSoccerField(slot, player);
		    }
		}		
	}
		
	if (goalKeeper != undefined && correctGoalKeeper == 0) {		
		ui = dropPlayer($(this), ui, slot); 
	    if (player == goalKeeper) {
	      correctGoalKeeper++;
	    }
	}
	$('#slot').css('display', 'none');
	$('#positionMap').css('display', 'none');
	if (correctGoalKeeper == 1 && correctPlayers == 10) {
		enableSenderButton();
	}
}

function isPlayerPositionChange(ui) {
	return ui.draggable.hasClass('correct') && !ui.draggable.hasClass('goal_keeper');
}

function dropPlayer(target, ui, slot) {
	if (isPlayerPositionChange(ui)) {
		removeElementInSoccerField(ui.draggable.attr('id'));
		addElementInSoccerField(slot, ui.draggable.attr('id'));			
	}
	ui.draggable.appendTo('#soccerField');
	ui.draggable.addClass('correct');
	ui.draggable.css('position', 'absolute');
    ui.draggable.position( { of: target, my: 'left top', at: 'left top' } );
    ui.draggable.draggable('option', 'revert', false);		
	return ui;
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
  return $.trim(json);
}

function send() {
	if (correctPlayers == 10 && correctGoalKeeper == 1) {
		var json = convertMatrixModelToJson();
		desableSenderButton();
		$('#send_button').html('Enviando...');
		$.ajax({
	  			url:          "/create",
				dataType:     "json",
				type:         "POST",
				contentType:  "application/json",
				data:         json,
				complete: function() {
					window.location.href = "/create";
				}
		});
	} else {
		cSimpleAlert('Selecione os 11 jogadores!');
	}
}

function desableSenderButton() {
	$('#send_button').attr('disabled', 'disabled');
	$('#send_button').addClass("disabled");	
}

function enableSenderButton() {
	$("#send_button").removeAttr("disabled");
	$('#send_button').removeClass("disabled");
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

function load_formation() {	
  	getFormationByServer(window.location.pathname);
}

function load_formation_of_last_round() {	
  	getFormationByServer('/last_squad_of_the_round');
}

function getFormationByServer(path) {
	var lines = matrixModel.length;
	var columns = matrixModel[lines-1].length;
	var total = lines*columns;	
	$.getJSON(path + '.json', function(data) {
  		$.each(data, function(i, formation){
			$.each(formation.players_positions, function(j, player_position){
				var x = player_position.x;
				var y = player_position.y;
				var player = player_position.player;
				var element = player.number;
				
				for(var index = 0; index < total; index++) {
					if (x == 0) {
						if (index == y) {
							addPlayer(index, player);
						}
					} else {
						var nextPosition = (columns * x) + y;
						if (index == nextPosition) {
							addPlayer(index, player);
						}
					}
				}
				if (x == -1 && y == -1) {
					var slotId = '#gk';
					$(slotId).addClass("present");
					//$(slotId).html('<p>' + player.number + '</p><span class="playerName">' 
					$(slotId).html('<p>' + '&nbsp' + '</p><span class="playerName">' 
					+ player.name + '</span>');
				}

	        });	
        });		
	});
}

function addPlayer(index, player) {
	var slotId = '#' + (index+1);
	//$(slotId).html('<p>' + player.number + '</p><span class="playerName">' 
	$(slotId).html('<p>' + '&nbsp' + '</p><span class="playerName">' 
	+ player.name + '</span>');
	$(slotId).addClass("team");
}

function showFormation(path) {
	load_soccer_field();
	getFormationByServer(path);
}
PlayerBuilder = function() {
}

PlayerBuilder.prototype.findAll = function() {
  var url = '/bahia_squad.json';
  var result = [];
  $.getJSON(url, function(data) {
    $.each(data, function(index, players) {
      result[index] = players.player;
    });
  });
  return result;
}

PlayerBuilder.prototype.getPositionDivName = function(player) {
  switch(player.position_mapper.code) {
    case "G":
      return "#goalkeepers";
    case "DD":
      return "#right_back";
    case "DC":
      return "#defender";
    case "DE":
      return "#left_back";
    case "MDC":
      return "#midfield_defense";
  }
  switch(player.position_mapper.code.substring(0, 1)) {
    case "M":
      return "#midfield";
    case "A":
      return "#forwards";
  }
}

PlayerBuilder.prototype.isGoalKeeper = function(player) {
  return player.position_mapper.code === "G";
}

PlayerBuilder.prototype.create = function(players) {
  var builder = this;
  $.each(players, function(index, player) {
    var positionDivName = builder.getPositionDivName(player);
    $('<div id=' + player.id + ' name=' + positionDivName + '></div>').appendTo(positionDivName);
    var positionClass = builder.isGoalKeeper(player)? "goal_keeper": "team";
    $("#" + player.id).addClass(positionClass);
  });
}

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

PlayerBuilder.prototype.create = function(players) {
  $.each(players, function(index, player) {
    var positionDivName = "#forwards";
    $('<div id=' + player.id + ' name=' + positionDivName + '></div>').appendTo(positionDivName);
  });
}

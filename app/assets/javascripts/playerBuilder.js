PlayerBuilder = function() {
}

PlayerBuilder.prototype.findAll = function() {
  var url = '/bahia_squad.json';
  var result = [];
  $.getJSON(url, function(data) {
    $.each(data, function(index, players) {
      var player = new Player(players.player);
      result[index] = player;
    });
  });
  return result;
}

PlayerBuilder.prototype.create = function(players) {
  var builder = this;
  $.each(players, function(index, player) {
    $('<div id=' + player.id + ' name=' + player.positionName() + '></div>').appendTo("#" + player.positionName());
    $("#" + player.id).addClass(player.bodyType());
    $("<p>&nbsp</p>").appendTo("#" + player.id);
    $('<div id="popover_' + player.id + '"></div>').appendTo('#' + player.id);
    $('#popover_' + player.id).addClass("popover");
  });
}

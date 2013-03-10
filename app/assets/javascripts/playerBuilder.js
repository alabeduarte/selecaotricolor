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
    builder.createDiv(player);
    builder.addPopover(player);
  });
}

PlayerBuilder.prototype.createDiv = function(player) {
  $('<div id=' + player.id
      + ' name=' + player.positionName() + '>'
      + player.name + '</div>')
    .appendTo("#" + player.positionName());

  $("#" + player.id).addClass(player.bodyType());
}

PlayerBuilder.prototype.addPopover = function(player) {
  $("<p>&nbsp</p>").appendTo("#" + player.id);
  $('<div id="popover_' + player.id + '"></div>').appendTo('#' + player.id);
  $('#popover_' + player.id).addClass("popover");
  $('<img id="avatar_' + player.id
      + '" src="/assets/bahia_squad/' + player.avatar
      + '" width="75px" height="105px"></img>')
    .appendTo('#popover_' + player.id);

  $('<span class="number">' + player.number + '</span>')
    .appendTo('#popover_' + player.id);
}

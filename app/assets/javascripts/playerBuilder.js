PlayerBuilder = function() {
}

PlayerBuilder.prototype.create = function() {
  var url = '/bahia_squad.json';
  $.getJSON(url, function(data) {
  });
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

PlayerBuilder = function() {
}

PlayerBuilder.prototype.create = function() {
  var url = '/bahia_squad.json';
  $.getJSON(url, function(data) {
  });
}

PlayerBuilder.prototype.findAll = function() {
  var url = '/bahia_squad.json';
  return $.getJSON(url);
}

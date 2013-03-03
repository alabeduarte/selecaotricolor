SoccerField = function(rows, columns) {
  this.rows = rows;
  this.columns = columns;
  this.slotSize = function() { return this.rows * this.columns; };
  this.slots = this.initSlots();
}

EmptySlot = function(index, x, y) {
  this.index = index;
  this.x = x;
  this.y = y;
}

PlayerSlot = function(player, x, y) {
  this.index = player.position
  this.player = player;
  this.x = x;
  this.y = y;
}

SoccerField.prototype.initSlots = function() {
  var slots = new Array(this.columns);
  for(var i = 0; i < slots.length; i++) {
    slots[i] = new Array(this.rows);
  }
  var index = 0;
  while(index < this.slotSize()) {
    for(var x = 0; x < slots.length; x++) {
      for(var y = 0; y < slots[x].length; y++) {
        slots[x][y] = new EmptySlot(index, x, y);
        index++;
      }
    }
  }
  return slots;
}

SoccerField.prototype.getSlot = function(index) {
  for(var x = 0; x < this.slots.length; x++) {
    for(var y = 0; y < this.slots[x].length; y++) {
      var slot = this.slots[x][y];
      if (slot.index === index) {
        return slot;
      }
    }
  }
  return null;
}

SoccerField.prototype.add = function(player) {
  var slot = this.getSlot(player.position);
  if (slot) {
    var x = slot.x;
    var y = slot.y;
    this.slots[x][y] = new PlayerSlot(player, x, y);
    return player;
  }
  return null;
}

SoccerField.prototype.remove = function(player) {
  var slot = this.getSlot(player.position);
  if (slot) {
    var x = slot.x;
    var y = slot.y;
    this.slots[x][y] = new EmptySlot(player.position, x, y);
    return player;
  }
  return null;
}

SoccerField.prototype.isAvailable = function(slot) {
  return this.getPlayerBySlot(slot)? false: true;
}

SoccerField.prototype.getPlayerBySlot = function(index) {
  var slot = this.getSlot(index);
  if (slot && slot instanceof PlayerSlot) {
    return slot.player;
  }
  return null;
}

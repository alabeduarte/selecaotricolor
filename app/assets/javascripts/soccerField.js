SoccerField = function() {
  this.rows = 5;
  this.columns = 8;
  this.slotSize = function() {
    return this.rows * this.columns;
  };
  this.slots = this.initSlots();
  this.logicalMatrix = this.initLogicalMatrix();
  this.matrix = this.fillMatrix();
}

SoccerField.prototype.initSlots = function() {
  var slots = [];
  for(var i = 0; i < this.slotSize; i++) { slots[i] = i+1; }
  return slots;
}

SoccerField.prototype.initMatrix = function() {
  var matrix = new Array(this.columns);
  for(var i = 0; i < matrix.length; i++) {
    matrix[i] = new Array(this.rows);
  }
  return matrix;
}

SoccerField.prototype.initLogicalMatrix = function() {
  var logicalMatrix = this.initMatrix();
  for(var x = 0; x < logicalMatrix.length; x++) {
    for(var y = 0; y < logicalMatrix[x].length; y++) {
      logicalMatrix[x][y] = '';
    }
  }
  return logicalMatrix;
}

SoccerField.prototype.fillMatrix = function() {
  var matrix = this.initMatrix();
  var index = 0;
  while(index < this.slotSize()) {
    for(var x = 0; x < matrix.length; x++) {
      for(var y = 0; y < matrix[x].length; y++) {
        matrix[x][y] = index;
        index++;
      }
    }
  }
  return matrix;
}

SoccerField.prototype.add = function(player) {
  for(var x = 0; x < this.matrix.length; x++) {
    for(var y = 0; y < this.matrix[x].length; y++) {
      if (this.matrix[x][y] === player.position) {
        this.matrix[x][y] = player.position + "_";
        this.logicalMatrix[x][y] = player;
      }
    }
  }
}

SoccerField.prototype.remove = function(player) {
  for(var x = 0; x < this.logicalMatrix.length; x++) {
    for(var y = 0; y < this.logicalMatrix[x].length; y++) {
      if (this.logicalMatrix[x][y] == player) {
        this.matrix[x][y] = this.matrix[x][y].replace('_', '');
        this.logicalMatrix[x][y] = '';
        return player;
      }
    }
  }
  return null;
}

SoccerField.prototype.isAvailable = function(slot) {
  return this.getPlayerBySlot(slot)? false: true;
}

SoccerField.prototype.getPlayerBySlot = function(slot) {
  for(var x = 0; x < this.matrix.length; x++) {
    for(var y = 0; y < this.matrix[x].length; y++) {
      if (this.matrix[x][y] === slot+'_') {
        return this.logicalMatrix[x][y];
      }
    }
  }
  return null;
}

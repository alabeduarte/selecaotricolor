SoccerField = function() {
  this.rows = 5;
  this.columns = 8;
  this.slotSize = function() {
    return this.rows * this.columns;
  };
  this.slots = function() {
    var slots = [];
    for(var i = 0; i < this.slotSize; i++) {
      slots[i] = i+1;
    }
    return slots;
  };
  this.logicalMatrix = function() {
    var logicalMatrix = this.initMatrix();
    for(var x = 0; x < logicalMatrix.length; x++) {
      for(var y = 0; y < logicalMatrix[x].length; y++) {
        logicalMatrix[x][y] = '';
      }
    }
    return logicalMatrix;
  };
  this.matrix = function() {
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
  };

}

SoccerField.prototype.initMatrix = function() {
  var matrix = new Array(this.columns);
  for(var i = 0; i < matrix.length; i++) {
    matrix[i] = new Array(this.rows);
  }
  return matrix;
}

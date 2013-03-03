describe("SoccerField", function() {
  var soccerField;

  beforeEach(function() {
    soccerField = new SoccerField();
  });

  describe("Creating a matrix", function() {
    it("should have numbers of rows and columns", function() {
      expect(soccerField.rows).toEqual(5);
      expect(soccerField.columns).toEqual(8);
    });

    describe("Slots", function() {
      it("should initialize slots with [rows * columns] positions", function() {
        var slots = soccerField.slots();
        expect(soccerField.slotSize()).toEqual(40);
      });

      it("should fill every slot sequentially values", function() {
        var slots = soccerField.slots();
        for(var i=0; i<=soccerField.slotSize; i++) {
          expect(slots[i]).toEqual(i+1);
        }
      });
    });

    describe("Matrix", function() {
      it("should initialize matrix with columns and rows", function() {
        var matrix = soccerField.matrix();
        expect(matrix.length).toEqual(soccerField.columns);
        expect(matrix[0].length).toEqual(soccerField.rows);
      });

      it("should fill matrix with sequentially values", function() {
        var matrix = soccerField.matrix();
        var index = 0;
        while(index < soccerField.slotSize()) {
          for(var x = 0; x < matrix.length; x++) {
            for(var y = 0; y < matrix[x].length; y++) {
              expect(matrix[x][y]).toEqual(index);
              index++;
            }
          }
        }
      });
    });

    describe("Logical matrix", function() {
      it("should initialize logical matrix with columns and rows", function() {
        var logicalMatrix = soccerField.logicalMatrix();
        expect(logicalMatrix.length).toEqual(soccerField.columns);
        expect(logicalMatrix[0].length).toEqual(soccerField.rows);
      });

      it("should  fill logical matrix with empty values", function() {
        var logicalMatrix = soccerField.logicalMatrix();
        for(var x = 0; x < logicalMatrix.length; x++) {
          for(var y = 0; y < logicalMatrix[x].length; y++) {
            expect(logicalMatrix[x][y]).toEqual('');
          }
        }
      });
    });

  });
});

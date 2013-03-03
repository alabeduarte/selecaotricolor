describe("SoccerField", function() {
  var soccerField;
  var player;

  beforeEach(function() {
    soccerField = new SoccerField();
    player = new Player("1", 10);
  });

  describe("Creating a matrix", function() {
    it("should have numbers of rows and columns", function() {
      expect(soccerField.rows).toEqual(5);
      expect(soccerField.columns).toEqual(8);
    });

    describe("Slots", function() {
      it("should initialize slots with [rows * columns] positions", function() {
        var slots = soccerField.slots;
        expect(soccerField.slotSize()).toEqual(40);
      });

      it("should fill every slot sequentially values", function() {
        var slots = soccerField.slots;
        for(var i=0; i<=soccerField.slotSize; i++) {
          expect(slots[i]).toEqual(i+1);
        }
      });
    });

    describe("Matrix", function() {
      it("should initialize matrix with columns and rows", function() {
        var matrix = soccerField.matrix;
        expect(matrix.length).toEqual(soccerField.columns);
        expect(matrix[0].length).toEqual(soccerField.rows);
      });

      it("should fill matrix with sequentially values", function() {
        var matrix = soccerField.matrix;
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
        var logicalMatrix = soccerField.logicalMatrix;
        expect(logicalMatrix.length).toEqual(soccerField.columns);
        expect(logicalMatrix[0].length).toEqual(soccerField.rows);
      });

      it("should  fill logical matrix with empty values", function() {
        var logicalMatrix = soccerField.logicalMatrix;
        for(var x = 0; x < logicalMatrix.length; x++) {
          for(var y = 0; y < logicalMatrix[x].length; y++) {
            expect(logicalMatrix[x][y]).toEqual('');
          }
        }
      });
    });

    describe("Adding player at slot", function() {
      it("should concat slot value with '_' on matrix position", function() {
        soccerField.add(player);
        expect(soccerField.matrix[2][0]).toEqual("10_");
      });

      it("should add player on logical matrix position", function() {
        soccerField.add(player);
        expect(soccerField.logicalMatrix[2][0]).toEqual(player);
      });

      describe("when slot are empty", function() {
        it("should be available slot", function() {
          var slot = 10;
          expect(soccerField.isAvailable(slot)).toBe(true);
        });
      });
      describe("when slot are filled", function() {
        beforeEach(function() {
          soccerField.add(player);
        });
        it("should be unavailable slot", function() {
          expect(soccerField.isAvailable(player.position)).toBe(false);
        });
        it("should get player by slot", function() {
          var playerFound = soccerField.getPlayerBySlot(player.position);
          expect(playerFound.id).toEqual("1");
          expect(playerFound.position).toEqual(10);
        });
        it("should be able to remove player", function() {
          var playerRemoved = soccerField.remove(player);
          expect(playerRemoved).toEqual(player);
          expect(soccerField.matrix[2][0]).toEqual("10");
          expect(soccerField.logicalMatrix[2][0]).toEqual('');
        });

      });
    });

  });
});

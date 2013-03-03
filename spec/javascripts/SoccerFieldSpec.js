describe("SoccerField", function() {
  var soccerField;
  var player;

  beforeEach(function() {
    soccerField = new SoccerField(5, 8);
    player = new Player("1", 10);
  });

  describe("Creating Slots", function() {
    it("should have numbers of rows and columns", function() {
      expect(soccerField.rows).toEqual(5);
      expect(soccerField.columns).toEqual(8);
    });

    describe("Slots", function() {
      it("should initialize slots with [rows * columns] positions", function() {
        var slots = soccerField.slots;
        expect(soccerField.slotSize()).toEqual(40);
      });

      it("should initialize logical matrix with columns and rows", function() {
        var slots = soccerField.slots;
        expect(slots.length).toEqual(soccerField.columns);
        expect(slots[0].length).toEqual(soccerField.rows);
      });

      it("should  fill logical matrix with empty values", function() {
        var slots = soccerField.slots;
        var index = 0;
        while(index < soccerField.slotSize()) {
          for(var x = 0; x < slots.length; x++) {
            for(var y = 0; y < slots[x].length; y++) {
              slot = slots[x][y];
              expect(slot instanceof EmptySlot).toBe(true);
              expect(slot.index).toEqual(index);
              index++;
            }
          }
        }
      });

    });

    describe("Adding player at slot", function() {
      it("should add player on logical matrix position", function() {
        soccerField.add(player);
        var slot = soccerField.slots[2][0]
        expect(slot instanceof PlayerSlot).toBe(true);
        expect(slot.player).toEqual(player);
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
          expect(soccerField.slots[2][0] instanceof EmptySlot).toBe(true);
          expect(soccerField.slots[2][0].index).toEqual(10);
        });

      });
    });

  });
});

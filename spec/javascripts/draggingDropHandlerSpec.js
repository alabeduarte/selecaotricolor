describe("DraggingDropHandler", function() {
  var draggingDropHandler;

  beforeEach(function() {
    loadFixtures('newFormation.html');
    var soccerField = new SoccerField(5, 8);
    draggingDropHandler = new DraggingDropHandler(soccerField);
  });

  describe("Initializing soccer field", function() {
    beforeEach(function() {
      draggingDropHandler.init();
    });
    it("should make each slot as droppable", function() {
      var soccerField = draggingDropHandler.soccerField;
      for(var i=0; i < soccerField.slotSize(); i++) {
        expect($("#" + i)).toHaveClass('ui-droppable');
      }
    });
    it("should make goal keeper as droppable", function() {
      var soccerField = draggingDropHandler.soccerField;
      expect($("#gk")).toHaveClass('ui-droppable');
    });
    it("should disable #send_button", function() {
      expect($('#send_button')).toHaveClass('disabled');
      expect($('#send_button').attr('disabled')).toEqual('disabled');
    });
  });

  describe("Handling drag in drop", function() {
    describe("when player is disabled", function() {
      var player;
      beforeEach(function() {
        player = new Player({id: "playerId", name: "Lomba", number: "1", position_mapper: {code: "G"}, enabled: false});
        $('<div id="' + player.id + '"></div>').appendTo("#" + player.positionName());
        draggingDropHandler.handle(player);
      });

      it("should make player as draggable", function() {
        expect($("#playerId")).not.toHaveClass("ui-draggable");
      });
    });

    describe("when player is enabled", function() {
      var player;
      beforeEach(function() {
        player = new Player({id: "playerId", name: "Lomba", number: "1", position_mapper: {code: "G"}, enabled: true});
        $('<div id="' + player.id + '"></div>').appendTo("#" + player.positionName());
        draggingDropHandler.handle(player);
      });

      it("should make player as draggable", function() {
        expect($("#playerId")).toHaveClass("ui-draggable");
      });
      describe("when mouse down", function() {
        beforeEach(function() {
          $("#playerId").trigger("mousedown");
        });
        it("should show the slots", function() {
          expect($("#slot").css('display')).toEqual('block');
        });
        it("should show the position map", function() {
          expect($("#positionMap").css('display')).toEqual('block');
        });
      });
      describe("when mouse up", function() {
        beforeEach(function() {
          $("#playerId").trigger("mouseup");
        });
        it("should hide the slots", function() {
          expect($("#slot").css('display')).toEqual('none');
        });
        it("should show position map", function() {
          expect($("#positionMap").css('display')).toEqual('none');
        });
      });
    });

  });
});

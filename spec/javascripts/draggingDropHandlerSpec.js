describe("DraggingDropHandler", function() {
  var draggingDropHandler;

  beforeEach(function() {
    loadFixtures('draggingDropHandler.html');
    var soccerField = new SoccerField(5, 8);
    draggingDropHandler = new DraggingDropHandler(soccerField);
  });

  describe("Initializing soccer field", function() {
    beforeEach(function() {
      draggingDropHandler.init();
    });
    it("should build each slot as droppable", function() {
      var soccerField = draggingDropHandler.soccerField;
      for(var i=0; i < soccerField.slotSize(); i++) {
        var item = $('#' + i);
        expect(item.hasClass('ui-droppable')).toBe(true);
      }
    });
    it("should disable #send_button", function() {
      expect($('#send_button').hasClass('disabled')).toBe(true);
    });
  });

});

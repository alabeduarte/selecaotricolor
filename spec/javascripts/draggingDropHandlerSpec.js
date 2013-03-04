describe("DraggingDropHandler", function() {
  var draggingDropHandler;

  beforeEach(function() {
    loadFixtures('draggingDropHandler.html');
    var soccerField = new SoccerField(5, 8);
    draggingDropHandler = new DraggingDropHandler(soccerField);
  });

  describe("Initializing soccer field", function() {
    it("should clean up #slot", function() {
      draggingDropHandler.cleanUp();
      expect($('#slot').html()).toEqual('');
    });
  });

});

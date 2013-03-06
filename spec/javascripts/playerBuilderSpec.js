describe("PlayerBuilder", function() {
  var playerBuilder;

  beforeEach(function() {
    playerBuilder = new PlayerBuilder();
    /*
    var players = sinon.stub($, "getJSON", function() {
      return '[{ "player": { "id":"1","name":"Souza","number":9 } }]';
    });
    */
  });

  afterEach(function() {
    $.getJSON.restore();
  });

  describe("Finding players", function() {
    it("should call for JSON services", function() {
      var ajaxSpy = sinon.spy($, "getJSON");
      playerBuilder.findAll();
      expect(ajaxSpy).toHaveBeenCalled();
      expect(ajaxSpy.getCall(0).args[0]).toEqual('/bahia_squad.json');
    });
  });

  describe("Creating Players", function() {

  });
});

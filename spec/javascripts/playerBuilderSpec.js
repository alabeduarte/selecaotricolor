describe("PlayerBuilder", function() {
  var playerBuilder;
  var server;

  beforeEach(function() {
    server = sinon.fakeServer.create();
    server.respondWith("GET", "/bahia_squad.json", [200, { "Content-Type": "application/json" }, '[{ "player": { "id":"1","name":"Souza","number":9 } }]']);

    playerBuilder = new PlayerBuilder();
  });

  afterEach(function() {
    server.restore();
  });

  describe("Finding players", function() {
    it("should call for JSON services", function() {
      var ajaxSpy = sinon.spy($, "getJSON");
      playerBuilder.findAll();
      server.respond();
      expect(ajaxSpy).toHaveBeenCalled();
      expect(ajaxSpy.getCall(0).args[0]).toEqual('/bahia_squad.json');
    });
    describe("when request is successfull", function() {
      it("should fetch all data of players", function() {
        var players = playerBuilder.findAll();
        server.respond();
        expect(players.length).toEqual(1);
      });

      it("should match player fields", function() {
        var all = playerBuilder.findAll();
        server.respond();

        var player = all[0];
        expect(player.id).toEqual("1");
        expect(player.name).toEqual("Souza");
        expect(player.number).toEqual(9);
      });
    });
  });

  describe("Creating Players", function() {

  });
});

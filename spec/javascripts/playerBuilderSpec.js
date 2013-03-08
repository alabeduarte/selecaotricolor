describe("PlayerBuilder", function() {
  var playerBuilder;
  var server;

  beforeEach(function() {
    loadFixtures('newFormation.html');
    server = sinon.fakeServer.create();
    server.respondWith("GET", "/bahia_squad.json", [200, { "Content-Type": "application/json" }, '[{ "player": { "id":"playerId","name":"Souza","number":9 } }]']);

    playerBuilder = new PlayerBuilder();
  });

  afterEach(function() {
    server.restore();
  });

  describe("Finding players", function() {
    var ajaxSpy = sinon.spy($, "getJSON");
    var all;

    beforeEach(function() {
      all = playerBuilder.findAll();
      server.respond();
    });
    it("should call for JSON services", function() {
      expect(ajaxSpy).toHaveBeenCalled();
      expect(ajaxSpy.getCall(0).args[0]).toEqual('/bahia_squad.json');
    });
    describe("when request is successfull", function() {
      it("should fetch all data of players", function() {
        expect(all.length).toEqual(1);
      });
      it("should match player fields", function() {
        var player = all[0];
        expect(player.id).toEqual("playerId");
        expect(player.name).toEqual("Souza");
        expect(player.number).toEqual(9);
      });
    });
  });

  describe("Preparing Players", function() {
    describe("Creating div for players", function() {
      it("should create div for player with player id", function() {
        var players = [{id: "playerId", name: "Souza", number: "9"}];
        playerBuilder.create(players);
        expect($('#forwards')).toContain($('#playerId'));
      });
    });
  });
});

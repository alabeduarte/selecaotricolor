describe("PlayerBuilder", function() {
  var playerBuilder;
  var server;

  beforeEach(function() {
    loadFixtures('newFormation.html');
    server = sinon.fakeServer.create();
    server.respondWith("GET", "/bahia_squad.json", [200, { "Content-Type": "application/json" }, '[{ "player": { "id":"playerId","name":"Souza","number":9, "position_mapper":{"code":"AC"} } }]']);

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
        expect(player.positionCode).toEqual("AC");
      });
    });
  });

  describe("Preparing Players", function() {
    describe("Creating div for players", function() {

      describe("Appending to position div", function() {
        it("should create div for player with player id inside in his position mapper", function() {
          var players = [new Player({id: "playerId", name: "Neto", number: "2", position_mapper: {code: "DD"}})];
          var player = players[0];
          playerBuilder.create(players);
          expect($("#" + player.positionName())).toContain($('#playerId'));
        });

        it("should add .goal_keeper css class for goalkeeper", function() {
          var players = [new Player({id: "playerId", name: "Lomba", number: "1", position_mapper: {code: "G"}})];
          var player = players[0];
          var positionDivName = player.positionName();
          playerBuilder.create(players);
          expect($("#playerId")).toHaveClass("goal_keeper");
        });

        it("should add .team css class for anothers", function() {
          var players = [new Player({id: "playerId", name: "Fahel", number: "7", position_mapper: {code: "MDC"}})];
          var player = players[0];
          var positionDivName = player.positionName();
          playerBuilder.create(players);
          expect($("#playerId")).toHaveClass("team");
        });
      });

    });

  });

});

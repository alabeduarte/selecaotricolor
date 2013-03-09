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
    var players;
    beforeEach(function() {
      players = [new Player({id: "playerId1", name: "Lomba", number: "1", position_mapper: {code: "G"}}), new Player({id: "playerId2", name: "Neto", number: "2", position_mapper: {code: "DD"}}), new Player({id: "playerId3", name: "Fahel", number: "7", position_mapper: {code: "MDC"}})];
    });

    describe("Appending to position div", function() {
      it("should create div for player with player id inside in his position mapper", function() {
        var player = players[1];
        playerBuilder.create(players);
        expect($("#right_back")).toContain($('#playerId2'));
      });
      it("should add .goal_keeper css class for goalkeeper", function() {
        var player = players[0];
        playerBuilder.create(players);
        expect($("#playerId1")).toHaveClass("goal_keeper");
      });
      it("should add .team css class for anothers", function() {
        var player = players[2];
        playerBuilder.create(players);
        expect($("#playerId3")).toHaveClass("team");
      });
    });
    describe("Adding popover", function() {
      var player;
      beforeEach(function() {
        player = players[2];
        playerBuilder.create(players);
      });
      it("should have popover with name", function() {
        expect($('#playerId3')).toContain($('#popover_playerId3'));
      });
      it("should have .popover css class", function() {
        expect($('#popover_playerId3')).toHaveClass("popover");
      })
      xit("should have contain img source inside popover", function() {

      });
    });

  });

});

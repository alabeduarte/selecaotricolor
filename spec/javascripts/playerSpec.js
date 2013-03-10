describe("Player", function() {
  describe("getting position div name", function() {
    it("should get #goalkeepers", function() {
      var player = new Player({name: "Marcelo Lomba", position_mapper: {code: "G"}});
      expect(player.positionName()).toEqual("goalkeepers");
    });
    it("should get #right_back", function() {
      var player = new Player({name: "Neto", position_mapper: {code: "DD"}});
      expect(player.positionName()).toEqual("right_back");
    });
    it("should get #defender", function() {
      var player = new Player({name: "Titi", position_mapper: {code: "DC"}});
      expect(player.positionName()).toEqual("defender");
    });
    it("should get #left_back", function() {
      var player = new Player({name: "Jussandro", position_mapper: {code: "DE"}});
      expect(player.positionName()).toEqual("left_back");
    });
    it("should get #midfield_defense", function() {
      var player = new Player({name: "Fahel", position_mapper: {code: "MDC"}});
      expect(player.positionName()).toEqual("midfield_defense");
    });
    it("should get #midfield", function() {
      var player = new Player({name: "Rosales", position_mapper: {code: "ME"}});
      expect(player.positionName()).toEqual("midfield");
    });
    it("should get #forwards", function() {
      var player = new Player({name: "Souza", position_mapper: {code: "AC"}});
      expect(player.positionName()).toEqual("forwards");
    });
  });
});

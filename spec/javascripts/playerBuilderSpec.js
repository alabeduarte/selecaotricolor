describe("PlayerBuilder", function() {
  var playerBuilder;

 beforeEach(function() {
    playerBuilder = new PlayerBuilder();
  });

  describe("Creating players", function() {
    it("should call for bahia squad url", function() {
      var ajaxSpy = sinon.spy($, "getJSON");
      playerBuilder.create();
      expect(ajaxSpy).toHaveBeenCalled();
    });
  });
});

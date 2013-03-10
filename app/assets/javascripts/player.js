Player = function(player) {
  this.id = player.id;
  this.enabled = player.enabled
  this.avatar = player.avatar;
  this.name = player.name;
  this.number = player.number;
  this.slot = null;
  this.positionCode = player.position_mapper.code;
  this.bodyType = function() {
    return this.positionCode === "G"? "goal_keeper": "team";
  };
  this.positionName = function() {
    switch(this.positionCode) {
      case "G":
        return "goalkeepers";
      case "DD":
        return "right_back";
      case "DC":
        return "defender";
      case "DE":
        return "left_back";
      case "MDC":
        return "midfield_defense";
    }
    switch(this.positionCode.substring(0, 1)) {
      case "M":
        return "midfield";
      case "A":
        return "forwards";
    }
  };
}

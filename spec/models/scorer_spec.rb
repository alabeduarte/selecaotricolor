require "spec_helper"

module FormationHelpers
  
  def init_last_match(home, away)
    Calendar.create!(
                      day: Time.utc(2000, 1, 1, 17, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: false)
  end
  
  def init_next_match(home, away)
    Calendar.create!(
                      day: Time.utc(3000, 1, 1, 17, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: false)
  end
  
  def init_positions
    json = '[{"code":"AC","description":"Atacante (Centro)","id":"4f4c334ae1af8008c800006a","x_max":1,"x_min":0,"y_max":3,"y_min":1},{"code":"AE","description":"Atacante (Lado Esquerdo)","id":"4f4c334ae1af8008c800006b","x_max":1,"x_min":0,"y_max":0,"y_min":0},{"code":"AD","description":"Atacante (Lado Direito)","id":"4f4c334ae1af8008c800006c","x_max":1,"x_min":0,"y_max":4,"y_min":4},{"code":"MAC","description":"Meio Campo Avan\u00e7ado (Centro)","id":"4f4c334ae1af8008c800006d","x_max":2,"x_min":2,"y_max":2,"y_min":2},{"code":"MAE","description":"Meio Campo Avan\u00e7ado (Lado Esquerdo)","id":"4f4c334ae1af8008c800006e","x_max":2,"x_min":2,"y_max":1,"y_min":0},{"code":"MAD","description":"Meio Campo Avan\u00e7ado (Lado Direito)","id":"4f4c334ae1af8008c800006f","x_max":2,"x_min":2,"y_max":4,"y_min":3},{"code":"MC","description":"Meio Campo (Centro)","id":"4f4c334ae1af8008c8000070","x_max":3,"x_min":3,"y_max":2,"y_min":2},{"code":"ME","description":"Meio Campo (Lado Esquerdo)","id":"4f4c334ae1af8008c8000071","x_max":3,"x_min":3,"y_max":1,"y_min":0},{"code":"MD","description":"Meio Campo (Lado Direito)","id":"4f4c334ae1af8008c8000072","x_max":3,"x_min":3,"y_max":4,"y_min":3},{"code":"MDC","description":"Meio Campo Defensivo (Centro)","id":"4f4c334ae1af8008c8000073","x_max":5,"x_min":4,"y_max":2,"y_min":2},{"code":"MDE","description":"Meio Campo Defensivo (Lado Esquerdo)","id":"4f4c334ae1af8008c8000074","x_max":4,"x_min":4,"y_max":1,"y_min":0},{"code":"MDD","description":"Meio Campo Defensivo (Lado Direito)","id":"4f4c334ae1af8008c8000075","x_max":4,"x_min":4,"y_max":4,"y_min":3},{"code":"DC","description":"Defesa (Centro)","id":"4f4c334ae1af8008c8000076","x_max":7,"x_min":6,"y_max":3,"y_min":1},{"code":"DE","description":"Defesa (Lado Esquerdo)","id":"4f4c334ae1af8008c8000077","x_max":7,"x_min":5,"y_max":0,"y_min":0},{"code":"DD","description":"Defesa (Lado Direito)","id":"4f4c334ae1af8008c8000078","x_max":7,"x_min":5,"y_max":4,"y_min":4},{"code":"G","description":"Goleiro","id":"4f4c334ae1af8008c8000079","x_max":-1,"x_min":-1,"y_max":-1,"y_min":-1}]'
    parsed_json = JSON.load(json)
    parsed_json.each do |root| 
      PositionMapper.create! root
    end
  end
  
  def init_all_players(team)
    json = '[{"player":{"enabled":false,"id":"4f04e6c3e1af80017c00008c","name":"Marcelo Lomba","number":31,"position_mapper_id":"4f4c334ae1af8008c8000079","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25c920e1af800323000879","name":"Omar","number":12,"position_mapper_id":"4f4c334ae1af8008c8000079","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25ca2de1af800323000896","name":"Madson","number":34,"position_mapper_id":"4f4c334ae1af8008c8000078","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f2fd106b3e30f0001000613","name":"Coelho","number":42,"position_mapper_id":"4f4c334ae1af8008c8000078","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f26088ce1af8009550001dd","name":"\u00c1vine","number":6,"position_mapper_id":"4f4c334ae1af8008c8000077","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25ca54e1af8003230008b5","name":"William Matheus","number":50,"position_mapper_id":"4f4c334ae1af8008c8000077","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f2ef9a6e1af800c0400082b","name":"Guti\u00e9rrez","number":3,"position_mapper_id":"4f4c334ae1af8008c8000077","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f04e6dde1af80017c0000c4","name":"Titi","number":22,"position_mapper_id":"4f4c334ae1af8008c8000076","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25ca68e1af8003230008d6","name":"Danny Morais","number":14,"position_mapper_id":"4f4c334ae1af8008c8000076","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25ca81e1af8003230008f9","name":"Diego Jussani","number":33,"position_mapper_id":"4f4c334ae1af8008c8000076","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25cb42e1af80032300091e","name":"Dudu","number":13,"position_mapper_id":"4f4c334ae1af8008c8000076","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f2efa0ae1af800c040009c4","name":"Rafael Donato","number":32,"position_mapper_id":"4f4c334ae1af8008c8000076","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f04e69be1af80017c000047","name":"Fahel","number":7,"position_mapper_id":"4f4c334ae1af8008c8000073","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25cc85e1af8003230009be","name":"Lenine","number":15,"position_mapper_id":"4f4c334ae1af8008c8000073","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f04e6b5e1af80017c000073","name":"Fabinho","number":55,"position_mapper_id":"4f4c334ae1af8008c8000073","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25cd32e1af800323000a51","name":"Filipe","number":16,"position_mapper_id":"4f4c334ae1af8008c8000070","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f04e6abe1af80017c00005c","name":"H\u00e9lder","number":8,"position_mapper_id":"4f4c334ae1af8008c8000070","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25cc9ae1af8003230009e7","name":"Diones","number":17,"position_mapper_id":"4f4c334ae1af8008c8000073","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f04e68ee1af80017c000034","name":"Morais","number":10,"position_mapper_id":"4f4c334ae1af8008c8000070","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25cd6ce1af800323000a7e","name":"F\u00e1bio","number":20,"position_mapper_id":"4f4c334ae1af8008c8000070","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25cd83e1af800323000aad","name":"Vander","number":18,"position_mapper_id":"4f4c334ae1af8008c8000070","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f25cd94e1af800323000ade","name":"Z\u00e9 Roberto","number":11,"position_mapper_id":"4f4c334ae1af8008c800006e","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f04e6d3e1af80017c0000a7","name":"Gabriel","number":8,"position_mapper_id":"4f4c334ae1af8008c800006f","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f03baa6e1af8003ee00000f","name":"Lulinha","number":77,"position_mapper_id":"4f4c334ae1af8008c800006d","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f2fd315b3e30f0001000a07","name":"Magno","number":26,"position_mapper_id":"4f4c334ae1af8008c800006d","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f03b5b6e1af8003be000026","name":"Souza","number":9,"position_mapper_id":"4f4c334ae1af8008c800006a","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f25cdcbe1af800323000b46","name":"J\u00fanior","number":99,"position_mapper_id":"4f4c334ae1af8008c800006a","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f2fd07db3e30f000100041b","name":"Ciro","number":19,"position_mapper_id":"4f4c334ae1af8008c800006a","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f4c3d5b5ce3360003003395","name":"Jones Carioca","number":98,"position_mapper_id":"4f4c334ae1af8008c800006a","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":false,"id":"4f4c3bf65ce33600030006eb","name":"J\u00e9ferson","number":8,"position_mapper_id":"4f4c334ae1af8008c8000071","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f4d9cd2d37b5a00030011f4","name":"Renan","number":1,"position_mapper_id":"4f4c334ae1af8008c8000079","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f4d9cf7d37b5a0003001924","name":"Bruno","number":1,"position_mapper_id":"4f4c334ae1af8008c8000079","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f4d9d40d37b5a000300208e","name":"Rafael","number":7,"position_mapper_id":"4f4c334ae1af8008c800006a","team_id":"4f2c332ee1af8002b4000001"}},{"player":{"enabled":true,"id":"4f4d9dd3d37b5a00030033be","name":"Paulinho","number":8,"position_mapper_id":"4f4c334ae1af8008c8000070","team_id":"4f2c332ee1af8002b4000001"}}]'
    parsed_json = JSON.load(json)
    parsed_json.each do |root| 
      root["player"]["team"] = team
      Player.create! root["player"]
    end
  end
  
end

describe Scorer do
  include FormationHelpers

  let(:admin_user) { Factory(:user) }
  let(:user_t1) { Factory(:user_t1) }
  let(:user_t2) { Factory(:user_t2) }
  let(:user_t3) { Factory(:user_t3) }

  before(:each) do      
    bahia = Factory(:bahia)
    vitoria = Factory(:vitoria)
    init_last_match(bahia, vitoria)
    init_next_match(bahia, vitoria)
    init_positions
    init_all_players(bahia)
    
    json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'          
    @formation_442_by_t1 = Formation.create_from(
                                                  data: JSON.load(json), 
                                                  owner: user_t1, 
                                                  match: Calendar.last_match)
    
    json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f25cc9ae1af8003230009e7"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "5"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "5"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25ca68e1af8003230008d6"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '
    @formation_442_by_t2 = Formation.create_from(
                                                  data: JSON.load(json), 
                                                  owner: user_t2, 
                                                  match: Calendar.last_match)
    
    json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "1"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f25cd83e1af800323000aad"         ,          "x": "3"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "3"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "6"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25ca68e1af8003230008d6"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '
    @formation_343_by_t3 = Formation.create_from(
                                                  data: JSON.load(json), 
                                                  owner: user_t3, 
                                                  match: Calendar.last_match)
                                                  
    json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "1"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f25cd83e1af800323000aad"         ,          "x": "3"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "3"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "6"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25ca68e1af8003230008d6"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '
    @formation_343_by_t1 = Formation.create_from(
                                                  data: JSON.load(json), 
                                                  owner: user_t1, 
                                                  match: Calendar.last_match)
                                                  
    json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f25cc9ae1af8003230009e7"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "5"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "5"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25ca68e1af8003230008d6"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '
    @formation_442_by_t3 = Formation.create_from(
                                                  data: JSON.load(json), 
                                                  owner: user_t3, 
                                                  match: Calendar.last_match)
  end
  
  context "scoring players" do
    it "should elect the most votes tactical formation by matches" do
      Calendar.last_match.tactical_most_voted.should == '4-4-2'
    end
    
    xit "should elect the most votes players positions by formations of matches"
  end
end
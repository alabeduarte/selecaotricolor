require "test_helper"

class PlayerFormationPositionTest < ActiveSupport::TestCase

  require 'json'
  
  def setup
    @json_442 = "[{\"formation\":{\"player\":\"9\", \"x\":\"0\", \"y\":\"2\"}},
    {\"formation\":{\"player\":\"11\", \"x\":\"1\", \"y\":\"1\"}},
    {\"formation\":{\"player\":\"7\", \"x\":\"2\", \"y\":\"3\"}},
    {\"formation\":{\"player\":\"10\", \"x\":\"3\", \"y\":\"2\"}},
    {\"formation\":{\"player\":\"8\", \"x\":\"4\", \"y\":\"1\"}},
    {\"formation\":{\"player\":\"5\", \"x\":\"4\", \"y\":\"3\"}},
    {\"formation\":{\"player\":\"6\", \"x\":\"5\", \"y\":\"0\"}},
    {\"formation\":{\"player\":\"2\", \"x\":\"5\", \"y\":\"4\"}},
    {\"formation\":{\"player\":\"4\", \"x\":\"6\", \"y\":\"1\"}},
    {\"formation\":{\"player\":\"3\", \"x\":\"6\", \"y\":\"3\"}},
    {\"formation\":{\"player\":\"1\", \"x\":\"-1\", \"y\":\"-1\"}}]"
  end
  
  test "should obtain json from active record" do
    formations = Array.new
    
    some_player_position_a = PlayerFormationPosition.new :player => Player.find(1), :x => 0, :y => 0
    some_player_position_b = PlayerFormationPosition.new :player => Player.find(2), :x => 1, :y => 0
    some_player_position_c = PlayerFormationPosition.new :player => Player.find(3), :x => 1, :y => 2
    
    formations << some_player_position_a
    formations << some_player_position_b
    formations << some_player_position_c
    
    assert_equal 3, formations.length
  end
  
  test "should obtain record to json" do
    json = "[{\"formation\":{\"player\":1,\"x\":0,\"y\":0}},{\"formation\":{\"player\":2,\"x\":1,\"y\":0}},{\"formation\":{\"player\":3,\"x\":1,\"y\":2}}]"
    formations = JSON.load(json)
    assert_equal 3, formations.length
  end
  
  test "should obtain record from json 4-4-2" do
    parsed_json = JSON.load(@json_442)
    assert_equal 11, parsed_json.length
    
    create_players
    assert_equal 11, Player.all.size
    
    assert_not_nil Player.find_by_number(1)
    assert_not_nil Player.find_by_number(2)
    assert_not_nil Player.find_by_number(3)
    assert_not_nil Player.find_by_number(4)
    assert_not_nil Player.find_by_number(5)
    assert_not_nil Player.find_by_number(6)
    assert_not_nil Player.find_by_number(7)
    assert_not_nil Player.find_by_number(8)
    assert_not_nil Player.find_by_number(9)
    assert_not_nil Player.find_by_number(10)
    assert_not_nil Player.find_by_number(11)
    
    parsed_json.each do |item|
      player_value = item["formation"]["player"]
      x_value = item["formation"]["x"]
      y_value = item["formation"]["y"]
      
      assert_not_nil player_value
      assert_not_nil x_value
      assert_not_nil y_value
      
      assert_not_nil Player.find_by_number(player_value.to_i)
    end
    
    formation = Formation.create_from parsed_json
    players_positions = formation.players_positions
    
    assert_not_nil players_positions[0]
    assert_not_nil players_positions[0].x
    assert_not_nil players_positions[0].y
    assert_not_nil players_positions[0].player
    
    assert_equal 9, players_positions[0].player.number
    assert_equal 0, players_positions[0].x
    assert_equal 2, players_positions[0].y
    
    assert_equal players_positions.length, parsed_json.length
    assert_equal 11, players_positions.length
  end
  
  test "should obtain record from json 4-4-2 and save all" do
    parsed_json = JSON.load(@json_442)
    assert_equal 11, parsed_json.length
    
    formation = Formation.create_from parsed_json
    assert formation.save
    formation.players_positions.each do |player_position_formation|
      assert player_position_formation.save
    end
  end
  
  test "should obtain record from database and retrieve 11 players on squad" do
    create_formation
    assert_not_nil @formation
    some_formation = Formation.find(@formation.id)
    assert_not_nil some_formation
    assert_equal 11, some_formation.players_positions.length
  end
  
  def teardown
    PlayerFormationPosition.delete_all
    Formation.delete_all
    Player.delete_all
    Team.delete_all
  end
  
  private
  
  def create_players
    players = Array.new
    players << Player.new(:number => 1, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 2, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 3, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 4, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 5, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 6, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 7, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 8, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 9, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 10, :name => 'Some Player', :team => Team.new)
    players << Player.new(:number => 11, :name => 'Some Player', :team => Team.new)
    players.each do |p|
      p.save!
    end
  end
  
  def create_formation
    parsed_json = JSON.load(@json_442)
    @formation = Formation.create_from parsed_json
    @formation.save
  end
  
end

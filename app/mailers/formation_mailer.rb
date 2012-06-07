class FormationMailer < ActionMailer::Base
  default from: "contato@selecaotricolor.com.br"
  
  def formation_sent(formation)
    @user = formation.owner
    @formation = formation
    mail(:to => "alabeduarte@gmail.com", :subject => "#{t(:formation_sent)} -> #{@user.nickname}")
  end
  
  def player_has_been_assessed(player)
    @player = player
    mail(:to => "alabeduarte@gmail.com", :subject => "O jogador #{player.name} foi avaliado")
  end
end

require "spec_helper"
describe FormationMailer do
  describe 'formation sent notification' do
    let(:admin){ mock_model(User, :nickname => 'me', :email => 'alabeduarte@gmail.com') }
    let(:user) { mock_model(User, :nickname => 'John', :email => 'john@email.com') }
    let(:formation) { mock_model(Formation, :id => "1")}
    let(:mail) { FormationMailer.formation_sent(formation) }
    
    before do
      formation.stub(:owner).and_return(user)
    end
    
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == "#{I18n.t(:formation_sent)} -> #{user.nickname}"
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [admin.email]
    end

    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ['contato@selecaotricolor.com.br']
    end

    #ensure that the @nickname variable appears in the email body
    it 'assigns @nickname' do
      mail.body.encoded.should match(user.nickname)
    end

    #ensure that the @formation_url variable appears in the email body
    it 'assigns @formation_url' do
      mail.body.encoded.should match("<p>#{formation.id}</p>")
    end
  end
  
  describe 'formation sent notification' do
    let(:admin){ mock_model(User, :nickname => 'me', :email => 'alabeduarte@gmail.com') }
    let(:player) { mock_model(Player, :name => 'Some Player') }
    let(:mail) { FormationMailer.player_has_been_assessed(player) }
    
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == "O jogador #{player.name} foi avaliado"
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [admin.email]
    end

    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ['contato@selecaotricolor.com.br']
    end

    #ensure that the @player variable appears in the email body
    it 'assigns @player' do
      mail.body.encoded.should match("<p>#{player.name} acabou de ser avaliado</p>")
    end
  end
end
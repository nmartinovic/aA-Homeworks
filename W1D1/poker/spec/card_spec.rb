require 'card'
require 'deck'
require 'hand'
require 'player'

describe Card do
    subject(:card) { Card.new(2,:H, 2) }

    describe '#initialize' do
        it 'initiazlizes a new card' do
            expect(card).to be_an_instance_of(Card)
        end

        it 'sets the initial suit' do
            expect(card.suit).to eql(:H)
        end

        it 'sets the initial value' do
            expect(card.value).to eql(2)
        end
    end
end

describe Deck do
    subject(:deck) { Deck.new }

    describe '#initialize' do
        it 'creates a new deck' do
            expect(deck).to be_an_instance_of(Deck)
        end

        it 'creates a deck of length 52' do
            expect(deck.deck.length).to eql(52)
        end

        it 'shuffles the deck' do
            expect(deck[0].value).not_to equal(2)
        end
    end

    describe '#deal_one' do
        it 'returns a card' do
            expect(deck.deal_one).to be_an_instance_of(Card)
        end

        it 'removes the card from the deck' do
            deck.deal_one
            expect(deck.deck.length).to eql(51)
        end
    end
end


describe Hand do
    subject(:hand) {Hand.new}
    subject(:hand1) {Hand.new}
    subject(:hand2) {Hand.new}
    subject(:hand3) {Hand.new}





    describe '#initialize' do
        it 'creates an empty hand' do
            expect(hand.hand.empty?).to eql(true)
        end
    end


    describe '#add_card_to_hand' do
            let(:card1) {double("Card",:value => 2, :suit => :H)}
            let(:card2) {double("Card",:value => 3, :suit => :H)}
            let(:card3) {double("Card",:value => 4, :suit => :H)}
            let(:card4) {double("Card",:value => 5, :suit => :H)}
            let(:card5) {double("Card",:value => 6, :suit => :H)}
            it 'adds cards to hand' do
                hand.add_card_to_hand(card1)
                hand.add_card_to_hand(card2)
                hand.add_card_to_hand(card3)
                hand.add_card_to_hand(card4)
                hand.add_card_to_hand(card5)
                expect(hand.hand.length).to eql(5)
                expect(hand[0].value).to eql(2)
            end
    end

    describe '#hand_value' do
        let(:card6) {double("Card",:value => 14, :suit => :H)}
        let(:card7) {double("Card",:value => 10, :suit => :H)}
        let(:card8) {double("Card",:value => 11, :suit => :H)}
        let(:card9) {double("Card",:value => 12, :suit => :H)}
        let(:card10) {double("Card",:value => 13, :suit => :H)}
        it 'determines the value of a hand (straight flush)' do
            hand.add_card_to_hand(card6)
            hand.add_card_to_hand(card7)
            hand.add_card_to_hand(card8)
            hand.add_card_to_hand(card9)
            hand.add_card_to_hand(card10)
            expect(hand.hand_value).to eql(8000)
        end

        let(:card1) {double("Card",:value => 2, :suit => :H)}
        let(:card2) {double("Card",:value => 3, :suit => :C)}
        let(:card3) {double("Card",:value => 4, :suit => :H)}
        let(:card4) {double("Card",:value => 5, :suit => :H)}
        let(:card5) {double("Card",:value => 14, :suit => :H)}
        it 'determines the value of a hand (straight)' do
            hand1.add_card_to_hand(card1)
            hand1.add_card_to_hand(card2)
            hand1.add_card_to_hand(card3)
            hand1.add_card_to_hand(card4)
            hand1.add_card_to_hand(card5)
            expect(hand1.hand_value).to eql(4000)
        end

        let(:card11) {double("Card",:value => 2, :suit => :H)}
        let(:card12) {double("Card",:value => 3, :suit => :C)}
        let(:card13) {double("Card",:value => 6, :suit => :H)}
        let(:card14) {double("Card",:value => 5, :suit => :H)}
        let(:card15) {double("Card",:value => 14, :suit => :H)}
        it 'determines the value of a hand (high_card)' do
            hand2.add_card_to_hand(card11)
            hand2.add_card_to_hand(card12)
            hand2.add_card_to_hand(card13)
            hand2.add_card_to_hand(card14)
            hand2.add_card_to_hand(card15)
            expect(hand2.hand_value).to eql(14)
        end


    end

    describe '#flush?' do
        let(:card1) {double("Card",:value => 2, :suit => :H)}
        let(:card2) {double("Card",:value => 2, :suit => :H)}
        let(:card3) {double("Card",:value => 2, :suit => :H)}
        let(:card4) {double("Card",:value => 2, :suit => :H)}
        let(:card5) {double("Card",:value => 5, :suit => :H)}
        it 'determines if a hand is a flush or not' do
            hand.add_card_to_hand(card1)
            hand.add_card_to_hand(card2)
            hand.add_card_to_hand(card3)
            hand.add_card_to_hand(card4)
            hand.add_card_to_hand(card5)
            expect(hand.flush?).to eql(true)
        end
    end

    describe '#straight?' do
        let(:card1) {double("Card",:value=>2,:suit=>:H)}
        let(:card2) {double("Card",:value=>3,:suit=>:H)}
        let(:card3) {double("Card",:value=>4,:suit=>:H)}
        let(:card4) {double("Card",:value=>5,:suit=>:H)}
        let(:card5) {double("Card",:value=>14,:suit=>:H)}
        it 'determines if a hand is a straight or not' do
            hand.add_card_to_hand(card1)
            hand.add_card_to_hand(card2)
            hand.add_card_to_hand(card3)
            hand.add_card_to_hand(card4)
            hand.add_card_to_hand(card5)
            expect(hand.straight?).to eql(true)
        end
    end

    describe '#high_to_low' do
        let(:card1) {double("Card",:value=> 2,:suit=>:H)}
        let(:card2) {double("Card",:value=> 3,:suit=>:H)}
        let(:card3) {double("Card",:value=> 4,:suit=>:H)}
        let(:card4) {double("Card",:value=> 5,:suit=>:H)}
        let(:card5) {double("Card",:value=> 6,:suit=>:H)}
        it 'takes a hand and sorts it from high to low based on card value' do
            hand.add_card_to_hand(card1)
            hand.add_card_to_hand(card2)
            hand.add_card_to_hand(card3)
            hand.add_card_to_hand(card4)
            hand.add_card_to_hand(card5)
            hand.high_to_low
            expect(hand[0].value).to be >= hand[1].value
            expect(hand[1].value).to be >= hand[2].value
            expect(hand[2].value).to be >= hand[3].value
            expect(hand[3].value).to be >= hand[4].value
        end
    end

    describe '#hand_winner?' do
        let(:card6) {double("Card",:value => 14, :suit => :H)}
        let(:card7) {double("Card",:value => 10, :suit => :H)}
        let(:card8) {double("Card",:value => 11, :suit => :H)}
        let(:card9) {double("Card",:value => 12, :suit => :H)}
        let(:card10) {double("Card",:value => 13, :suit => :H)}
        let(:card1) {double("Card",:value => 2, :suit => :H)}
        let(:card2) {double("Card",:value => 3, :suit => :C)}
        let(:card3) {double("Card",:value => 4, :suit => :H)}
        let(:card4) {double("Card",:value => 5, :suit => :H)}
        let(:card5) {double("Card",:value => 14, :suit => :H)}

        let(:card21) {double("Card",:value => 7, :suit => :H)}
        let(:card22) {double("Card",:value => 8, :suit => :H)}
        let(:card23) {double("Card",:value => 9, :suit => :H)}
        let(:card24) {double("Card",:value => 10, :suit => :H)}
        let(:card25) {double("Card",:value => 11, :suit => :H)}

        let(:card26) {double("Card",:value => 6, :suit => :C)}
        let(:card27) {double("Card",:value => 3, :suit => :C)}
        let(:card28) {double("Card",:value => 4, :suit => :C)}
        let(:card29) {double("Card",:value => 2, :suit => :C)}
        let(:card30) {double("Card",:value => 5, :suit => :C)}
        it 'takes a hand as input and compares it to the existing hand to find a winner' do
            hand1.add_card_to_hand(card1)
            hand1.add_card_to_hand(card2)
            hand1.add_card_to_hand(card3)
            hand1.add_card_to_hand(card4)
            hand1.add_card_to_hand(card5)
            hand.add_card_to_hand(card6)
            hand.add_card_to_hand(card7)
            hand.add_card_to_hand(card8)
            hand.add_card_to_hand(card9)
            hand.add_card_to_hand(card10)
            expect(hand.hand_winner?(hand1)).to eql(true)
        end

        it 'takes two matching hands and then compares from high card down' do
            hand2.add_card_to_hand(card21)
            hand2.add_card_to_hand(card22)
            hand2.add_card_to_hand(card23)
            hand2.add_card_to_hand(card24)
            hand2.add_card_to_hand(card25)
            hand3.add_card_to_hand(card26)
            hand3.add_card_to_hand(card27)
            hand3.add_card_to_hand(card28)
            hand3.add_card_to_hand(card29)
            hand3.add_card_to_hand(card30)
            expect(hand2.hand_winner?(hand3)).to eql(true)
        end
    end

end 


describe Player do
    subject(:nick) {Player.new('Nick',100,game1)}
    let(:hand1)  {double("Hand",:hand => [double("Card",:value=>2,:suit=>:H),double("Card",:value=>3,:suit=>:H),double("Card",:value=>4,:suit=>:H),double("Card",:value=>5,:suit=>:H),double("Card",:value=>6,:suit=>:H)])}
    let(:game1) {double("Game",:current_bet => 30)}

    describe '#initialize' do
        it 'takes a name and a pot' do
            expect(nick.name).to eql('Nick')
            expect(nick.pot).to eql(100)
            expect(nick.in_hand).to eql(true)
            expect(nick.hand)
        end
    end 

    describe '#render' do
        it 'displays the players hand' do
            nick.hand = hand1
            expect(nick.render).to eql("2H 3H 4H 5H 6H")
        end
    end

    describe '#discard_cards' do
        it 'removes the selected cards from the hand' do
            nick.hand = hand1
            allow(nick).to receive(:discard_input).and_return(3)
            nick.discard_cards
            expect(nick.render).to eql ("2H 3H 4H 6H")
        end
    
    end

    describe '#player_action' do
        it 'sets @in_hand to false when a player folds' do
            allow(nick).to receive(:input_action).and_return(['fold',0])
            nick.player_action
            expect(nick.in_hand).to eql(false)
        end

        it 'subtracts the games current bet from the user pot when they call' do
            allow(nick).to receive(:input_action).and_return(['call',30])
            nick.player_action
            expect(nick.pot).to eql(70)
        end
            
        it 'subracts the players current bet from the user pot when they raise' do
            allow(nick).to receive(:input_action).and_return(['raise',50])
            nick.player_action
            expect(nick.pot).to eql(50)
        end

    end

end


describe Game do
    subject(:game1) {Game.new(["Nick","Erin"])}


    describe '#initialize' do
        it 'sets a Deck' do
            expect(game1.deck).to be_an_instance_of(Deck)
        end

        it 'sets players' do
            expect(game1.players[0]).to be_an_instance_of(Player)
        end

        it 'sets pot to 0' do
            expect(game1.pot).to eql(0)
        end

        it 'sets current turn to 0' do
            expect(game1.current_turn).to eql(0)
        end
    end

    describe '#next_turn' do
        it 'increments the current turn by 1' do
            game1.next_turn
            expect(game1.current_turn).to eql(1)
        end

        it 'loops back around' do
            game1.next_turn
            game1.next_turn
            expect(game1.current_turn).to eql(0)
        end
    end
end

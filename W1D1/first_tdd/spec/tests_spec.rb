require 'tests'


describe 'my_uniq' do
    it 'accepts an array and returns the unique elements in the order in which they first appeared' do
        duped_array = [1,2,1,3,3]
        expect(my_uniq(duped_array)).to eql(duped_array.uniq)
    end
end

        
describe Array do
    describe '#two_sum' do
        it 'takes an array and returns pairs where numbers sum to 0' do
            expect([-1,0,2,-2,1].two_sum).to eql([[0,4],[2,3]])
        end

        it 'expects the smaller first elements to come first' do
            test_array = [-1,0,2,-2,1].two_sum
            expect(test_array[0][0]).to be < test_array[1][0]
        end

        it 'expects the smaller second element to come first' do
            test_array = [0,0,0].two_sum
            expect(test_array[0][1]).to be < test_array[1][1]

        end
    end
end

describe 'my_tranpose' do
    it 'transposes a 2d array' do
        test_array = [[0,1,2],[3,4,5],[6,7,8]]

        expect(my_tranpose(test_array)).to eql([[0,3,6],[1,4,7],[2,5,8]])
    end
end


describe 'stock_picker' do
    it 'finds the most profitable days' do
        price_array = [0,1,2,3,4,5]
        expect(stock_picker(price_array)).to eql([0,5])
    end

    it 'returns nil if there are no profitable days' do
        price_array = [5,4,3,2,1]
        expect(stock_picker(price_array)).to be_nil
    end 
end

describe Board do
    subject(:board) { Board.new() }
    describe '#initialize' do
        it 'sets up all rods, 1 full and 2 empty' do
            expect(board.r0).to eql([3,2,1])
            expect(board.r1).to eql([])
            expect(board.r2).to eql([])
        end
    end

    describe '#move_piece' do
        it 'checks that a piece can make a move' do
            board.move_piece(0,1)
            board.move_piece(1,0)
            expect(board.r1).to eql([])
            expect(board.r0).to eql([3,2,1])
        end

        it 'checks that a bigger piece cannot move on to a smaller piece' do
            board.move_piece(0,1)
            expect{board.move_piece(0,1)}.to raise_error('You cannot move a bigger disk on top of a smaller disk') 
        end
    end
end

describe Game do 
    subject(:game) {Game.new}
    let(:board) { Board.new }


    describe '#initialize' do
        it 'creates a new board object' do
            expect(game.game).to be_a(Board)
        end
    end

    describe '#render' do
        it 'should render the board' do
            expect(game.render).to eq('0: [3, 2, 1], 1: [], 2: []')
        end
    end

    describe 'won?' do
        context 'when the game is not won' do
            it 'returns false' do
                expect(game.won?).to eql(false)
            end
        end

        context 'when game is won' do
            it 'returns true' do
                game.move(0,1)
                game.move(0,2)
                game.move(1,2)
                game.move(0,1)
                game.move(2,0)
                game.move(2,1)
                game.move(0,1)
                expect(game.won?).to eql(true)
            end
        end
    end

    describe '#move' do
        it 'moves a piece' do
            game.move(0,1)
            game.move(0,2)
            expect(game.game.r0).to eql([3])
            expect(game.game.r1).to eql([1])
            expect(game.game.r2).to eql([2])
        end

        it 'does not make an invalid move' do
            game.move(0,1)
            expect{game.move(0,1)}.to raise_error("You cannot move a bigger disk on top of a smaller disk")
        end
    end

end





require_relative '00_tree_node.rb'
class KnightPathFinder

    attr_reader :considered_positions, :root_node
    attr_writer :considered_positions

    DELTAS = [
    [-2,-1],
    [-2,1],
    [-1,-2],
    [-1,2],
    [1,-2],
    [1,2],
    [2,-1],
    [2,1]
    ]

    def self.valid_moves(pos)
        array = DELTAS.map { |(dx,dy)| [pos[0] + dx, pos[1] +dy ] }
        array.select { |(ax,ay)|  (0...8).include?(ax) && (0...8).include?(ay)}
        
    end

    
    def initialize(array)
        @root_node = PolyTreeNode.new(array)
        @considered_positions = [array]
        build_move_tree
    end

    def new_move_positions(pos)
        new_positions = self.class.valid_moves(pos).select { |position| @considered_positions.include?(position) == false }
        @considered_positions += new_positions
        new_positions
    end

    def build_move_tree
        start_pos = @root_node.value
        queue = []
        new_move_positions(start_pos).each do |position|
            child = PolyTreeNode.new(position)
            child.parent = @root_node
            queue << child
        end

        while queue.empty? == false
            parent = queue.shift
            next_moves = new_move_positions(parent.value)
            next_moves.each do |pos|
                child = PolyTreeNode.new(pos)
                child.parent= parent
                queue << child
            end
        end

    end

    def find_path(end_pos)
        node = @root_node.dfs(end_pos)
        trace_path_back(node)
    end

    def trace_path_back(node)
        array = []
        node_to_check = node
        until node_to_check.parent == nil
            array << node_to_check.parent.value
            node_to_check = node_to_check.parent
        end
        array.reverse

    end
        

end

kpf = KnightPathFinder.new([0,0])
p kpf.find_path([7,6])
p kpf.find_path([7,7])
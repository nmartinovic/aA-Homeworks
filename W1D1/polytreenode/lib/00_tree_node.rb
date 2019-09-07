class PolyTreeNode

    attr_reader :parent, :children, :dfs
    attr_writer :parent, :children, :dfs

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def value
        @value
    end

    def parent=(value)
        if self.parent == nil
            @parent = value
            if value != nil
                @parent.children << self
            end
        else
            @parent.children.delete(self)
            @parent = value
            if value != nil
                parent.children << self
            end
        end
    end

    def add_child(child_node)
        if @children.include?(child_node) != true
            #@children << child_node
            child_node.parent = self
        end
    end

    def remove_child(child_node)
        if @children.include?(child_node) == true
            @children.delete(child_node)
            child_node.parent = nil
        else
            raise error
        end
    end

    def dfs(target_value)
        return self if target_value == self.value
        @children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result == nil
        end
        nil
    end

    def bfs(target_value)
        queue = Array.new()
        queue << self
        until queue.empty?
            check = queue.shift
            if check.value == target_value
                return check
            else
                queue += check.children
            end
        end
        nil
    end

end
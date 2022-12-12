require 'dxruby'

Window.width=1024
Window.height=768

NODE_MAX_NUM = 29
ROOT_X = (Window.width-200)/2
ROOT_Y = Window.height/2
MAX_DEPTH = 3

class SkillTree 
    class Node
        def initialize(node_num,parent,effected_status,effect_value,need_money,x,y)
            @node_num = node_num
            @parent = parent
            @children = []
            @effected_status = effected_status
            @effect_value = effect_value
            @need_money = need_money
            @release_flag = 0
            @x=x
            @y=y
        end
        attr_accessor :node_num, :parent, :children, :effected_status, :effect_value, :need_money, :release_flag, :x, :y
    end

    def initialize
        #[影響を与えるステータス,変化値,必要なゴールド,x座標,y座標]
        @tree_nodes = [
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,100,1],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y],
               ["hp",1,150,ROOT_X,ROOT_Y]
            ]
        @root = nil
        @count = 0
    end
    attr_accessor :root

    def init(node=nil,depth=0,parent=nil)
        if depth > MAX_DEPTH || @tree_nodes[@count] == nil
            return nil
        end
        
        node = Node.new(@count,parent,@tree_nodes[@count][0],@tree_nodes[@count][1],@tree_nodes[@count][2],@tree_nodes[@count][3],@tree_nodes[@count][4])
        puts @count,node,node.parent

        if depth == 0
            child_num = 4;
        else
            child_num = 2;
        end
        
        if depth < MAX_DEPTH
            child_num.times do |i|
                @count+=1
                node.children[i]=init(node.children,depth+1,node)
            end
        end
        
        if depth==0
            @root=node
        end
        
        puts node.children[0]

        return node
    end

    def show(node)
        puts "#{node.node_num},#{node.effected_status},#{node.effect_value},#{node.need_money}ゴールド"
        4.times do |i|
            if node.children[i]==nil
                break 
            end
            show(node.children[i])
           
        end
    end

    def get_node(n,node=@root)
        if n>=NODE_MAX_NUM
            return -1
        end
        if node.node_num == n
            return node
        end
         
    
        node.children.each_index do |i|
            return_node = get_node(n,node.children[i])
            if return_node.node_num == n 
                return return_node
            end
        end
    end

    def open_node(n)
        node=get_node(n)
        node.release_flag = 1
    end
end 

tree = SkillTree.new()
tree.init
#tree.show(tree.root)
#tree.open_node(3)
#node=tree.get_node(3)
#puts "#{node.node_num},#{node.x},#{node.y},#{node.release_flag}"
Window.loop do
    Window.draw_box_fill(800, 0, 1023, 767, C_WHITE, z=1)
end
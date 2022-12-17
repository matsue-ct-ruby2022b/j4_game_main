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
        #スキルツリーのノード[影響を与えるステータス,変化値,必要なゴールド,x座標,y座標]
        @tree_nodes = [
               ["root",0,0,ROOT_X,ROOT_Y],#0

               ["hp",20,100,ROOT_X-100,ROOT_Y-100],#1
               ["hp",50,200,ROOT_X-100,ROOT_Y-200],#2
               ["hp",120,500,ROOT_X-100,ROOT_Y-300],#3
               ["hp",150,700,ROOT_X-200,ROOT_Y-300],#4
               ["mp",30,150,ROOT_X-200,ROOT_Y-100],#5
               ["mp",70,300,ROOT_X-300,ROOT_Y-200],#6
               ["mp",200,700,ROOT_X-300,ROOT_Y-100],#7

               ["pow",10,100,ROOT_X+100,ROOT_Y-100],#8
               ["pow",30,200,ROOT_X+100,ROOT_Y-200],#9
               ["pow",70,300,ROOT_X+100,ROOT_Y-300],#10
               ["pow",100,500,ROOT_X+200,ROOT_Y-300],#11
               ["bra",30,200,ROOT_X+200,ROOT_Y-100],#12
               ["bra",70,300,ROOT_X+300,ROOT_Y-100],#13
               ["bra",100,500,ROOT_X+300,ROOT_Y-200],#14

               ["def",10,100,ROOT_X-100,ROOT_Y+100],#15
               ["def",30,150,ROOT_X-200,ROOT_Y+100],#16
               ["def",60,300,ROOT_X-300,ROOT_Y+100],#17
               ["def",100,700,ROOT_X-300,ROOT_Y+200],#18
               ["pow",20,150,ROOT_X-100,ROOT_Y+200],#19
               ["pow",50,200,ROOT_X-100,ROOT_Y+300],#20
               ["pow",50,200,ROOT_X-200,ROOT_Y+300],#21

               ["spe",10,100,ROOT_X+100,ROOT_Y+100],#22
               ["spe",20,150,ROOT_X+200,ROOT_Y+100],#23
               ["spe",100,350,ROOT_X+300,ROOT_Y+100],#24
               ["spe",200,700,ROOT_X+300,ROOT_Y+200],#25
               ["def",10,150,ROOT_X+100,ROOT_Y+200],#26
               ["def",30,150,ROOT_X+100,ROOT_Y+300],#27
               ["def",60,300,ROOT_X+200,ROOT_Y+300]#28
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
        if node.node_num == n #rootノードだったら
            return node
        end
         
    
        node.children.each_index do |i|
            return_node = get_node(n,node.children[i])
            if return_node.node_num == n 
                return return_node
            end
        end

        return node
    end

    def open_node(n)
        node=get_node(n)
        node.release_flag = 1
    end

    def detail_print(node) #選択されたノードを渡す
        detail_font = Font.new(20)
        ui_font = Font.new(32)
        coin_img = Image.load("images/money.png")

        
            x = Input.mouse_pos_x  # マウスカーソルのx座標
            y = Input.mouse_pos_y  # マウスカーソルのy座標
            detail_pos_y = 50 #説明文の1行目のy座標
            #Window.draw_font(100, 100, "x : #{x}, y : #{y}", detail_font)
            Window.draw_box_fill(800, 0, 1023, 767, C_WHITE, z=1)
            Window.draw_font(870, 700, "#{node.effected_status}", ui_font, color:C_BLACK, z:2)

            #debug用変数,Nodeクラスのメンバを用いる
            str1 = " HPが10増加します"
            str2 = " -500G"
            node_name = "HP+++"
            Window.draw_font(850, detail_pos_y, "「#{node.effected_status}」", Font.new(22), color:C_BLACK, z:2)
            Window.draw_font(810, detail_pos_y + 30, "効果:", detail_font, color:C_BLACK, z:2)
            Window.draw_font(810, detail_pos_y + 50, "#{str1}", detail_font, color:C_BLACK, z:2)
            Window.draw_font(810, detail_pos_y + 80, "金額:", detail_font, color:C_BLACK, z:2)
            Window.draw_font(810, detail_pos_y + 100, "#{str2}", detail_font, color:C_BLACK, z:2)
            #Window.draw_scale(890, 120, coin_img, 0.1, 0.1, z=5)

            if 860 <= x && x <= 950 && 640 <= y && y <= 680
                #コマンド選択画像
                Window.draw_box(860, 690, 950, 740, C_BLACK, z=4)
                if Input.mousePush?(M_LBUTTON)
                    #強化処理
                    #break
                end
            end
    end

    #マウスクリックされたら呼ばれる, ノード番号を返す
    def click_node(x,y)
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標

        NODE_MAX_NUM.times do |i|
            #マウスカーソルがノードi内にあるか
            if @tree_nodes[i][3] -15 < x && x < @tree_nodes[i][3] + 15
                if @tree_nodes[i][4] -15 < y && y < @tree_nodes[i][4] + 15
                    return i
                end
            end
        end
        return nil
    end

    def debug_print
        puts "tree_nodes[0][0] = #{@tree_nodes[0][0]}"
    end

end 

def my_draw_image(x,y,image)#中心座標で表示
    Window.draw(x-image.width/2,y-image.height/2,image)
end

tree = SkillTree.new()
tree.init
tree.show(tree.root)
#tree.open_node(3)
#node=tree.get_node(3)
#puts "#{node.node_num},#{node.x},#{node.y},#{node.release_flag}"
selected_node = NODE_MAX_NUM + 1 #初期化, nodeの最大値+1を持たせる
Window.loop do
    x=Input.mouse_pos_x
    y=Input.mouse_pos_y

    #表示関連
    Window.draw_box_fill(800, 0, 1023, 767, C_WHITE, z=1)
    Window.draw_font(850, 100, "「#{x},#{y}」", Font.new(22), color:C_BLACK, z:2)
    NODE_MAX_NUM.times do |i|
        node=tree.get_node(i)
        node.children.each do |child|
            #ノード間の線
            Window.draw_line(node.x,node.y,child.x,child.y,C_WHITE)
        end
        #ノード
        Window.draw_circle_fill(node.x,node.y,30,C_WHITE)
        #文字
        image=Image.new(50,50)
        image.draw_font(10,10,"#{node.effected_status}",Font.new(20),C_BLACK)
        my_draw_image(node.x,node.y,image)
    end

    if Input.mouse_push?(M_LBUTTON)
        selected_node = tree.click_node(x,y)
    end
    if(selected_node != NODE_MAX_NUM + 1) #selected_nodeの初期化時の数値以外だったた()
        Window.draw_font(870, 50, "#{selected_node}", Font.new(32), color:C_BLACK, z:2)
    end

end
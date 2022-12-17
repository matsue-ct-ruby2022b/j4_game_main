require 'dxruby'

Window.width=1024
Window.height=768



def my_draw_image(x,y,image)#中心座標で表示
    Window.draw(x-image.width/2,y-image.height/2,image)
end


class SkillTree 
    #スキルツリーの各ノード node.~~
    class Node
        def initialize(node_num,node_name,parent,effected_status,effect_value,need_money,x,y)
            @node_num = node_num
            @node_name = node_name
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
        @node_max_num = 29
        @root_x = (Window.width-200)/2
        @root_y = Window.height/2
        @max_depth = 3
        #スキルツリーのノード[ノードの名前,影響を与えるステータス,変化値,必要なゴールド,x座標,y座標]
        @tree_nodes = [
               ["root","root",0,0,@root_x,@root_y],#0

               ["HP+","hp",50,100,@root_x-100,@root_y-100],#1
               ["HP++","hp",100,200,@root_x-100,@root_y-200],#2
               ["HP+++","hp",150,500,@root_x-100,@root_y-300],#3
               ["HP++++","hp",300,1000,@root_x-200,@root_y-300],#4
               ["MP+","mp",30,150,@root_x-200,@root_y-100],#5
               ["MP++","mp",70,300,@root_x-300,@root_y-200],#6
               ["MP+++","mp",200,700,@root_x-300,@root_y-100],#7

               ["ちから+","pow",10,100,@root_x+100,@root_y-100],#8
               ["ちから++","pow",30,200,@root_x+100,@root_y-200],#9
               ["ちから+++","pow",70,300,@root_x+100,@root_y-300],#10
               ["ちから++++","pow",100,500,@root_x+200,@root_y-300],#11
               ["ずのう+","bra",30,200,@root_x+200,@root_y-100],#12
               ["ずのう++","bra",70,300,@root_x+300,@root_y-100],#13
               ["ずのう+++","bra",100,500,@root_x+300,@root_y-200],#14

               ["まもり+","def",10,100,@root_x-100,@root_y+100],#15
               ["まもり++","def",30,150,@root_x-200,@root_y+100],#16
               ["まもり+++","def",60,300,@root_x-300,@root_y+100],#17
               ["まもり++++","def",100,700,@root_x-300,@root_y+200],#18
               ["ちから+","pow",20,150,@root_x-100,@root_y+200],#19
               ["ちから++","pow",50,200,@root_x-100,@root_y+300],#20
               ["ちから++","pow",50,200,@root_x-200,@root_y+300],#21

               ["そくど+","spe",10,100,@root_x+100,@root_y+100],#22
               ["そくど++","spe",20,150,@root_x+200,@root_y+100],#23
               ["そくど+++","spe",100,350,@root_x+300,@root_y+100],#24
               ["そくど++++","spe",200,700,@root_x+300,@root_y+200],#25
               ["まもり+","def",10,150,@root_x+100,@root_y+200],#26
               ["まもり++","def",30,150,@root_x+100,@root_y+300],#27
               ["まもり+++","def",60,300,@root_x+200,@root_y+300]#28
            ]
        @root = nil
        @count = 0
        @node_icon={}
        @node_icon["root"] = Image.load("images/shield1.png")#ルートノード画像
        @node_icon["hp"] = Image.load("images/shield1.png")#HPノード画像
        @node_icon["mp"] = Image.load("images/shield2.png")#MPノード画像
        @node_icon["pow"] = Image.load("images/shield3.png")#POWERノード画像
        @node_icon["bra"] = Image.load("images/money.png")#BRAINノード画像
        @node_icon["def"] = Image.load("images/shield1.png")#DEFENCEノード画像
        @node_icon["spe"] = Image.load("images/shield1.png")#SPEEDノード画像
        @tree_back_img = Image.load("images/stone.jpg")
        
    end
    attr_accessor :root

    #skilltreeにtree_nodesを読み込む　最初に呼び出す
    #tree = SkillTree.new()
    #tree.init
    def init(node=nil,depth=0,parent=nil)
        if depth > @max_depth || @tree_nodes[@count] == nil
            return nil
        end
        
        node = Node.new(@count,@tree_nodes[@count][0],parent,@tree_nodes[@count][1],@tree_nodes[@count][2],@tree_nodes[@count][3],@tree_nodes[@count][4],@tree_nodes[@count][5])

        if depth == 0
            child_num = 4;
        else
            child_num = 2;
        end
        
        if depth < @max_depth
            child_num.times do |i|
                @count+=1
                node.children[i]=init(node.children,depth+1,node)
            end
        end
        
        if depth==0
            @root=node
        end

        return node
    end

    #debug用
    def show(node)
        puts "#{node.node_num},#{node.effected_status},#{node.effect_value},#{node.need_money}ゴールド"
        4.times do |i|
            if node.children[i]==nil
                break 
            end
            show(node.children[i])
           
        end
    end

    #引数のノード番号のノードが返ってくる
    #node = get_node(3)
    def get_node(n,node=@root)
        if n>=@node_max_num
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

        return node
    end

    #ノードを解放状態にする
    def open_node(n,hero)
        node=get_node(n)
        node.release_flag = 1
        if node.effected_status == "hp"
            hero.hp_max += node.effect_value
            hero.hp = hero.hp_max
        elsif node.effected_status == "mp"
            hero.mp_max += node.effect_value
            hero.mp = hero.mp_max
        elsif node.effected_status == "pow"
            hero.power += node.effect_value
            hero.origin_power += node.effect_value
        elsif node.effected_status == "bra"
            hero.brain += node.effect_value
        elsif node.effected_status == "def"
            hero.def += node.effect_value
            hero.origin_def = hero.def * 2
            hero.before_def += node.effect_value
        elsif node.effected_status == "spe"
            hero.speed += node.effect_value
        end
    end

    def select_circle
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標

    end

    def node_print
        node_font = Font.new(20)
        nodew=@node_icon["root"].width/2 #画像の高さの半分
        nodeh=@node_icon["root"].height/2 #画像の幅の半分
        for node_num in 0..28 do
            node = get_node(node_num)
            node.children.each_index do |i|
                if node.children[i].release_flag == 1 
                    line_color = C_WHITE
                else
                    line_color = [255,100,100,100] #未開放ノードへの線は暗く
                end
                Window.draw_line(node.x, node.y, node.children[i].x, node.children[i].y, line_color, z=1)
            end
            Window.draw_scale(node.x-nodew, node.y-nodeh, @node_icon[node.effected_status], 0.3, 0.3,nodew,nodeh, z=2)
            if node.children.empty?
                next
            end
        end
    end

    def detail_print
        detail_font = Font.new(20)
        ui_font = Font.new(32)
        coin_img = Image.load("images/money.png")

        Window.draw_morph(0,0,1024,0,1024,768,0,768,@tree_back_img,alpha:100)#背景描画

            x = Input.mouse_pos_x  # マウスカーソルのx座標
            y = Input.mouse_pos_y  # マウスカーソルのy座標
            detail_pos_y = 50 #説明文の1行目のy座標
            #Window.draw_font(100, 100, "x : #{x}, y : #{y}", detail_font)
            Window.draw_box_fill(800, 0, 1023, 767, C_WHITE, z=1)
            Window.draw_font(870, 700, "強 化", ui_font, color:C_BLACK, z:2)

            #debug用変数,Nodeクラスのメンバを用いる
            str1 = " HPが10増加します"
            str2 = " -500G"
            node_name = "HP+++"
            Window.draw_font(850, detail_pos_y, "「#{node_name}」", Font.new(22), color:C_BLACK, z:2)
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
end 

def skilltree_loop(tree,hero)
    Window.loop do
        tree.detail_print
        tree.node_print
        if Input.mouse_push?(M_LBUTTON)
            tree.open_node(4,hero)
            tree.open_node(7,hero)
            tree.open_node(11,hero)
            tree.open_node(14,hero)
            tree.open_node(18,hero)
            tree.open_node(25,hero)
            return
        end
    end
end

#tree = SkillTree.new()
#tree.init

=begin
Window.loop do
    tree.detail_print
    tree.node_print
end
=end

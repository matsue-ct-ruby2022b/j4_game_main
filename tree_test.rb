#1024x768
require 'dxruby'
Window.width = 1024
Window.height = 768
Window.x = 0
Window.y = 0
class Node
    attr_accessor :node_num, :parent, :child1, :child2, :child3, :child4, :status, :detail, :flag, :money, :x, :y, :node_icon[]
    def initialize
        @node_icon[0] = Image.load("images/shield1.png")
        @node_icon[1] = Image.load("images/shield2.png")
        @node_icon[2] = Image.load("images/shield3.png")
        @node_icon[3] = Image.load("images/money.png")
        @node_icon[4] = Image.load("images/shield1.png")
        @node_icon[5] = Image.load("images/shield2.png")
        @node_icon[6] = Image.load("images/shield3.png")
        @node_icon[7] = Image.load("images/money.png")
        @node_icon[8] = Image.load("images/shield1.png")
        @node_icon[9] = Image.load("images/shield2.png")
        @node_icon[10] = Image.load("images/shield3.png")
        @node_icon[11] = Image.load("images/money.png")
        @node_icon[12] = Image.load("images/shield1.png")
        @node_icon[13] = Image.load("images/shield2.png")
        @node_icon[14] = Image.load("images/shield3.png")
        @node_icon[15] = Image.load("images/money.png")
        @node_icon[16] = Image.load("images/shield1.png")
        @node_icon[17] = Image.load("images/shield2.png")
        @node_icon[18] = Image.load("images/shield3.png")
        @node_icon[19] = Image.load("images/money.png")
        @node_icon[20] = Image.load("images/shield1.png")
        @node_icon[21] = Image.load("images/shield2.png")
        @node_icon[22] = Image.load("images/shield3.png")
        @node_icon[23] = Image.load("images/money.png")
        @node_icon[24] = Image.load("images/shield1.png")
        @node_icon[25] = Image.load("images/shield2.png")
        @node_icon[26] = Image.load("images/shield3.png")
        @node_icon[27] = Image.load("images/money.png")
        @node_icon[28] = Image.load("images/shield1.png")
    end

    def select_circle
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標

    end

    def node_print
        node_font = Font.new(20)
        for node_num in 0..28 do
            node = get_node(node_num)
            Window.draw_scale(node.x+30, node.y+30, node_icon[node], 0.3, 0.3, z=2)
            if node.childeren[i].empty
                break
            end
            Window.draw_line(node.x, node.y, node.children.x, node.children.y, C_WHITE, z=1)
        end
    end

    def detail_print
        detail_font = Font.new(20)
        ui_font = Font.new(32)
        coin_img = Image.load("images/money.png")

        
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

node = Node.new

Window.loop do
    node.detail_print
    node.node_print
end


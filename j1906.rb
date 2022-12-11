
require 'dxruby'

#初期値
#画面サイズ
Window.width = 1024
Window.height = 768

TITLE=50
SIZE=20

#サポートキャラ
class Support_chara
    attr_accessor :name, :party, :love
    def initialize(key)
        @name=key  #キャラクター名
        @party=false    #パーティに入っているか(true:入っている,false:入っていない)
        @love=0     #好感度
    end
end

tanaka=Support_chara.new("tanaka")
suzuki=Support_chara.new("suzuki")

#時間
class Clock
    attr_accessor :now_day,:now_time,:date,:wake_up,:deadline,:hour,:minute
    def initialize
        @now_day=0
        @now_time=0
        @date=7
        @wake_up=540
        @deadline=720
        @hour=(wake_up*now_time)/60
        @minute=(wake_up+now_time)%60
    end
end

clock=Clock.new

#物語進行
class Story
    attr_accessor :scene_num,:page,:story_num
    def initialize
        @scene_num=0 #シナリオ番号
        @page=0      #ページ番号
        @story_num=0 #文章番号
    end
end

story=Story.new

###############################社長クラス########################################################################################################################################################################
#フィールド全体
class Field
    attr_accessor :enemy_level, :field_option, :turn, :status, :battle_speed, :crt_enemy, :next_enemy
    def initialize
      @field_option = 0
      @status = 0
      @battle_speed = 1 #等倍
      @crt_enemy = 0 #未定
      @next_enemy = 0 #未定
    end
    #ステージレベル登録
    def set_enemy_level(num)
      @enemy_level = num.to_i
    end
    #フィールド状態登録(フィールド全体毒、封印など)※重複しない
    def set_field_option(num)
      @field_option = num
    end
    #turnを1進める
    def turn_cnt(hero,enemy,field)
  
      #防御UPを解除
      if hero.is_def == true
        hero.def = hero.before_def
        hero.is_def = nil
      end
  
      #特殊状態解除
      if (hero.status == 1 && hero.limit_turn > 5) || (hero.status == 3 && hero.limit_turn >= 3)
        hero.status = 0
      end
  
      #聖導のまもり
      if hero.status == 2 && hero.limit_turn >= 5
        hero.status = 0
        hero.def -= $up_def.to_i
        hero.avoid = 10
      end
  
      #ラプソディ上昇倍率
      if hero.hero_type == 1 && hero.limit_turn < 10 #継続中
        up_power = hero.origin_power * (hero.limit_turn*0.1) + 1 # +10% -> +20% -> ... -> +90% -> +100%
        hero.power += up_power
        hero.power = hero.power.to_i
      elsif hero.hero_type == 1 && hero.limit_turn == 10 #終了(元のdef値を代入)
        hero.power = hero.origin_power
      end
  
      #迷い人の「ラプソディ」ターン減少
      hero.limit_turn += 1
  
      #ターンを進める
      @turn += 1
    end
    #戦闘開始
    def new_battle
      @turn = 1 #最初は1ターン目
    end
    #バトル表示(基本)
    def print_battle(hero,enemy,field)
      #文字
      font = Font.new(32) #MS明朝
      battle_font = Font.new(26)
      command_font = Font.new(28)
      print_font = Font.new(20)
      for_magic_font = Font.new(15)
      #ターン
      #Window.draw_font(10,10,"#{@turn} ターン目", font, color:[255,0,0,0])
      #左枠
      Window.draw_box_fill(131,  460, 311, 730, C_WHITE, z=1)
      Window.draw_box_fill(136,  465, 306, 725, C_BLACK, z=2)
      #右枠
      Window.draw_box_fill(321,  460, 891, 730, C_WHITE, z=1)
      Window.draw_box_fill(326,  465, 886, 725, C_BLACK, z=2)
      #文字表示
      Window.draw_font(177,485,"こうどう", battle_font, fontcolor:[255,255,255],z:3)
      Window.draw_font(172,545,"たたかう", command_font, fontcolor:[255,255,255],z:3)
      Window.draw_font(173,605,"ぼうぎょ", command_font, fontcolor:[255,255,255],z:3)
      Window.draw_font(183,665,"にげる",   command_font, fontcolor:[255,255,255],z:3)
      #キャラアイコン
      #女性キャラ1
      woman1_normal = Image.load("images/chara/woman1/face_normal.png")
      woman1_pinchi = Image.load("images/chara/woman1/face_pinchi.png")
      woman1_tere = Image.load("images/chara/woman1/face_tere.png")
      #女性キャラ2
      woman2_normal = Image.load("images/chara/woman2/face_normal.png")
      woman2_pinchi = Image.load("images/chara/woman2/face_pinchi.png")
      #女性キャラ3
      woman3_normal = Image.load("images/chara/woman3/face_normal.png")
      woman3_pinchi = Image.load("images/chara/woman3/face_pinchi.png")
      #男性キャラ1
      man1_normal = Image.load("images/chara/man1/face_normal.png")
      man1_pinchi = Image.load("images/chara/man1/face_pinchi.png")
      #男性キャラ2
      man2_normal = Image.load("images/chara/man2/face_normal.png")
      man2cls_pinchi = Image.load("images/chara/man2/face_pinchi.png")
      #男性キャラ3
      man3_normal = Image.load("images/chara/man3/face_normal.png")
      man3_pinchi = Image.load("images/chara/man3/face_pinchi.png")
      #敵
      enemy_goblin_face = Image.load("images/enemy_face/face_1.png")
      #商人
      merchant_img = Image.load("images/chara/merchant/face.png")
      #お金マーク
      money_img = Image.load("images/money.png")
      #レベル
      Window.draw_font(470,505,"Lv. #{hero.level}", print_font, color:[255,255,255,255],z:4)
      #バー色塗り
      tmp_max = hero.need_exp / 10
      for i in 1..10 #10分割
        if hero.exp >= (i * tmp_max)
          Window.draw_box_fill(535+(28 * (i-1)),  510, 535+(28 * (i-1))+28, 520, C_BLUE, z=4) #バー
        end
      end
      if hero.level != 99
        Window.draw_box_fill(530,  505, 820, 525, C_WHITE, z=4) #大枠
        #経験値計算
        #exp_calc(hero,enemy,field)      
        #バー色塗り
        tmp_max = hero.need_exp / 10
        for i in 1..10 #10分割
          if hero.exp >= (i * tmp_max)
            Window.draw_box_fill(535+(28 * (i-1)),  510, 535+(28 * (i-1))+28, 520, C_BLUE, z=4) #バー
          end
        end
      else #レベル最大時、Maxで表示
        Window.draw_box_fill(530,  505, 820, 525, C_WHITE, z=4) #大枠
        Window.draw_box_fill(535,  510, 815, 520, C_BLUE, z=4) #バー
      end
      #特性
      Window.draw_font(470,553,"特性 : ", print_font, color:[255,255,255,255],z:4)
      #キャラごとに場合分け
      if hero.hero_type == 0 #天使
        Window.draw(356,490,woman1_normal,z=4)
        Window.draw_font(378,610,"【天使】", for_magic_font, color:[255,255,255,255],z:4)
        Window.draw_font(530,553,"一定確率でターン開始時にHP回復", print_font, color:[255,255,255,255],z:4)
      elsif hero.hero_type == 1 #迷い人
        Window.draw(356,490,woman2_normal,z=4)
        Window.draw_font(370,610,"【迷い人】", for_magic_font, color:[255,255,255,255],z:4)
        Window.draw_font(530,553,"敵の攻撃を回避する確率が高い", print_font, color:[255,255,255,255],z:4)
      elsif hero.hero_type == 2 #魔法研究者
        Window.draw(356,490,woman3_normal,z=4)
        Window.draw_font(356,610,"【魔法研究者】", for_magic_font, color:[255,255,255,255],z:4)
        Window.draw_font(530,553,"MPと頭脳が高く、魔法攻撃の威力が高い", print_font, color:[255,255,255,255],z:4)
      elsif hero.hero_type == 3 #勇者
        Window.draw(356,490,man1_normal,z=4)
        Window.draw_font(376,610,"【勇者】", for_magic_font, color:[255,255,255,255],z:4)
        Window.draw_font(530,553,"攻撃が高く、クリティカル率が高い", print_font, color:[255,255,255,255],z:4)
      elsif hero.hero_type == 4 #信仰者
        Window.draw(356,490,man2_normal,z=4)
        Window.draw_font(370,610,"【信仰者】", for_magic_font, color:[255,255,255,255],z:4)
        Window.draw_font(530,553,"先制を取りやすく、お金の獲得量が多い", print_font, color:[255,255,255,255],z:4)
      elsif hero.hero_type == 5 #旅人
        Window.draw(356,490,man3_normal,z=4)
        Window.draw_font(378,610,"【旅人】", for_magic_font, color:[255,255,255,255],z:4)
        Window.draw_font(530,553,"取得する経験値が大幅に増加する", print_font, color:[255,255,255,255],z:4)
      end 
      #能力表示
      #ピンチなら
      if hero.hp_max * 0.2 >= hero.hp
        Window.draw_font(490,601,"HP : #{hero.hp} / #{hero.hp_max}", print_font, color:[255,255,0,0],z:4)
      else
        Window.draw_font(490,601,"HP : #{hero.hp} / #{hero.hp_max}", print_font, color:[255,255,255,255],z:4)
      end
      Window.draw_font(670,601,"MP : #{hero.mp} / #{hero.mp_max}", print_font, color:[255,255,255,255],z:4)
      #迷い人がラプソディを使っていなければ
      if hero.origin_power == hero.power
        Window.draw_font(475,641,"ちから :  #{hero.power}", print_font, color:[255,255,255,255],z:4)
      else
        Window.draw_font(475,641,"ちから :  #{hero.power}", print_font, color:[255,255,255,0],z:4)
      end
      Window.draw_font(605,641,"ずのう :  #{hero.brain}", print_font, color:[255,255,255,255],z:4)
      #まもりが2倍になっていなければ
      if (hero.origin_def == hero.def) || hero.status == 2
        Window.draw_font(745,641,"まもり :  #{hero.def}", print_font, color:[255,255,255,0],z:4)
      else
        Window.draw_font(745,641,"まもり :  #{hero.def}", print_font, color:[255,255,255,255],z:4)
      end
      if hero.status != 2
        Window.draw_font(474,681,"かいひ :  #{hero.avoid}", print_font, color:[255,255,255,255],z:4)
      elsif hero.status == 2
        Window.draw_font(474,681,"かいひ :  #{hero.avoid}", print_font, color:[255,255,255,0],z:4)
      end
      Window.draw_font(607,681,"そくど :  #{hero.speed}", print_font, color:[255,255,255,255],z:4)
      Window.draw_font(740,681,"かいしん :  #{hero.cri}", print_font, color:[255,255,255,255],z:4)
      #状態
      if (hero.origin_power != hero.power) && field.status != 1 && hero.hero_type == 1 #ラプソディ
        Window.draw_font(490,476,"ラプソディ : 残#{11-hero.limit_turn}ターン", print_font, color:[255,255,255,255],z:17)
      end
      if hero.status == 1 && field.status != 1 && hero.hero_type == 3 #不死鳥の加護
        Window.draw_font(490,476,"不死鳥の加護 : 残#{6-hero.limit_turn}ターン", print_font, color:[255,255,255,255],z:17)
      end
      if hero.status == 2 && hero.hero_type == 4 && field.status != 1 #聖導のまもり
        Window.draw_font(490,476,"聖導のまもり : 残#{6-hero.limit_turn}ターン", print_font, color:[255,255,255,255],z:17)
      end
      if hero.status == 3 && hero.hero_type == 5 && field.status != 1 #リプライザル
        Window.draw_font(490,476,"リプライザル : 残#{4-hero.limit_turn}ターン", print_font, color:[255,255,255,255],z:17)
      end
      #お金表示
      Window.draw_morph(350,653,375,653,375,678,350,678,money_img,z:3) #画像
      #hero.money = 10000
      now_money = hero.money.to_s.rjust(5) #取得前のレベル
      Window.draw_font(380,654,"#{now_money}", print_font, color:[255,255,255,255],z:4) #数字
      #敵の名前
      if enemy.hp > 0
        #名前枠
        Window.draw_box_fill(410,  40, 630, 95, C_WHITE, z=3)
        Window.draw_box_fill(415,  45, 625, 90, C_BLACK, z=4)
        #敵の名前
        if enemy.type == 1 
          Window.draw_font(460,55,"【ゴブリン】", battle_font, color:[255,255,255,255],z:5)
        elsif enemy.type == 2
          Window.draw_font(460,55,"【　魔王　】", battle_font, color:[255,255,255,255],z:5)
        end
        #HP枠
        Window.draw_box_fill(198,  398, 812, 422, C_BLACK, z=3)
        Window.draw_box_fill(200,  400, 810, 420, C_WHITE, z=4)
        #敵のHP表示
        tmp_hp_max = enemy.hp_max * 0.1
        #バー
        for i in 1..10
          if enemy.hp >= (tmp_hp_max * i)
            Window.draw_box_fill(200,  400, 200 + (61 * i), 420, C_RED, z=5)
          end
        end
      end
=begin
      #左上表示枠
      Window.draw_box_fill(20,  20, 170, 170, C_WHITE, z=2)
      Window.draw_box_fill(25,  25, 165, 165, C_BLACK, z=3)
      #文字
      Window.draw_font(70,30,"つぎ", battle_font, color:[255,255,255,255],z:5)
      #アイコン表示
      if field.next_enemy == 1 #敵
        if enemy.type == 1 #ゴブリン
          Window.draw_morph(45,60,145,60,145,160,45,160,enemy_goblin_face,z:5)
        end
      elsif field.next_enemy == 2 #商人
          Window.draw_morph(45,60,145,60,145,160,45,160,merchant_img,z:5)
      end
=end
    end
    #「敵を倒した！」表示
    def finished_battle(hero,enemy,field)
      flag = nil
      Window.loop do
        #背景を描画
        if enemy.type == 2
          title_img = Image.load("images/魔王城.png")
        else
          title_img = Image.load("images/タイトル.jpg")
        end
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #敵を描画
        #enemy.print_enemy
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #「たたかう」枠
        #Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
        #マウス座標取得
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        #表示枠
        Window.draw_box_fill(370,  350, 630, 440, C_YELLOW, z=8) #大枠
        Window.draw_box_fill(375,  355, 625, 435, C_BLACK, z=9) #内枠
        font = Font.new(32) #MS明朝
        title_font = Font.new(40)
        intro_font = Font.new(25)
        print_font = Font.new(20)
        Window.draw_font(431,382,"敵を倒した！", intro_font, color:[255,255,255,255],z:10)
        if Input.mousePush?(M_LBUTTON)
          break
        end
        #お金加算表示
        if hero.hero_type == 4 && flag == nil #信仰者なら
          enemy.money *= 2 #2倍獲得
          flag = true
        end
        em_money = enemy.money.to_s.rjust(enemy.money.to_s.length) #取得前のレベル
        Window.draw_font(370,684,"( + #{em_money} )", print_font, color:[255,255,255,255],z:4) #数字
        if hero.hero_type == 4
          #表示
          tmp_money_font = Font.new(12)
          Window.draw_font(385,710,"(×2倍)", tmp_money_font, color:[255,255,255,255],z:4) #数字
        end
      end
    end
    #経験値計算
    def exp_calc(hero,enemy,field)
      if enemy.type == 2
        title_img = Image.load("images/魔王城.png")
      else
        title_img = Image.load("images/タイトル.jpg")
      end
      exp_cnt = 0
      #ラプソディ用
      hero.power = hero.origin_power
      #hero.def = hero.before_def
      #お金を加算
      hero.money += enemy.money
      is_levelup = nil #レベルアップしたか
      old_level = hero.level.to_s.rjust(2) #取得前のレベル
      old_power = hero.power.to_s.rjust(3)
      old_hp = hero.hp_max.to_s.rjust(3)
      old_mp = hero.mp_max.to_s.rjust(3)
      old_def = hero.def.to_s.rjust(3)
      old_speed = hero.speed.to_s.rjust(3)
      old_brain = hero.brain.to_s.rjust(3)
      #旅人は経験値の取得量が多い
      if hero.hero_type == 5
        enemy.exp *= 2
      end
      loop do
        hero.exp += enemy.exp
        if hero.exp >= hero.need_exp
          hero.exp -= hero.need_exp
          up_need = hero.need_exp * 0.3
          hero.need_exp += up_need
          hero.need_exp = hero.need_exp.to_i
          #ステータス増加
          hero.hp_max += rand(1..3)
          hero.hp = hero.hp_max
          hero.mp_max += 4
          hero.mp = hero.mp_max
          hero.power += rand(1..3)
          hero.def += rand(1..3)
          hero.speed += rand(2..4)
          hero.brain += rand(1..3)
          #増加値調整
          if hero.hero_type == 1
            hero.power -= 1
            hero.def += 3
          elsif hero.hero_type == 2
            hero.mp_max += rand(2..4)
            hero.mp = hero.mp_max
            hero.brain += rand(3..5)
            hero.power -= 1
          elsif hero.hero_type == 3
            hero.power += rand(2..4)
          elsif hero.hero_type == 4
            hero.speed += rand(2..5)
          end
          hero.level += 1
          is_levelup = true
        else
          break
        end
        exp_cnt += 1
      end
      #hero.origin_def = hero.def *= 2
      new_level = hero.level #取得後のレベル
      new_power = hero.power.to_s.rjust(3)
      new_hp = hero.hp_max.to_s.rjust(3)
      new_mp = hero.mp.to_s.rjust(3)
      new_def = hero.def.to_s.rjust(3)
      new_speed = hero.speed.to_s.rjust(3)
      new_brain = hero.brain.to_s.rjust(3)
      hero.origin_power = hero.power
      hero.power = hero.origin_power
      #レベルアップ表示
      if is_levelup != nil
        #クリック待ち
        Window.loop do
          #背景を描画
          Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
          #敵を描画
          #enemy.print_enemy
          #バトル枠表示
          field.print_battle(hero,enemy,field)
          #マウス座標取得
          x = Input.mouse_pos_x  # マウスカーソルのx座標
          y = Input.mouse_pos_y  # マウスカーソルのy座標
          #表示枠
          Window.draw_box_fill(470,  240, 820, 500, C_YELLOW, z=8) #大枠
          Window.draw_box_fill(475,  245, 815, 495, C_BLACK, z=9) #内枠
          #表示中身
          print_font = Font.new(20)
          Window.draw_font(532,265,"Level UP！", print_font,z:10)
          Window.draw_font(523,305,"  HP  UP！", print_font,z:10)
          Window.draw_font(522,335,"  MP  UP！", print_font,z:10)
          Window.draw_font(524,365,"ちから UP！", print_font,z:10)
          Window.draw_font(523,395,"ずのう UP！", print_font,z:10)
          Window.draw_font(527,425,"まもり UP！", print_font,z:10)
          Window.draw_font(527,455,"そくど UP！", print_font,z:10)
          #数字(取得前)
          Window.draw_font(667,265,"#{old_level}", print_font,z:10)
          Window.draw_font(663,305,"#{old_hp}", print_font,z:10)
          Window.draw_font(663,335,"#{old_mp}", print_font,z:10)
          Window.draw_font(663,365,"#{old_power}", print_font,z:10)
          Window.draw_font(663,395,"#{old_brain}", print_font,z:10)
          Window.draw_font(663,425,"#{old_def}", print_font,z:10)
          Window.draw_font(663,455,"#{old_speed}", print_font,z:10)
          #矢印
          Window.draw_font(713,265,"->", print_font,z:10)
          Window.draw_font(713,305,"->", print_font,z:10)
          Window.draw_font(713,335,"->", print_font,z:10)
          Window.draw_font(713,365,"->", print_font,z:10)
          Window.draw_font(713,395,"->", print_font,z:10)
          Window.draw_font(713,425,"->", print_font,z:10)
          Window.draw_font(713,455,"->", print_font,z:10)
          #数字(取得後)
          Window.draw_font(760,265,"#{new_level}", print_font,z:10)
          Window.draw_font(749,305,"#{new_hp}", print_font,z:10)
          Window.draw_font(749,335,"#{new_mp}", print_font,z:10)
          Window.draw_font(749,365,"#{new_power}", print_font,z:10)
          Window.draw_font(749,395,"#{new_brain}", print_font,z:10)
          Window.draw_font(749,425,"#{new_def}", print_font,z:10)
          Window.draw_font(749,455,"#{new_speed}", print_font,z:10)
          #クリックしたら
          if Input.mousePush?(M_LBUTTON)
            hero.origin_def = hero.def*2
            hero.origin_power = hero.power
            Window.update
            break
          end
        end
      end
    end
    #ターン表示
    def print_turn(hero,enemy,field)
      Window.loop do
      print_font = Font.new(26)
      turn_font = Font.new(18)
      #背景を描画
      if enemy.type == 2
        title_img = Image.load("images/魔王城.png")
      else
        title_img = Image.load("images/タイトル.jpg")
      end
      Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
      #敵を描画
      enemy.print_enemy
      #バトル枠表示
      field.print_battle(hero,enemy,field)
      #マウス座標取得
      x = Input.mouse_pos_x  # マウスカーソルのx座標
      y = Input.mouse_pos_y  # マウスカーソルのy座標
      #枠表示
      Window.draw_box_fill(230,  150, 780, 350, C_YELLOW, z=8) #大枠(目標)
      Window.draw_box_fill(235,  155, 775, 345, C_BLACK, z=9) #内枠(目標)
      #表示
      trn = @turn.to_s.rjust(3)
      #キャラアイコン
      #女性キャラ1
      woman1_normal = Image.load("images/chara/woman1/face_normal.png")
      #女性キャラ2
      woman2_normal = Image.load("images/chara/woman2/face_normal.png")
      #女性キャラ3
      woman3_normal = Image.load("images/chara/woman3/face_normal.png")
      #男性キャラ1
      man1_normal = Image.load("images/chara/man1/face_normal.png")
      #男性キャラ2
      man2_normal = Image.load("images/chara/man2/face_normal.png")
      #男性キャラ3
      man3_normal = Image.load("images/chara/man3/face_normal.png")
      #敵アイコン
      enemy_goblin_face = Image.load("images/enemy_face/face_1.png")
      #敵アイコン
      enemy_king_face = Image.load("images/enemy_face/face_2.png")
      #アイコン表示
      if hero.speed >= enemy.speed
        Window.draw_font(425,180,"#{trn}  ターン目", print_font,color:[255,255,255,255],z:10)
        Window.draw_font(470,225,"行動順", turn_font,color:[255,255,255,255],z:10)
        if hero.hero_type == 0
          Window.draw_morph(370,258,440,258,440,328,370,328,woman1_normal,z:15)
        elsif hero.hero_type == 1
          Window.draw_morph(370,258,440,258,440,328,370,328,woman2_normal,z:15)
        elsif hero.hero_type == 2
          Window.draw_morph(370,258,440,258,440,328,370,328,woman3_normal,z:15)
        elsif hero.hero_type == 3
          Window.draw_morph(370,258,440,258,440,328,370,328,man1_normal,z:15)
        elsif hero.hero_type == 4
          Window.draw_morph(370,258,440,258,440,328,370,328,man2_normal,z:15)
        elsif hero.hero_type == 5
          Window.draw_morph(370,258,440,258,440,328,370,328,man3_normal,z:15)
        end
        #矢印
        Window.draw_font(486,280,"->", print_font,z:10)
        #敵アイコン表示
        if enemy.type == 1
          Window.draw_morph(545,258,615,258,615,328,545,328,enemy_goblin_face,z:15)
        elsif enemy.type == 2
          Window.draw_morph(545,258,615,258,615,328,545,328,enemy_king_face,z:15)
        end
      elsif hero.speed < enemy.speed
        Window.draw_font(425,180,"#{trn}  ターン目", print_font,color:[255,255,255,255],z:10)
        Window.draw_font(470,225,"行動順", turn_font,color:[255,255,255,255],z:10)
        #矢印
        Window.draw_font(486,280,"->", print_font,z:10)
        #敵アイコン表示
        if enemy.type == 1 && enemy.hp > 0
          Window.draw_morph(370,258,440,258,440,328,370,328,enemy_goblin_face,z:15)
        elsif enemy.type == 2
          Window.draw_morph(370,258,440,258,440,328,370,328,enemy_king_face,z:15)
        end
        #自分アイコン表示
        if hero.hero_type == 0
          Window.draw_morph(545,258,615,258,615,328,545,328,woman1_normal,z:15)
        elsif hero.hero_type == 1
          Window.draw_morph(545,258,615,258,615,328,545,328,woman2_normal,z:15)
        elsif hero.hero_type == 2
          Window.draw_morph(545,258,615,258,615,328,545,328,woman3_normal,z:15)
        elsif hero.hero_type == 3
          Window.draw_morph(545,258,615,258,615,328,545,328,man1_normal,z:15)
        elsif hero.hero_type == 4
          Window.draw_morph(545,258,615,258,615,328,545,328,man2_normal,z:15)
        elsif hero.hero_type == 5
          Window.draw_morph(545,258,615,258,615,328,545,328,man3_normal,z:15)
        end
      end
      #クリックしたら
      if Input.mousePush?(M_LBUTTON)
        break
      end
      end
    end
    #「現れた！」表示
    def entry_enemy(hero,enemy,field)
      entry_font = Font.new(26)
      Window.loop do
        #背景を描画
        if enemy.type == 2
          title_img = Image.load("images/魔王城.png")
        else
          title_img = Image.load("images/タイトル.jpg")
        end
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #敵を描画
        enemy.print_enemy
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #枠表示
        Window.draw_box_fill(350,  190, 690, 290, C_YELLOW, z=1) #大枠(目標)
        Window.draw_box_fill(355,  195, 685, 285, C_BLACK, z=2) #内枠(目標)
        #マウス座標取得
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        #表示
        if enemy.type == 1
          Window.draw_font(405,230,"【ゴブリン】 が現れた！", entry_font,color:[255,255,255,255],z:3)
        end
        #クリックしたら
        if Input.mousePush?(M_LBUTTON)
          break
        end
      end
    end
    #次回出てくる人の選定
    def select_next(hero,enemy,field,first_flag)
      is_next = rand(1..6)
      #次の予定の人を今回の人に
      field.crt_enemy = field.next_enemy
      #次の選定
      if (is_next != 1 && is_next != 2) || field.crt_enemy == 2 #確率を外した場合と商人の次は必ず敵
        field.next_enemy = 1 #敵
      else
        field.next_enemy = 2 #商人
      end
      #初回は敵
      if first_flag == true
        field.crt_enemy = 1 #敵
      end
    end
    #バトルメイン表示
    def battle_now(hero,enemy,field,merchant,first,diff_level)
      #あらゆる状態をリセット
      hero.limit_turn = 12
      hero.status = 0
      #攻撃力リセット
      hero.power = hero.origin_power
      #防御リセット
      hero.def = hero.before_def
      #回避リセット
      if hero.status == 2
        hero.avoid = 10
        hero.def -= $up_def.to_i
        hero.before_def = hero.def
      end
      if hero.is_escaped != true && first != true && field.crt_enemy == 1 #逃げたときは経験値が入らない
        field.finished_battle(hero,enemy,field)
        Window.update
        field.exp_calc(hero,enemy,field)
      end
      field.select_next(hero,enemy,field,first)
      first = nil
      field.new_battle
      #debug(強制魔王登場)
      #enemy.bossflag = true
      #
      enemy.set_enemy
      enemy.set_status(diff_level,hero,field)
      #「～」が現れた！
      field.entry_enemy(hero,enemy,field)
    
      #debug
      #enemy.hp = 1
      #enemy.power = 35
        
      Window.loop do
        #バトルなら
        if field.crt_enemy == 1
          #速度比較
          if hero.speed >= enemy.speed #自分が先制
            #ターン表示
            field.print_turn(hero,enemy,field)
            #固有
            hero.origin_skill(hero,enemy,field)
            #自分のターン
            hero.my_turn(hero,enemy,field)
            #継続ターン表示調整
            hero.limit_turn += 1
            #敵の行動
            if enemy.hp > 0
              enemy.calc_damage(hero,enemy,field)
            end
            #調整
            hero.limit_turn -= 1
          else #相手の先制
            #ターン表示
            field.print_turn(hero,enemy,field)
            #固有
            hero.origin_skill(hero,enemy,field)
            #敵の行動
            if enemy.hp > 0
              enemy.calc_damage(hero,enemy,field)
            end
            #自分のターン
            if enemy.hp > 0 #反撃で倒せる場合があるため
              hero.my_turn(hero,enemy,field)
            end
          end
    
          if enemy.hp <= 0
            #あらゆる状態をリセット
            hero.limit_turn = 12
            hero.status = 0
            #攻撃力リセット
            hero.power = hero.origin_power
            #防御リセット
            hero.def = hero.before_def
            #回避リセット
            if hero.status == 2
              hero.avoid = 10
              hero.def -= $up_def.to_i
              hero.before_def = hero.def
            end
            if hero.is_escaped != true && first != true && field.crt_enemy == 1 #逃げたときは経験値が入らない
              field.finished_battle(hero,enemy,field)
              Window.update
              field.exp_calc(hero,enemy,field)
            end
            if Input.mousePush?(M_LBUTTON)
              return
            end
          end
  
          #ターンを進める
          field.turn_cnt(hero,enemy,field)
  
        end
      end
    end
  end
  
  #主人公
  class Hero
    attr_accessor :status, :is_escaped, :hero_type, :crt_page, :max_page, :level, :limit_turn, :hp, :power, :origin_power, :brain, :avoid, :origin_avoid, :is_def, :def, :origin_def, :before_def, :cri, :hp_max, :mp, :mp_max, :speed, :exp, :money, :need_exp
    def initialize
      @level = 1
      @exp = 0
      @money = 10
      @need_exp = 10
      @limit_turn = 12
      @crt_page = 1 #現在のページ数
      @max_page = 2 #ページ総数
      @is_def = nil
      @status = 0 #状態
    end
    #主人公タイプ登録
    def set_hero_level(num)
      @hero_type = num.to_i
    end
    #ステータス設定
    def set_status
      #HP
      @hp = 100 + (rand(0.1..0.5) * 20) #100 + (2 ~ 10)
      #MP
      @mp = 10
      #ステータス調整
      if @hero_type == 2 #魔法研究者はmpが高い
        @mp *= 2
      end
      #ちから
      @power = (rand(0.5..0.9) * 50) / 2 #12 ~ 22
      #ステータス調整
      if @hero_type == 1 #迷い人は攻撃が低め
        @power *= 0.8
      elsif @hero_type == 3 #勇者は攻撃が高い
        @power *= 1.5
      end
      #ずのう
      @brain = (rand(0.5..0.9) * 50) / 2 #12 ~ 22
      #ステータス調整
      if @hero_type == 2 #魔法研究者は頭脳が高い
        @brain *= 1.5
      end
      #回避率
      @avoid = 10
      #ステータス調整
      if @hero_type == 1 #迷い人は回避率が高い
        @avoid = 50
      end
      #ぼうぎょ
      @def = 10 + rand(1..10)
      #ステータス調整
      if @hero_type == 2 #魔法研究者は防御が低い
        @def *= 0.7
      end
      #クリティカル
      @cri = 10
      #ステータス調整
      if @hero_type == 3 #勇者はクリティカル率が高い
        @cri = 30
      end
      #速度
      @speed = 10 + rand(1..5)
      #ステータス調整
      if @hero_type == 4 #信仰者は速度が高い
        @speed += 20
      end
      #旅人は初期ステータス低め
      if @hero_type == 5
        @hp *= 0.7
        @mp *= 0.7
        @power *= 0.7
        @brain *= 0.7
        @def *= 0.7
        @speed *= 0.7
      end
      #整数処理
      @hp = @hp.to_i
      @hp_max = @hp
      @mp = @mp.to_i
      @mp_max = @mp
      @power = @power.to_i
      @origin_power = @power
      @brain = @brain.to_i
      @def = @def.to_i
      @before_def = @def
      @origin_def = @def*2
      @speed = @speed.to_i
      @origin_avoid = @avoid
    end
    #わざ表示
    def print_skill
      print_font = Font.new(20)
      if @crt_page == 1 #1ページ目
        Window.draw_font(475,541,"通常攻撃 : MP 0", print_font, color:[255,255,255,255],z:8)
        ret = check_mp(1)
        if ret != true
          Window.draw_font(655,541," 強攻撃  : MP 1", print_font, color:[255,255,0,0],z:8)
        else
          Window.draw_font(655,541," 強攻撃  : MP 1", print_font, color:[255,255,255,255],z:8)
        end
        #キャラ固有技
        #迷い人ならターン経過で攻撃力が上がるスキル
        if @hero_type == 0 #天使
          ret = check_mp(10)
          if @level >= 1 && ret == true
            Window.draw_font(475,581,"             聖戦の響き : MP 10", print_font, color:[255,255,255,255],z:8)
            Window.draw_font(475,611,"    (30%の確率で敵を即死させる魔法)", print_font, color:[255,255,255,255],z:8)
          elsif @level >= 1 && ret == nil
            Window.draw_font(475,581,"             聖戦の響き : MP 10", print_font, color:[255,255,0,0],z:8)
            Window.draw_font(475,611,"    (30%の確率で敵を即死させる魔法)", print_font, color:[255,255,0,0],z:8)
          end
        elsif @hero_type == 1 #迷い人
          ret = check_mp(10)
          if @level >= 1 && ret == true && @origin_power == @power
            Window.draw_font(475,581,"            ラプソディ : MP 10", print_font, color:[255,255,255,255],z:8)
            Window.draw_font(475,611,"(ターン経過ごとに攻撃力上昇:最大10ターン)", print_font, color:[255,255,255,255],z:8)
          elsif @level >= 1 && (ret != true || @origin_power != @power)
            Window.draw_font(475,581,"            ラプソディ : MP 10", print_font, color:[255,255,0,0],z:8)
            Window.draw_font(475,611,"(ターン経過ごとに攻撃力上昇:最大10ターン)", print_font, color:[255,255,0,0],z:8)
          end
        elsif @hero_type == 2 #魔法研究者
          ret = check_mp(@mp)
          if @level >= 1 && ret == true && @mp > 0
            Window.draw_font(475,581,"               メテオ : MP すべて", print_font, color:[255,255,255,255],z:8)
            Window.draw_font(475,611,"      (MPの消費量に応じた「ずのう」攻撃)", print_font, color:[255,255,255,255],z:8)
          elsif @level >= 1 && ret == true && @mp == 0
            Window.draw_font(475,581,"               メテオ : MP すべて", print_font, color:[255,255,0,0],z:8)
            Window.draw_font(475,611,"      (MPの消費量に応じた「ずのう」攻撃)", print_font, color:[255,255,0,0],z:8)
          end
        elsif @hero_type == 3 #勇者
          ret = check_mp(30)
          not_die_font = Font.new(17)
          if @level >= 10 && ret == true #発動可能
            Window.draw_font(475,581,"               不死鳥の加護 : MP 30", print_font, color:[255,255,255,255],z:8)
            Window.draw_font(475,611,"(「1度だけHP0から復活し以後攻撃力+50%」状態を付与)", not_die_font, color:[255,255,255,255],z:8)
          elsif @level >= 10 && ret == nil #MPが足りない
            Window.draw_font(475,581,"               不死鳥の加護 : MP 30", print_font, color:[255,255,0,0],z:8)
            Window.draw_font(475,611,"(「1度だけHP0から復活し以後攻撃力+50%」状態を付与)", not_die_font, color:[255,255,0,0],z:8)
          elsif @level < 10 #レベルが足りない
            Window.draw_font(475,601,"                (未開放:Lv.10～)", print_font, color:[255,255,255,255],z:8)
          end
        elsif @hero_type == 4 #信仰者
          ret = check_mp(10)
          if @level >= 1 && ret == true && @status != 2
            Window.draw_font(475,581,"               聖導のまもり : MP 10", print_font, color:[255,255,255,255],z:8)
            Window.draw_font(475,611,"     (まもり+30%、かいひ+30% : 継続5ターン)", print_font, color:[255,255,255,255],z:8)
          elsif @level >= 1 && (ret == nil || @status == 2)
            Window.draw_font(475,581,"               聖導のまもり : MP 10", print_font, color:[255,255,0,0],z:8)
            Window.draw_font(475,611,"     (まもり+30%、かいひ+30% : 継続5ターン)", print_font, color:[255,255,0,0],z:8)
          end
        elsif @hero_type == 5 #旅人
          ret = check_mp(5)
          if @level >= 1 && ret == true && @status != 3
            Window.draw_font(475,581,"               リプライザル : MP 5", print_font, color:[255,255,255,255],z:8)
            Window.draw_font(475,611,"  (敵の攻撃の100%カウンター : 継続3ターン)", print_font, color:[255,255,255,255],z:8)
          elsif @level >= 1 && (ret == nil || @status == 3)
            Window.draw_font(475,581,"               リプライザル : MP 5", print_font, color:[255,255,0,0],z:8)
            Window.draw_font(475,611,"  (敵の攻撃の100%カウンター : 継続3ターン)", print_font, color:[255,255,0,0],z:8)
          end
        end
      elsif @crt_page == 2 #2ページ目
        if @mp != @mp_max
          Window.draw_font(515,541,"めいそう(MPを回復する) : MP 0", print_font, color:[255,255,255,255],z:8)
        elsif @mp == @mp_max
          Window.draw_font(515,541,"めいそう(MPを回復する) : MP 0", print_font, color:[255,255,0,0],z:8)
        end
      end
      #次ページ
      if @crt_page == 1 #1ページ目
        Window.draw_font(575,671,"    #{@crt_page} / #{@max_page}   >", print_font, color:[255,255,255,255],z:8)
      elsif @crt_page == @max_page #最終ページ
        Window.draw_font(575,671,"<   #{@crt_page} / #{@max_page}", print_font, color:[255,255,255,255],z:8)
      else #それ以外
        Window.draw_font(575,671,"<   #{@crt_page} / #{@max_page}   >", print_font, color:[255,255,255,255],z:8)
      end
    end
    #自分の攻撃のダメージ計算
    def calc_damage(hero,enemy,field,pat,num) #pat...攻撃パターン(0:物理、1:魔法), #num...識別番号
      #
      #patとnumの仕分け辞書
      #(...,0,0)->通常攻撃
      #(...,0,1)->強攻撃
      #(...,1,0)->メテオ(魔法研究者固有スキル)
      #(...,1,1)->聖戦の響き(天使固有スキル)
      #
      print_font = Font.new(20)
      die_font = Font.new(35) #MS明朝
      #回避したか
      is_avoid = nil
      #クリティカルが出たか
      is_cri = nil
      #即死したか
      die_flag = nil
      #「ミス」
      is_miss = nil
      if pat == 0 #物理攻撃(通常攻撃、強攻撃)
        dmg = rand(hero.power..hero.power*1.5) - enemy.def
        if num == 1 #強攻撃
          dmg *= 1.5
        end
      elsif pat == 1 #魔法攻撃
        if num == 0 #メテオ
          dmg = (hero.mp * 5 + rand((hero.brain*2)..(hero.brain*3))) - enemy.brain
          #high = hero.mp * 5 + rand((hero.brain*1.0)..hero.brain)
          #dmg = rand(hero.brain..hero.brain*1.5) - enemy.brain
          hero.mp = 0 #mp全消費
        elsif num == 1 #聖戦の響き
          die_rand = rand(1..10)
            if die_rand == 1 || die_rand == 2 || die_flag == 3
              die_flag = true #即死したか
              dmg = enemy.hp
              enemy.hp = 0
            else
              is_miss = true #失敗は「かいひ」と表示
            end
        else
          dmg = rand(hero.brain..hero.brain*1.5) - enemy.brain
        end
      end
      dmg = dmg.to_i
      #クリティカル計算
      cri = rand(1..10)
      if hero.hero_type != 3
        if cri == 1
          dmg *= 2
          is_cri = true
        end
      elsif hero.hero_type == 3
        if cri == 1 || cri == 2 || cri == 3
          dmg *= 2
          is_cri = true
        end
      end
      #回避計算
      avd = rand(1..10)
      if avd == 1
        is_avoid = true
      end 
      #敵の防御または頭脳が上回った場合は0にする
      if dmg.to_i < 0
        dmg = 0
      end
      #整数化
      dmg = dmg.to_i
      #回避していなければ減少
      #is_avoid = true
      if is_avoid != true
        enemy.hp -= dmg
      end
      #表示
      font = Font.new(32) #MS明朝
      print_time = 0
      Window.loop do
          #背景を描画
          if enemy.type == 2
            title_img = Image.load("images/魔王城.png")
          else
            title_img = Image.load("images/タイトル.jpg")
          end
          Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
          #敵を描画
          enemy.print_enemy
          #バトル枠表示
          field.print_battle(hero,enemy,field)
          #「たたかう」枠
          Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
          #マウス座標取得
          x = Input.mouse_pos_x  # マウスカーソルのx座標
          y = Input.mouse_pos_y  # マウスカーソルのy座標
          #選択枠
          Window.draw_box_fill(460, 465, 886, 725, C_BLACK, z=6) #黒で塗りつぶす
          #HPとMP
          Window.draw_font(490,491,"HP : #{hero.hp} / #{hero.hp_max}", print_font, color:[255,255,255,255],z:7)
          Window.draw_font(670,491,"MP : #{hero.mp} / #{hero.mp_max}", print_font, color:[255,255,255,255],z:7)
          #キャラごとに表示
          hero.print_skill
          #わざ選択枠
          if pat == 0 && num == 0 #通常攻撃
            Window.draw_box(465, 531, 630, 571, C_WHITE, z=8)
          elsif pat == 0 && num == 1 #強攻撃
            Window.draw_box(645, 531, 810, 571, C_WHITE, z=8)
          end
          dmg_img = Image.load("images/damage.png")
          Window.draw_morph(300,200,500,200,500,400,300,400,dmg_img,z:14)
          #font = Font.new(32) #MS明朝
          dmg = dmg.to_s.rjust(3)
          if is_miss == true
            Window.draw_font(365,280,"ミス！", die_font, color:[255,255,255,255],z:15)
          elsif die_flag == true #即死してたら「そくし」
            Window.draw_font(352,280,"そくし", die_font, color:[255,255,255,255],z:15)
          elsif is_avoid == nil #回避していなければ普通に表示
            Window.draw_font(375,280,"#{dmg}", font, color:[255,255,255,255],z:15)
            #クリティカル表示
            if is_cri == true
              Window.draw_font(315,220,"クリティカル！", font, color:[255,255,255,0],z:16)
            end
          elsif is_avoid == true #回避してれば「かいひ」
            Window.draw_font(352,280,"かいひ", font, color:[255,255,255,255],z:15)
            #クリティカル表示
            if is_cri == true
              Window.draw_font(315,220,"クリティカル！", font, color:[255,255,255,0],z:16)
            end
          end
  
          #時間経過
          default = 30 - (10 * (field.battle_speed - 1))
          if print_time >= default
            break
          end
          print_time += 1
      end
    end
    #キャラ固有スキル
    def origin_skill(hero,enemy,field)
      if hero.hero_type == 0 #天使は確率回復
        if hero.hp_max == hero.hp #HP最大の時は発動しない
          return
        end
        random = rand(1..10)
        if random == 1 || random == 2 || random == 3 || random == 4
          #HP最大値の30%
          cure = hero.hp_max * 0.3
          cure = cure.to_i
          #回復
          old_hp = hero.hp
          hero.hp += cure
          if hero.hp > hero.hp_max
            hero.hp = hero.hp_max
          end
          new_hp = hero.hp
          Window.loop do
            #背景を描画
            if enemy.type == 2
              title_img = Image.load("images/魔王城.png")
            else
              title_img = Image.load("images/タイトル.jpg")
            end
            Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
            #敵を描画
            enemy.print_enemy
            #バトル枠表示
            field.print_battle(hero,enemy,field)
            #マウス座標取得
            x = Input.mouse_pos_x  # マウスカーソルのx座標
            y = Input.mouse_pos_y  # マウスカーソルのy座標
            #枠表示
            Window.draw_box_fill(230,  320, 780, 450, C_YELLOW, z=8) #大枠
            Window.draw_box_fill(235,  325, 775, 445, C_BLACK, z=9) #内枠    
            #表示
            font = Font.new(32) #MS明朝
            title_font = Font.new(40)
            intro_font = Font.new(25)
            print_font = Font.new(20)
            Window.draw_font(410,350,"【特性効果】発動", intro_font, color:[255,255,255,255],z:16)
            Window.draw_font(365,395,"HP         #{old_hp}   ->   #{new_hp}", intro_font, color:[255,255,255,255],z:16)
            #クリックしたら
            if Input.mousePush?(M_LBUTTON)
             break 
            end
          end
        end
      end
      #敵固有スキル
      if enemy.type == 2 #魔王
          Window.loop do
            #背景を描画
            if enemy.type == 2
              title_img = Image.load("images/魔王城.png")
            else
              title_img = Image.load("images/タイトル.jpg")
            end
            Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
            #敵を描画
            enemy.print_enemy
            #バトル枠表示
            field.print_battle(hero,enemy,field)
            #マウス座標取得
            x = Input.mouse_pos_x  # マウスカーソルのx座標
            y = Input.mouse_pos_y  # マウスカーソルのy座標
            #枠表示
            Window.draw_box_fill(230,  320, 780, 400, C_YELLOW, z=8) #大枠
            Window.draw_box_fill(235,  325, 775, 395, C_BLACK, z=9) #内枠    
            #表示
            font = Font.new(32) #MS明朝
            title_font = Font.new(40)
            intro_font = Font.new(25)
            print_font = Font.new(20)
            #HP残量でセリフ変化
            if field.turn == 1
              Window.draw_font(310,350,"ここまで辿りつく輩がいるとはのう・・・", intro_font, color:[255,255,255,255],z:16)
            elsif hero.hp < (hero.hp_max * 0.2) #20%を下回ったら
              Window.draw_font(410,350,"やすらかに眠れ", intro_font, color:[255,255,255,255],z:16)
            else
              Window.draw_font(390,350,"まだまだこれから！", intro_font, color:[255,255,255,255],z:16)
            end
            #クリックしたら
            if Input.mousePush?(M_LBUTTON)
             break 
            end
          end
      end
    end
    #自分のターン
    def my_turn(hero,enemy,field)
      #フォントサイズ
      font = Font.new(32) #MS明朝
      title_font = Font.new(40)
      intro_font = Font.new(25)
      print_font = Font.new(20)
      #選択画面
      Window.loop do
        #コマンド選択後か
        is_selected = nil
        #逃げたか
        hero.is_escaped = nil
        #背景を描画
        if enemy.type == 2
          title_img = Image.load("images/魔王城.png")
        else
          title_img = Image.load("images/タイトル.jpg")
        end
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #敵を描画
        enemy.print_enemy
        #マウス座標取得
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        #Window.draw_font(100, 100, "x : #{x}, y : #{y}", font)
        #こうどう選択枠
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #戦闘速度変更
        Window.draw_box_fill(780, 8, 1020, 50, C_BLACK, z=6) #黒で塗りつぶす
        Window.draw_font(800,20,"戦闘速度  :    <    #{field.battle_speed}x    >", print_font, color:[255,255,255,255],z:7)
        if x >= 980 && x <= 1005 && y >= 20 && y <= 40 && field.battle_speed != 3 && Input.mousePush?(M_LBUTTON) #速度上昇
          field.battle_speed += 1
        end
        if x >= 915 && x <= 935 && y >= 20 && y <= 40 && field.battle_speed != 1 && Input.mousePush?(M_LBUTTON) #速度減少
          field.battle_speed -= 1
        end
        #コマンド枠
        if x >= 172 && x <= 284 && y >= 545 && y <= 573 #こうげき
          Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
          if Input.mousePush?(M_LBUTTON)
            #内容選択
            Window.loop do
              field.status = 1
              #背景を描画
              Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
              #debug
              #enemy.debug
              #敵を描画
              enemy.print_enemy
              #バトル枠表示
              field.print_battle(hero,enemy,field)
              #マウス座標取得
              x = Input.mouse_pos_x  # マウスカーソルのx座標
              y = Input.mouse_pos_y  # マウスカーソルのy座標
              #たたかう選択枠
              Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
              #選択枠
              Window.draw_box_fill(460, 465, 886, 725, C_BLACK, z=6) #黒で塗りつぶす
              #HPとMP
              Window.draw_font(490,491,"HP : #{hero.hp} / #{hero.hp_max}", print_font, color:[255,255,255,255],z:7)
              Window.draw_font(670,491,"MP : #{hero.mp} / #{hero.mp_max}", print_font, color:[255,255,255,255],z:7)
              #キャラごとに表示
              hero.print_skill
              #わざ選択枠
              #Window.draw_font(475,541,"通常攻撃 : MP 0", print_font, color:[255,255,255,255],z:8)
              #Window.draw_font(655,541," 強攻撃  : MP 1", print_font, color:[255,255,255,255],z:8)
              if x >= 475 && x <= 625 && y >= 541 && y <= 561 && hero.crt_page == 1 #通常攻撃
                Window.draw_box(465, 531, 630, 571, C_WHITE, z=8)
                if Input.mousePush?(M_LBUTTON)
                  is_selected = true
                  hero.calc_damage(hero,enemy,field,0,0)
                  break
                end
              elsif x >= 655 && x <= 805 && y >= 541 && y <= 561 && hero.crt_page == 1 #強攻撃
                Window.draw_box(645, 531, 810, 571, C_WHITE, z=8)
                if Input.mousePush?(M_LBUTTON)
                  ret = nil
                  ret = hero.check_mp(1)
                  if ret == true
                    hero.mp -= 1
                    is_selected = true
                    hero.calc_damage(hero,enemy,field,0,1)
                    break
                  end
                end
              elsif x >= 475 && x <= 840 && y >= 581 && y <= 631 && hero.crt_page == 1 && hero.hero_type == 1 #ラプソディ
                #Window.draw_font(475,581,"            ラプソディ : MP 10", print_font, color:[255,255,255,255],z:8)
                #Window.draw_font(475,611,"(ターン経過ごとに攻撃力上昇:最大10ターン)", print_font, color:[255,255,255,255],z:8)
                Window.draw_box(465, 571, 850, 641, C_WHITE, z=8)
                if Input.mousePush?(M_LBUTTON) && hero.limit_turn > 10
                  ret = nil
                  ret = hero.check_mp(10)
                  if ret == true
                    hero.mp -= 10
                    is_selected = true
                    #開始ターンを記憶
                    #start_turn = field.turn
                    hero.limit_turn = 0 #10ターンの猶予
                    break
                  end
                end
              elsif x >= 475 && x <= 840 && y >= 581 && y <= 631 && hero.crt_page == 1 && hero.hero_type == 2 #メテオ
                Window.draw_box(465, 571, 850, 641, C_WHITE, z=8)
                ret = nil
                ret = hero.check_mp(hero.mp)
                if Input.mousePush?(M_LBUTTON) && ret == true
                  #ダメージ計算
                  hero.calc_damage(hero,enemy,field,1,0)
                  #行動確定
                  is_selected = true
                  #ループを抜ける
                  break
                end
              elsif x >= 475 && x <= 840 && y >= 581 && y <= 631 && hero.crt_page == 1 && hero.hero_type == 0 #聖戦の響き
                Window.draw_box(465, 571, 850, 641, C_WHITE, z=8)
                ret = nil
                ret = hero.check_mp(10)
                if Input.mousePush?(M_LBUTTON) && ret == true
                  #MP減少
                  hero.mp -= 10
                  #計算
                  hero.calc_damage(hero,enemy,field,1,1)
                  #行動確定
                  is_selected = true
                  #ループを抜ける
                  break
                end
              elsif x >= 475 && x <= 840 && y >= 581 && y <= 631 && hero.crt_page == 1 && hero.hero_type == 3 && hero.level >= 10 #不死鳥の加護
                Window.draw_box(465, 569, 878, 641, C_WHITE, z=8)
                ret = nil
                ret = hero.check_mp(30)
                if Input.mousePush?(M_LBUTTON) && ret == true
                  #MP減少
                  hero.mp -= 30
                  #フラグ付与
                  hero.status = 1 #不死鳥の加護
                  #ターン設定
                  hero.limit_turn = 0
                  #行動確定
                  is_selected = true
                  #ループを抜ける
                  break
                end
              elsif x >= 475 && x <= 840 && y >= 581 && y <= 631 && hero.crt_page == 1 && hero.hero_type == 4 #聖導のまもり
                Window.draw_box(465, 571, 850, 641, C_WHITE, z=8)
                ret = nil
                ret = hero.check_mp(10)
                if Input.mousePush?(M_LBUTTON) && ret == true && hero.status != 2
                  #MP減少
                  hero.mp -= 10
                  #計算
                  hero.status = 2 #聖導のまもり
                  hero.limit_turn = 0
                  #まもり+30%,かいひ+30%
                  hero.before_def = hero.def
                  $up_def = hero.before_def * 0.3
                  hero.def += $up_def.to_i
                  hero.avoid += 30
                  #行動確定
                  is_selected = true
                  #ループを抜ける
                  break
                end
              elsif x >= 475 && x <= 840 && y >= 581 && y <= 631 && hero.crt_page == 1 && hero.hero_type == 5 #リプライザル
                Window.draw_box(465, 571, 850, 641, C_WHITE, z=8)
                ret = nil
                ret = hero.check_mp(5)
                if Input.mousePush?(M_LBUTTON) && ret == true && hero.status != 3
                  #MP減少
                  hero.mp -= 5
                  #ステータス付与
                  hero.status = 3 #リプライザル
                  #ターンリセット
                  hero.limit_turn = 0
                  #行動確定
                  is_selected = true
                  #ループを抜ける
                  break
                end
              elsif x >= 515 && x <= 800 && y >= 541 && y <= 561 && hero.crt_page == 2 #めいそう
                #Window.draw_font(515,541,"めいそう(MPを回復する) : MP 0", print_font, color:[255,255,255,255],z:8)
                Window.draw_box(505, 531, 800, 571, C_WHITE, z=8)
                if Input.mousePush?(M_LBUTTON) && (hero.mp != hero.mp_max) #最大値でなければ発動可能 
                  #MP回復
                  mp_cure = hero.mp_max * 0.1 #全体の1割
                  mp_cure = mp_cure.to_i
                  if mp_cure < 1 #最低1は回復
                    mp_cure = 1
                  end
                  hero.mp += mp_cure #回復
                  if hero.mp > hero.mp_max #最大値を超えたら
                    hero.mp = hero.mp_max
                  end
                  #行動確定
                  is_selected = true
                  #ループを抜ける
                  break
                end
              elsif x >= 655 && x <= 680 && y >= 665 && y <= 690 && hero.crt_page != hero.max_page #次ページ移動
                if Input.mousePush?(M_LBUTTON)
                  hero.crt_page += 1                  
                end
              elsif x >= 570 && x <= 595 && y >= 665 && y <= 690 && hero.crt_page != 1 #次ページ移動
                if Input.mousePush?(M_LBUTTON)
                  hero.crt_page -= 1                  
                end
              end
            end
            field.status = 0
          end
        elsif x >= 173 && x <= 285 && y >= 605 && y <= 633 #ぼうぎょ
          Window.draw_box(163, 595, 275, 643, C_WHITE, z=5)
          if Input.mousePush?(M_LBUTTON)
            hero.before_def = hero.def
            hero.def *= 2 #防御2倍
            #行動確定
            hero.is_def = true
            break
          end
        elsif x >= 183 && x <= 267 && y >= 665 && y <= 693 #にげる
          Window.draw_box(173, 655, 275, 703, C_WHITE, z=5)
          if Input.mousePush?(M_LBUTTON) && enemy.type != 2
            enemy.hp = 0 #敵を消去
            hero.is_escaped = true #逃げた
            break
          end
        end
        #こうどう内容まで選択されていたらbreak
        if is_selected != nil
          break
        end
      end
    end
    #MP残量チェック
    def check_mp(num)
      @mp -= num
      if @mp < 0 #発動不可
        @mp += num
        return nil
      else #発動可能
        @mp += num
        return true
      end
    end
  end
  
  #敵
  class Enemy
    attr_accessor :hp, :type, :power, :brain, :def, :avoid, :speed, :exp, :hp_max, :money, :bossflag
    def initialize
      @hp = -1
      @exp = 0
      @bossflag = false
    end
    #敵タイプ抽選
    def set_enemy
      @type = rand(1..1)
      #もしbossなら
      if @bossflag == true
        @type = 2
      end
    end
    #敵描画
    def print_enemy
      if @type == 1 #ゴブリン
        enemy_goblin = Image.load("images/enemy/1001010401.png")
        Window.draw(370,100,enemy_goblin)
      elsif @type == 2 #魔王
        enemy_king = Image.load("images/enemy/1322010402.png")
        Window.draw(370,100,enemy_king)
      end
    end
    #ステータス設定
    def set_status(stage_level,hero,field)
      #HP
      @hp = ((stage_level * 40)) + (@type * (rand(2..5) * 10)) 
      #ちから
      if stage_level >= 2
        @power = (stage_level * 10) * (@type * 1.5) + (rand(2..5) * 2) + ((stage_level - 1) * 2)
      else
        @power = (stage_level * 10) * (@type * 1.5) + (rand(2..5) * 2)
      end
      #まもり
      @def = 2 + (rand(1..3) * @type * 2) + ((stage_level - 1) * 5)
      #ずのう
      tmp_start = 2 + @type
      @brain = rand(@type..@type*2) + ((stage_level - 1) * 5)
      #かいひ
      @avoid = 10
      #そくど
      @speed = 10 + (rand(1..5) * @type) + (stage_level - 1)
      #経験値
      all_status = @hp + @power + @def + @brain + @speed
      @exp = (rand(1..10) + (@type * 15) + ((stage_level - 1) * 15) + (all_status * 0.3)) * 2
      if field.enemy_level == 0
        @exp = @exp/5
      elsif field.enemy_level == 1
        @exp = @exp/2
      end
      @exp = @exp.to_i
      #お金
      @money = (@exp / 1.5) * 2.5
      #ステータス調整
      if hero.level == 1 && @type != 2
        @hp *= 0.5
        @power *= 0.7
        @def *= 0.7
        @brain *= 0.7
      end
      #もし魔王なら
      if @type == 2
        @hp = @hp * 30
        @hp_max = @hp * 25
        @power = @power * 12
        @def = @def * 5
        @brain = @brain * 12
        @speed = @speed * 10
        @exp = @exp * 1000000
        @money = @money * 1000000
      end
      #整数調整
      @hp = @hp.to_i
      @hp_max = @hp
      @power = @power.to_i
      @def = @def.to_i
      @brain = @brain.to_i
      @speed = @speed.to_i
      @exp = @exp.to_i
      @money = @money.to_i
    end
    #HPチェック用
    def check_hp
      return @hp
    end
    def debug
      font = Font.new(32) #MS明朝
      Window.draw_font(400, 200, "hp : #{@hp}, power : #{@power}", font, color:[0,0,0],z:11)
      Window.draw_font(400, 240, "def : #{@def}, speed : #{@speed}", font, color:[0,0,0],z:11)
      Window.draw_font(400, 280, "brain : #{@brain}, exp : #{@exp}", font, color:[0,0,0],z:11)
    end
    #敵の攻撃
    def calc_damage(hero,enemy,field)
      print_font = Font.new(20)
      #クリティカルが出たか
      is_cri = nil
      #回避されたか
      is_avoid = nil
      #攻撃種類ランダム
      kind_attack = rand(0..1)
      if kind_attack == 0 || @type == 1 || @type == 2 #物理攻撃
        if field.enemy_level == 1
          dmg = rand(enemy.power..enemy.power*2) - hero.def
        else
          dmg = rand(enemy.power..enemy.power*1.5) - hero.def
        end
      elsif kind_attack == 1 #魔法攻撃
        dmg = rand(enemy.brain..enemy.brain*2) - hero.brain
      end
      #クリティカル計算
      cri = rand(1..10)
      if cri == 1
        dmg *= 2
        is_cri = true
      end
      #回避計算
      avd = rand(1..10)
      if hero.hero_type == 1
        if avd == 1 || avd == 2 || avd == 3 || avd == 4 || avd == 5
          is_avoid = true
        end
      elsif hero.status == 2 #40%
        if avd == 1 || avd == 2 || avd == 3 || avd == 4
          is_avoid = true
        end
      elsif hero.hero_type != 1
        if avd == 1
          is_avoid = true
        end
      end 
      #ダメージ量に応じてMP回復
      cure_mp = rand((dmg * 0.05)..(dmg * 0.1)) #ダメージの5%～10%の範囲が回復量
      #敵の防御または頭脳が上回った場合は0にする
      if dmg < 0
        dmg = 0
      end
      #整数化
      dmg = dmg.to_i
      #回避していなければ減少
      if is_avoid != true
        hero.hp -= dmg
      end
      #0以下は表示に気を付ける
      if hero.hp < 0
        hero.hp = 0
      end
      #表示
      font = Font.new(32) #MS明朝
      print_time = 0
      Window.loop do
          #背景を描画
          if enemy.type == 2
            title_img = Image.load("images/魔王城.png")
          else
            title_img = Image.load("images/タイトル.jpg")
          end
          Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
          #敵を描画
          enemy.print_enemy
          #バトル枠表示
          field.print_battle(hero,enemy,field)
          #「たたかう」枠
          #Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
          #マウス座標取得
          x = Input.mouse_pos_x  # マウスカーソルのx座標
          y = Input.mouse_pos_y  # マウスカーソルのy座標
          #表示
          dmg_img = Image.load("images/damage.png")
          Window.draw_morph(300,350,500,350,500,550,300,550,dmg_img,z:14)
          #font = Font.new(32) #MS明朝
          dmg = dmg.to_s.rjust(3)
          #クリティカル表示
          #is_cri = true
          if is_cri == true
            Window.draw_font(315,370,"クリティカル！", font, color:[255,255,255,0],z:16)
          end
          if is_avoid != true
            Window.draw_font(375,430,"#{dmg}", font, color:[255,255,255,255],z:15)
          elsif is_avoid == true
            Window.draw_font(352,430,"かいひ", font, color:[255,255,255,255],z:15)
          end
          #MP回復表示
          #Window.draw_font(345,460,"MP  + #{cure_mp}", font, color:[255,0,255,0],z:16)
          #クリックしたら
          default = 30 - (10 * (field.battle_speed - 1))
          if print_time >= default
            break
          end
          print_time += 1
      end
      #不死鳥の加護
      if (hero.status == 1 && hero.hp <= 0)
        hero.hp = hero.hp_max
        up_power = hero.origin_power * 0.5
        hero.power += up_power.to_i
        hero.status = 0 #フラグリセット
      end
      #リプライザルがあれば
      if hero.status == 3
        #リセット
        print_time = 0
        #ダメージ計算
        tmp_dmg = dmg #敵の攻撃を保管
        dmg = tmp_dmg * 5 #5倍で反撃
        dmg = dmg.to_i #整数化
        enemy.hp -= dmg 
        Window.loop do
          #背景を描画
          if enemy.type == 2
            title_img = Image.load("images/魔王城.png")
          else
            title_img = Image.load("images/タイトル.jpg")
          end
          Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
          #敵を描画
          enemy.print_enemy
          #バトル枠表示
          field.print_battle(hero,enemy,field)
          #「たたかう」枠
          Window.draw_box(162, 535, 284, 583, C_WHITE, z=5)
          #マウス座標取得
          x = Input.mouse_pos_x  # マウスカーソルのx座標
          y = Input.mouse_pos_y  # マウスカーソルのy座標
          #赤いやつ
          dmg_img = Image.load("images/damage.png")
          Window.draw_morph(300,200,500,200,500,400,300,400,dmg_img,z:14)
          #font = Font.new(32) #MS明朝
          dmg = dmg.to_s.rjust(3)
          #表示
          Window.draw_font(375,280,"#{dmg}", font, color:[255,255,255,255],z:15)
  
          #時間経過
          default = 30 - (10 * (field.battle_speed - 1))
          if print_time >= default
            break
          end
          print_time += 1
        end
      end
    end
  end
  
  #商人
  class Merchant
    #商品設定(薬草->HPの3割回復、回復薬->HPの6割回復、完全薬->HPの100%回復
    #        経験値の巻物->expを1000獲得、経験値の本->expを2500獲得、経験値の秘伝書->expを5000獲得
    #        剣の訓練教本->power+3、盾の訓練教本->def+3、早歩きの本->speed+3、
    #        mpの巻物->mpを50%回復、mpの本->mp完全回復)
    def set_things(hero,enemy,field)
      #抽選配列
      #@all_things = ["薬草","回復薬","完全薬","経験値の巻物","経験値の本","経験値の秘伝書","剣の指導書","盾の指導書","早歩きの本","MPの巻物","MPの本"]
      @all_things = ["薬草","回復薬","経験値の本","剣の指導書","盾の指導書","早歩きの本","精神力の本"]
      #値段登録用配列
      @price = [100,400,1000,250,250,250,400]
      #商品登録配列
      @things = ["-1","-1","-1","-1","-1","-1"]
      #商品表示最大数
      max_thing = 2 #デフォルト
      if hero.level >= 10 && hero.level < 20 #Lv.10～19なら3個
        max_thing = 3
      elsif hero.level >= 20 && hero.level < 30 #Lv.20～29なら4個
        max_thing = 4
      elsif hero.level >= 30 && hero.level < 40 #Lv.30～39なら5個
        max_thing = 5
      elsif hero.level >= 40 #Lv.40以上なら6個
        max_thing = 6
      end
      #debug
      #max_thing = 6
      #登録
      cnt = 0
      @name = []
      max_thing.times do
        @name[cnt] = rand(0..6) #商品がallの何番目か格納
        @things[cnt] = @all_things[@name[cnt]] #商品名を登録
        cnt += 1
      end
    end
    #表示等
    def print_merchant(hero,enemy,field)
      #debug
      #hero.hp = 1
      #hero.money = 10000
      #表示順フラグ
      print_num = 0
      #回復したか
      is_heal = nil
      Window.loop do
        #背景を描画
        if enemy.type == 2
          title_img = Image.load("images/魔王城.png")
        else
          title_img = Image.load("images/タイトル.jpg")
        end
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #商人を描画
        merchant_img = Image.load("images/chara/merchant/stand.png")
        Window.draw_morph(410,90,610,90,610,560,410,560,merchant_img)
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #名前表示枠
        #名前枠
        Window.draw_box_fill(410,  40, 630, 95, C_WHITE, z=3)
        Window.draw_box_fill(415,  45, 625, 90, C_BLACK, z=4)
        #表示枠
        if print_num == 0
          Window.draw_box_fill(333,  330, 698, 420, C_YELLOW, z=2) #大枠
          Window.draw_box_fill(338,  335, 693, 415, C_BLACK, z=3) #内枠
        elsif print_num == 1
          Window.draw_box_fill(333,  300, 698, 420, C_YELLOW, z=2) #大枠
          Window.draw_box_fill(338,  305, 693, 415, C_BLACK, z=3) #内枠
        elsif print_num == 2
          Window.draw_box_fill(363,  230, 668, 315, C_YELLOW, z=2) #大枠
          Window.draw_box_fill(368,  235, 663, 310, C_BLACK, z=3) #内枠
        end
        #名前枠
        #フォント登録
        merchant_font = Font.new(24)
        Window.draw_font(460,55,"【旅の商人】", merchant_font, color:[255,255,255,255],z:5)
        #文言
        if print_num == 0
          Window.draw_font(385,362,"ここまでよくぞいらしました。", merchant_font, color:[255,255,255,255],z:4)
        elsif print_num == 1
          if hero.hp == hero.hp_max && hero.mp == hero.mp_max && is_heal == nil #全回復状態なら表示しない文言
            break #購入画面へ
          else #そうでなければ回復文言表示
            Window.draw_font(365,332,"おや、傷ついているのか", merchant_font, color:[255,255,255,255],z:4)
            Window.draw_font(365,362,"回復薬だ、ゆっくり休みなさい...", merchant_font, color:[255,255,255,255],z:4)
            is_heal = true
          end
        elsif print_num == 2
          hero.hp = hero.hp_max
          hero.mp = hero.mp_max
          Window.draw_font(400,260,"HPとMPが全回復した！", merchant_font, color:[255,255,255,255],z:4)
        end
        #debug
        #Window.draw_font(100,400,"print_num : #{print_num}", merchant_font, color:[255,0,0,0],z:4)
        #クリックしたら
        if Input.mousePush?(M_LBUTTON)
          print_num += 1
          if print_num == 3
            break
          end
        end
      end
      #商品購入画面
      Window.loop do
        #リセット
        effect = nil
        #背景を描画
        if enemy.type == 2
          title_img = Image.load("images/魔王城.png")
        else
          title_img = Image.load("images/タイトル.jpg")
        end
        Window.draw_morph(0,0,1024,0,1024,768,0,768,title_img)
        #商人を描画
        merchant_img = Image.load("images/chara/merchant/stand.png")
        Window.draw_morph(410,90,610,90,610,560,410,560,merchant_img)
        #バトル枠表示
        field.print_battle(hero,enemy,field)
        #名前表示枠
        #名前枠
        Window.draw_box_fill(410,  40, 630, 95, C_WHITE, z=3)
        Window.draw_box_fill(415,  45, 625, 90, C_BLACK, z=4)
        #表示枠
        Window.draw_box_fill(270,  120, 784, 450, C_WHITE, z=5) #大枠
        Window.draw_box_fill(275,  125, 779, 445, C_BLACK, z=6) #内枠
        #フォント登録
        merchant_font = Font.new(24)
        item_font = Font.new(15)
        Window.draw_font(460,55,"【旅の商人】", merchant_font, color:[255,255,255,255],z:5)
        #商品画像登録
        potion_img = Image.load("images/item/potion_ori.jpg")
        book_img = Image.load("images/item/book_ori.jpg")
        paper_img = Image.load("images/item/paper_ori.jpg")
        #お金画像登録
        money_img = Image.load("images/money.png")
        #ここを出る表示
        Window.draw_box_fill(800,  400, 950, 450, C_WHITE, z=5) #大枠
        Window.draw_box_fill(805,  405, 945, 445, C_RED, z=6) #内枠
        Window.draw_font(823,413,"ここを去る", merchant_font, color:[255,255,255,255],z:7)
        #マウス座標取得
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        #マウス座標表示
        #Window.draw_font(100, 350, "x : #{x}, y : #{y}", merchant_font,color:[255,0,0,0],z:10)
        #商品表示
        for i in 0..1 #縦2つ
          for j in 0..2 #横3つ
            #debug
            #Window.draw_font(500,50+(50*(j+(i*3))),"@things[j+(i*3)] : #{@things[j+(i*3)]}", merchant_font, color:[255,255,255,255],z:10)
            if @things[j+(i*3)] == "薬草"
              #画像
              Window.draw_morph(450 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),250 + (150 * i),450 + (30*j) + (120 * (j-1)),250 + (150 * i),potion_img,z:7)
              #商品名
              Window.draw_font(365 + (150 * j),255 + (150 * i),"薬草", item_font, color:[255,255,255,255],z:7)
              #お金画像表示
              Window.draw_morph(450 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),300 + (145 * i),450 + (37*j) + (115 * (j-1)),300 + (145 * i),money_img,z:7)
              #金額表示
              #Window.draw_font(460,55,"#{@price[@name[j+(i*3)]]}", merchant_font, color:[255,255,255,255],z:7)
              if hero.money >= @price[@name[j+(i*3)]]
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              else
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,0,0],z:7)
              end
            elsif @things[j+(i*3)] == "回復薬"
              #画像
              Window.draw_morph(450 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),250 + (150 * i),450 + (30*j) + (120 * (j-1)),250 + (150 * i),potion_img,z:7)
              #商品名
              Window.draw_font(355 + (150 * j),255 + (150 * i),"回復薬", item_font, color:[255,255,255,255],z:7)
              #お金画像表示
              Window.draw_morph(450 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),300 + (145 * i),450 + (37*j) + (115 * (j-1)),300 + (145 * i),money_img,z:7)
              #金額表示
              #Window.draw_font(460,55,"#{@price[@name[j+(i*3)]]}", merchant_font, color:[255,255,255,255],z:7)
              #Window.draw_font(365 + (150 * j),280 + (145 * i),"#{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              if hero.money >= @price[@name[j+(i*3)]]
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              else
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,0,0],z:7)
              end
            elsif @things[j+(i*3)] == "経験値の本"
              #画像
              Window.draw_morph(450 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),250 + (150 * i),450 + (30*j) + (120 * (j-1)),250 + (150 * i),book_img,z:7)
              #商品名
              Window.draw_font(344 + (150 * j),255 + (150 * i),"経験値の本", item_font, color:[255,255,255,255],z:7)
              #お金画像表示
              Window.draw_morph(450 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),300 + (145 * i),450 + (37*j) + (115 * (j-1)),300 + (145 * i),money_img,z:7)
              #金額表示
              #Window.draw_font(460,55,"#{@price[@name[j+(i*3)]]}", merchant_font, color:[255,255,255,255],z:7)
              #Window.draw_font(365 + (150 * j),280 + (145 * i),"#{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              if hero.money >= @price[@name[j+(i*3)]]
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              else
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,0,0],z:7)
              end
            elsif @things[j+(i*3)] == "剣の指導書"
              #画像
              Window.draw_morph(450 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),250 + (150 * i),450 + (30*j) + (120 * (j-1)),250 + (150 * i),book_img,z:7)
              #商品名
              Window.draw_font(344 + (150 * j),255 + (150 * i),"剣の指導書", item_font, color:[255,255,255,255],z:7)
              #お金画像表示
              Window.draw_morph(450 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),300 + (145 * i),450 + (37*j) + (115 * (j-1)),300 + (145 * i),money_img,z:7)
              #金額表示
              #Window.draw_font(460,55,"#{@price[@name[j+(i*3)]]}", merchant_font, color:[255,255,255,255],z:7)
              #Window.draw_font(365 + (150 * j),280 + (145 * i),"#{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              if hero.money >= @price[@name[j+(i*3)]]
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              else
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,0,0],z:7)
              end
            elsif @things[j+(i*3)] == "盾の指導書"
              #画像
              Window.draw_morph(450 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),250 + (150 * i),450 + (30*j) + (120 * (j-1)),250 + (150 * i),book_img,z:7)
              #商品名
              Window.draw_font(344 + (150 * j),255 + (150 * i),"盾の指導書", item_font, color:[255,255,255,255],z:7)
              #お金画像表示
              Window.draw_morph(450 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),300 + (145 * i),450 + (37*j) + (115 * (j-1)),300 + (145 * i),money_img,z:7)
              #金額表示
              #Window.draw_font(460,55,"#{@price[@name[j+(i*3)]]}", merchant_font, color:[255,255,255,255],z:7)
              #Window.draw_font(365 + (150 * j),280 + (145 * i),"#{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              if hero.money >= @price[@name[j+(i*3)]]
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              else
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,0,0],z:7)
              end
            elsif @things[j+(i*3)] == "早歩きの本"
              #画像
              Window.draw_morph(450 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),250 + (150 * i),450 + (30*j) + (120 * (j-1)),250 + (150 * i),book_img,z:7)
              #商品名
              Window.draw_font(344 + (150 * j),255 + (150 * i),"早歩きの本", item_font, color:[255,255,255,255],z:7)
              #お金画像表示
              Window.draw_morph(450 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),300 + (145 * i),450 + (37*j) + (115 * (j-1)),300 + (145 * i),money_img,z:7)
              #金額表示
              #Window.draw_font(460,55,"#{@price[@name[j+(i*3)]]}", merchant_font, color:[255,255,255,255],z:7)
              #Window.draw_font(365 + (150 * j),280 + (145 * i),"#{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              if hero.money >= @price[@name[j+(i*3)]]
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              else
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,0,0],z:7)
              end
            elsif @things[j+(i*3)] == "精神力の本"
              #画像
              Window.draw_morph(450 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),150 + (150 * i),550 + (30*j) + (120 * (j-1)),250 + (150 * i),450 + (30*j) + (120 * (j-1)),250 + (150 * i),book_img,z:7)
              #商品名
              Window.draw_font(344 + (150 * j),255 + (150 * i),"精神力の本", item_font, color:[255,255,255,255],z:7)
              #お金画像表示
              Window.draw_morph(450 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),275 + (145 * i),475 + (37*j) + (115 * (j-1)),300 + (145 * i),450 + (37*j) + (115 * (j-1)),300 + (145 * i),money_img,z:7)
              #金額表示
              #Window.draw_font(460,55,"#{@price[@name[j+(i*3)]]}", merchant_font, color:[255,255,255,255],z:7)
              #Window.draw_font(365 + (150 * j),280 + (145 * i),"#{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              if hero.money >= @price[@name[j+(i*3)]]
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,255,255],z:7)
              else
                Window.draw_font(365 + (150 * j),280 + (145 * i),"  #{@price[@name[j+(i*3)]]}", item_font, color:[255,255,0,0],z:7)
              end
            elsif @things[j+(i*3)] == "0"
              #商品名
              Window.draw_font(355 + (150 * j),200 + (150 * i),"(購入済)", item_font, color:[255,255,255,255],z:7)
            else
              #商品名
              Window.draw_font(355 + (150 * j),200 + (150 * i),"(未開放)", item_font, color:[255,255,255,255],z:7)
            end
          end
        end
        #マウス判定
        if x >= 330 && x <= 430 && y >= 150 && y <= 250 && Input.mousePush?(M_LBUTTON) && hero.money >= @price[0] && @things[0] != "0" && @things[0] != "-1"
          effect = @things[0]
          hero.money -= @price[0]
          @things[0] = "0"
        elsif x >= 480 && x <= 580 && y >= 150 && y <= 250 && Input.mousePush?(M_LBUTTON) && hero.money >= @price[1] && @things[1] != "0" && @things[1] != "-1"
          effect = @things[1]
          hero.money -= @price[1]
          @things[1] = "0"
        elsif x >= 630 && x <= 730 && y >= 150 && y <= 250 && Input.mousePush?(M_LBUTTON) && hero.money >= @price[2] && @things[2] != "0" && @things[2] != "-1"
          effect = @things[2]
          hero.money -= @price[2]
          @things[2] = "0"
        elsif x >= 330 && x <= 430 && y >= 300 && y <= 400 && Input.mousePush?(M_LBUTTON) && hero.money >= @price[3] && @things[3] != "0" && @things[3] != "-1"
          effect = @things[3]
          hero.money -= @price[3]
          @things[3] = "0"
        elsif x >= 480 && x <= 580 && y >= 300 && y <= 400 && Input.mousePush?(M_LBUTTON) && hero.money >= @price[4] && @things[4] != "0" && @things[4] != "-1"
          effect = @things[4]
          hero.money -= @price[4]
          @things[4] = "0"
        elsif x >= 630 && x <= 730 && y >= 300 && y <= 400 && Input.mousePush?(M_LBUTTON) && hero.money >= @price[5] && @things[5] != "0" && @things[5] != "-1"
          effect = @things[5]
          hero.money -= @price[5]
          @things[5] = "0"
        end
        #結果
        if effect == "薬草" #3割回復
          cure = hero.hp_max * 0.3
          hero.hp += cure.to_i
          if hero.hp > hero.hp_max
            hero.hp = hero.hp_max
          end
        elsif effect == "回復薬"
          cure = hero.hp_max * 0.8
          hero.hp += cure.to_i
          if hero.hp > hero.hp_max
            hero.hp = hero.hp_max
          end
        elsif effect == "経験値の本"
          enemy.exp = 1000
          field.exp_calc(hero,enemy,field)
        elsif effect == "剣の指導書"
          hero.power += rand(1..3)
          hero.origin_power = hero.power
        elsif effect == "盾の指導書"
          hero.def += rand(1..3)
          hero.origin_def = hero.def * 2
          hero.before_def = hero.def
        elsif effect == "早歩きの本"
          hero.speed += rand(1..3)
        elsif effect == "精神力の本"
          hero.mp_max += rand(2..5)
          hero.mp = hero.mp_max
        end
        #去る
        if x >= 800 && x <= 950 && y >= 400 && y <= 450 && Input.mousePush?(M_LBUTTON)
          break
        end
      end
    end
  end
################################################################################################################################################################################################################
#枠
frame=Image.new(924,700,[100,0,0])

judge_frame=Image.new(500,150,[255,255,255])
judge_frame_in=Image.new(480,130,[0,0,0])

#ストーリー
@font=Font.new(SIZE,fontname="MS 明朝")

#シナリオ
@story=[
    #序章(王様視点)
    [
    [
        "あいうえお",
        "あいうえお",
        "あいうえお",
        "あいうえお",
    ],
    [
        "かきくけこ",
        "かきくけこ",
        "かきくけこ",
        "かきくけこ",
    ],
],
    #キャラ選択
    [
    [
        "さしすせそ",
        "さしすせそ",
        "さしすせそ",
        "さしすせそ",
    ],
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
],
    #会話1(tanaka)
    [
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
],
    #会話2(tanaka)
    [
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
],
    #会話1(suzuki)
    [
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
],
    #会話2(suzuki)
    [
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
],
    #会話1(魔王戦闘前)
    [
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
],
    #会話2(魔王戦闘後)
    [
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
    [
        "たちつてと",
        "たちつてと",
        "たちつてと",
        "たちつてと",
    ],
],
]

#シナリオ
def scene(scene,turn,num)
   
    @story[scene][turn][0..num].each_with_index do |n,i|
       message("#{n}",50,50+i*(SIZE*2),@font)    
    end

    if @story[scene][turn][num]==nil
        false
    else 
        true
    end
end

#キャラ選択
def chara_choice
   #選択画面
   Window.loop do

    #背景を描画
    #Window.draw_morph(0,0,1024,0,1024,768,0,768,castle_back)

    #下の枠
    Window.draw_box_fill(80, 580, 946, 730, C_WHITE, z=0)

    #キャラの顔
    Window.draw_morph(80,80,280,80,280,280,80,280,woman1_normal)
    Window.draw_morph(420,80,620,80,620,280,430,280,woman2_normal)
    Window.draw_morph(760,80,960,80,960,280,760,280,woman3_normal)
    Window.draw_morph(80,350,280,350,280,550,80,550,man1_normal)
    Window.draw_morph(420,350,620,350,620,550,430,550,man2_normal)
    Window.draw_morph(760,350,960,350,960,550,760,550,man3_normal)

    #マウス座標取得
    x = Input.mouse_pos_x  # マウスカーソルのx座標
    y = Input.mouse_pos_y  # マウスカーソルのy座標
 
    #マウス座標表示
    #Window.draw_font(100, 100, "x : #{x}, y : #{y}", font) 

    #カーソルが合った場合
    if x >= 80 && x <= 280 && y >= 80 && y <= 280 #左上
      Window.draw_font(110, 600, "【天使】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "ターンごとに一定確率でHPを回復できます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ステータスのバランスが良く、初心者向きです。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(80,80,280,80,280,280,80,280,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 0 #天使
        break
      end
    elsif x >= 420 && x <= 620 && y >= 80 && y <= 280 #上段真ん中
      Window.draw_font(110, 600, "【迷い人】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "回避確率が非常に高く、防御力が高めです。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "攻撃はやや低めのため、序盤は苦戦するかもしれません。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(420,80,620,80,620,280,430,280,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 1 #迷い人
        break
      end
    elsif x >= 760 && x <= 960 && y >= 80 && y <= 280 #右上
      Window.draw_font(110, 600, "【魔法研究者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "MPと頭脳がとても高く、魔法に特化しています。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "その分、物理的な攻撃には弱いので、注意が必要です。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(760,80,960,80,960,280,760,280,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 2 #魔法研究者
        break
      end
    elsif x >= 80 && x <= 280 && y >= 350 && y <= 550 #左下
      Window.draw_font(110, 600, "【勇者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "クリティカル率が非常に高く、攻撃力も高いです。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ステータスはやや攻撃寄りですが、バランス型です。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(80,350,280,350,280,550,80,550,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 3 #勇者
        break
      end
    elsif x >= 420 && x <= 620 && y >= 350 && y <= 550 #下段真ん中
      Window.draw_font(110, 600, "【信仰者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "神からの啓示で、先制を取りやすくなります。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "また、お金のドロップ量が比較的高めに設定されています。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(420,350,620,350,620,550,430,550,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 4 #信仰者
        break
      end
    elsif x >= 760 && x <= 960 && y >= 350 && y <= 550 #右下
      Window.draw_font(110, 600, "【旅人】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "長年の討伐経験から、経験値の取得率が高くなっています。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ただし、初期ステータスは低めに設定されています。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(760,350,960,350,960,550,760,550,red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 5 #旅人
        break
      end
    else #デフォルト
      Window.draw_font(110, 600, "【キャラ選択】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "戦闘中のキャラの見た目を選択できます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "キャラには固有の役職と能力があり、様々な作戦を取ることができます。", intro_font, color:[0,0,0], z:3)
    end

  end

  #主人公タイプ設定
  hero.set_hero_level(is_select_num)

end

#選択肢
def judge(a,b,c,judge_frame,judge_frame_in)
    branch=0
        x = Input.mouse_pos_x  
        y = Input.mouse_pos_y  
        message("今から何をしようか",50,50,@font)
        if x>=260 && x<=760
            if y>=180 && y<=330
            Window.draw(260,180, judge_frame,z=0)
            Window.draw(270,190, judge_frame_in,z=0)
            branch=1
            elsif y>=380 && y<=530
            Window.draw(260,380, judge_frame,z=0)
            Window.draw(270,390, judge_frame_in,z=0)
            branch=2
            elsif y>=580 && y<=730
            Window.draw(260,580, judge_frame,z=0)
            Window.draw(270,590, judge_frame_in,z=0)
            branch=3
            else
                branch=0
            end
        else
            branch=0
        end
            message(a,400,200,@font)
            message(b,400,400,@font)
            message(c,400,600,@font)

        if Input.mousePush?( M_LBUTTON ) && branch!=0
            branch
        else
            0
        end
end

#行動選択
def move(judge_frame,judge_frame_in,clock)
    message("今から何をしようか",50,50,@font)
    branch=judge("バトル","ステータスツリー","会話",judge_frame,judge_frame_in)
        if branch == 1
            battle(clock)
        elsif branch == 2
            sta(clock)
        elsif branch == 3
            conver(clock)
        end
end

def battle(clock)
    message("バトル",50,50,@font)
    clock.now_time+=180
end

def sta(clock)
    message("ステータスツリー",50,50,@font)
    clock.now_time+=120
end

def conver(clock)
    message("会話",50,50,@font)
end

#1日の流れ
def live
    
end

def output_limit(clock)
    now_prog(clock)
    if clock.minute<10 
        message("#{clock.hour}:0#{clock.minute}",10,10,@font)
    else 
        message("#{clock.hour}:#{clock.minute}",10,10,@font)
    end

    message("残り#{clock.date-clock.now_day}日",500,10,@font)
    if clock.now_time>clock.deadline
        finish(clock)
    end
end

def now_prog(clock)
    clock.hour=(clock.wake_up+clock.now_time)/60
    clock.minute=(clock.wake_up+clock.now_time)%60
end    

#21時を過ぎたとき
def finish(clock)
    message("こうして僕の1日は終わった",50,50,@font)
    if(clock.now_day==clock.date)
        message("明日はいよいよ魔王と決戦だ！",50,150,@font)
        flag=1
    else
        message("魔王討伐まであと#{(clock.date-clock.now_day)}日",50,150,@font)
    end
    clock.now_time=0
    clock.now_day+=1
end

#メッセージ出力
def message(mes,pos_x,pos_y,font)
    Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5)    
end

#main文
Window.loop do
    if !scene(story.scene_num,story.page,story.story_num)
        story.page+=1
        story.story_num=0
    else
        if Input.key_push?(K_RETURN)
            story.story_num+=1
        elsif Input.key_push?(K_LEFT)
            story.page-=1
            story.story_num=0
        end
    end
    output_limit(clock)
    chara_choice
    #move(judge_frame,judge_frame_in,clock)
    Window.draw_alpha(50,30, frame, 128)
end
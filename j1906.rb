require 'dxruby'

#初期値
#画面サイズ
Window.width = 1024
Window.height = 768

TITLE=50
SIZE=22
SIZE1=20
SIZE2=50
SIZE3=100

@font=Font.new(SIZE,fontname="MS 明朝")

#枠
frame=Image.new(924,700,[0,0,0])

judge_frame=Image.new(500,150,[255,255,255])
judge_frame_in=Image.new(480,130,[0,0,0])
###########################################j1916#######################################################
def endroll
	i = 0
	text=50
	
	Window.loop do

		@font1=Font.new(SIZE1,fontname="MS 明朝")
		@font2=Font.new(SIZE2,fontname="MS 明朝")
		
		message("Program",text,820-i,@font2)
		message("井山 剣心",text,1020-i,@font1)
		message("Iyama Kenshin",text,1050-i,@font1)			
		message("風穴 輔",text,1250-i,@font1)
		message("Kazaana Tasuku",text,1280-i,@font1)
		message("金築 孝典",text,1480-i,@font1)
		message("kanetsuki Takanori",text,1510-i,@font1)			
		message("久野 智貴",text,1710-i,@font1)
		message("Kuno Tomoki",text,1740-i,@font1)
		message("高橋 千賢",text,1940-i,@font1)			
		message("Takahashi Chisato",text,1970-i,@font1)

		message("タイトル・エンドロール制作",text,2170-i,@font2)
		message("久野 智貴",text,2370-i,@font1)
		message("Kuno Tomoki",text,2400-i,@font1)

		message("ストーリー制作",text,2600-i,@font2)
		message("井山 剣心",text,2800-i,@font1)
		message("Iyama Kenshin",text,2830-i,@font1)

		message("スキルツリー制作",text,3030-i,@font2)
		message("風穴 輔",text,3230-i,@font1)
		message("Kazaana Tasuku",text,3260-i,@font1)
		message("金築 孝典",text,3460-i,@font1)
		message("kanetsuki Takanori",text,3490-i,@font1)

		message("バトル制作",text,3690-i,@font2)
		message("高橋 千賢",text,3890-i,@font1)			
		message("Takahashi Chisato",text,3920-i,@font1)

		message("作曲",text,4120-i,@font2)
		message("高橋 千賢",text,4320-i,@font1)			
		message("Takahashi Chisato",text,4350-i,@font1)

		message("総合取締役",text,4550-i,@font2)
		message("高橋 千賢",text,4750-i,@font1)			
		message("Takahashi Chisato",text,4780-i,@font1)

		i += 1

		if(i>4850)
			return 
		end
	end
end

def gameclear
	Window.loop do
		Window.draw_box_fill(0,0,1024,768,[255,255,255],z=0)
    @font3=Font.new(SIZE3,fontname="MS 明朝")
    def message(mes,pos_x,pos_y,font)
      Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5,color:[255,0,0])    
    end
		message("GAME CLEAR!!",200,300,@font3)

		if Input.key_push?(K_RETURN)
			break
		end
	end
end

def gameover
	Window.loop do
		@font3=Font.new(SIZE3,fontname="MS 明朝")
    def message(mes,pos_x,pos_y,font)
      Window.draw_font(pos_x,pos_y,"#{mes}",@font,z:5,color:[255,0,0])    
    end
		message("GAME OVER",200,300,@font3)

		if Input.key_push?(K_RETURN)
			break
		end
	end

end

#タイトル画面
def title_start(picture,font)
  title_font = Font.new(40)
  Window.loop do

    #背景を描画
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.title_img)
  
    #タイトル表示
    Window.draw_morph(300,0,724,0,724,400,300,400,picture.title_name)
  
    #マウス座標取得
    x = Input.mouse_pos_x  # マウスカーソルのx座標
    y = Input.mouse_pos_y  # マウスカーソルのy座標
  
    #マウス座標表示
    #Window.draw_font(100, 100, "x : #{x}, y : #{y}", font)
  
    #コマンド選択背景
    Window.draw_box_fill(390, 390, 630, 710, C_WHITE, z=2)
    Window.draw_box_fill(395, 395, 625, 705, C_BLACK, z=3)
  
    #コマンド選択
    Window.draw_font(435, 430, "はじめる", title_font, color:[255,255,255,255],z:4)
    Window.draw_font(430, 530, "つづきから", title_font, color:[255,255,255,255],z:4)
    Window.draw_font(452, 630, "おわる", title_font, color:[255,255,255,255],z:4)
  
    #はじめる
    if x >= 435 && x <= 595 && y >= 430 && y <= 470
      #コマンド選択画像
      Window.draw_box(425, 420, 590, 480, C_WHITE, z=4)
      if Input.mousePush?(M_LBUTTON)
        break
      end
    end
  
    #エクストラ
    if x >= 430 && x <= 630 && y >= 530 && y <= 570
      #コマンド選択画像
      Window.draw_box(420, 520, 605, 580, C_WHITE, z=4)
      if Input.mousePush?(M_LBUTTON)
        exit(0)
      end
    end
  
    #おわる
    if x >= 452 && x <= 572 && y >= 630 && y <= 670
      #コマンド選択画像
      Window.draw_box(442, 620, 571, 680, C_WHITE, z=4)
      if Input.mousePush?(M_LBUTTON)
        exit(0)
      end
    end
  
  end
end

def diff_select(picture,font,field)
  title_font = Font.new(40)
  intro_font = Font.new(25)
  Window.loop do

    #背景を描画
    #Window.draw_morph(0,0,1024,0,1024,768,0,768,chara_pick)

    #下の枠
    Window.draw_box_fill(80, 580, 946, 730, C_WHITE, z=0)

    #マウス座標取得
    x = Input.mouse_pos_x  # マウスカーソルのx座標
    y = Input.mouse_pos_y  # マウスカーソルのy座標
 
    #マウス座標表示
    #Window.draw_font(100, 100, "x : #{x}, y : #{y}", font) 

    #3つの枠
    Window.draw_box_fill(360,  80, 660, 190, C_GREEN, z=1)
    Window.draw_box_fill(360,  250, 660, 360, C_BLUE, z=1)
    Window.draw_box_fill(360,  420, 660, 530, C_RED, z=1)

    #白四角
    Window.draw_box_fill(370,  90, 650, 180, C_WHITE, z=2)
    Window.draw_box_fill(370,  260, 650, 350, C_WHITE, z=2)
    Window.draw_box_fill(370,  430, 650, 520, C_WHITE,  z=2)

    #表示
    Window.draw_font(431, 120, "かんたん", title_font, color:[0,240,0], z:3)
    Window.draw_font(431, 290, "へいぼん", title_font, color:[0,0,240], z:3)
    Window.draw_font(432, 460, "きびしい", title_font, color:[240,0,0], z:3)

    #カーソル判定表示
    if x >= 360 && x <= 660 && y >= 80 && y <= 190
      Window.draw_font(110, 600, "【かんたん】", intro_font, color:[0,240,0], z:1)
      Window.draw_font(110, 640, "敵の攻撃力と最大HPが低下します。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "初心者向けの難易度です。", intro_font, color:[0,0,0], z:3)
      if Input.mousePush?(M_LBUTTON)
        diff_level = 1 #かんたん
        break
      end
    elsif x >= 360 && x <= 660 && y >= 250 && y <= 360
      Window.draw_font(110, 600, "【へいぼん】", intro_font, color:[0,0,240], z:1)
      Window.draw_font(110, 640, "敵は全員標準状態に設定されます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "1度はプレイされた方向けの難易度です。", intro_font, color:[0,0,0], z:3)  
      if Input.mousePush?(M_LBUTTON)
        diff_level = 2 #へいぼん
        break
      end
    elsif x >= 360 && x <= 660 && y >= 420 && y <= 530
      Window.draw_font(110, 600, "【きびしい】", intro_font, color:[240,0,0], z:1)
      Window.draw_font(110, 640, "敵の攻撃力と最大HPが大幅に増加します。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "熟練者でもかなり厳しい難易度です。", intro_font, color:[0,0,0], z:3)  
      if Input.mousePush?(M_LBUTTON)
        diff_level = 3 #きびしい
        break
      end
    else
      Window.draw_font(110, 600, "【難易度選択】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "このゲームの難易度を選択できます。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "キャラに合わせた難易度を選択することも大切です。", intro_font, color:[0,0,0], z:3)  
    end

    #難易度登録
    field.set_enemy_level(diff_level)

  end
end

#######################################################################################################
#サポートキャラ
class Support_chara
    attr_accessor :name, :party, :love,:encount
    def initialize(key)
        @name=key       #キャラクター名
        @party=false    #パーティに入っているか(true:入っている,false:入っていない)
        @love=50         #好感度
        @encount=0      #会話数
    end
end

liria=Support_chara.new("liria")      #リーリア
srag=Support_chara.new("srag")        #スラグ

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
    attr_accessor :scene_num,:page,:story_num,:finish_scene
    def initialize
        @scene_num=0 #シナリオ番号
        @page=0      #ページ番号
        @story_num=0 #文章番号
        #文字設定
        @font=Font.new(SIZE,fontname="MS 明朝")
        #シナリオ
        @scenario=[
        #序章(王様視点)
        [
          [
            "真っ暗な道を独り走っている。まるで何かから逃げているように。",
            "心の内は,純度99%の絶望と1%の恐怖という不純物しかなかった。",
            "きっと今、私の顔はとても国民には見せられないものになっているだろう。",
            "それでも走り続けている。\n\n\n",
            "突然、闇の中から漏れ出したような光が前方に現れた。",
            "私はその光に向けて走り出した。",
            "ただ、光に集まる虫のように、本能的に走り出していた。",
            "そして、その光の中に飛び込んだ。",
          ],
          [
            "そこで私の目に映ったのは、\n\n崩壊した城と、血まみれで倒れたたくさんの兵士や国民だった。",
            "\n\nおそらく皆死んでいるのだろう。",
            "\n\n\n???:「王よ、気分はどうだ。」",
            "\n\n\n\n後ろから何かに話しかけられた。",
            "\n\n\n\nしかし振り向けない。恐怖で体が動かない。",
            "\n\n\n\nそれは、金縛りなんて生易しいいものではなく、",
            "\n\n\n\nまるで巨人の手にでも捕まってしまったように、\n\n「動かす」という意思すらないかのように。",
            "\n\n\n\n\n\n\n???:「貴様や貴様の祖先が積み上げてきたものが、\n\nこの魔王の力で一瞬にして崩れた。その気分はどうだと聞いているのだ。」",
          ],
          [
            "魔王。",
            "今こいつは自分のことを魔王といったのか。\n\n300年前に勇者が封印したとされている魔王が自分であると。",
            "\n\n魔王:「はあ、、何も答える気はないか、、、、では死ね。」",
            "\n\n\nグサッ",
            "\n\n\n\n突然、私の目の前に巨大な刃の先が現れた。",
          ],
          [
            "王:「うわああああああああああああ！！！！！！！！！！！！」",
            "そこで目が覚めた。",
            "執事:「王！？どうされたんですか？」",
            "王:「夢か、、、」",
            "安心と同時に大きな絶望に身を包まれた。寒いはずもないのに震えが止まらない。",
            "しかし、絶望している場合ではない、\n\n今は王としてこれからの事態に向き合わなければならない。",
            "\n\n王:「高、、、ランク、、冒、険者の、、、リストを、、、くれ。」",
          ]
        ],
        #魔王討伐依頼
        [
          [
            "王:「お主には１週間後に現れる魔王を一人で魔王と戦ってもらう。」",
            "私:「えっ！？えええええええええええええ！！！！！！！！！！！？？？？？？？？？？」",
            "\n\n\nなんでこんなことになってしまったのか。経緯は一切知らない。",
            "\n\n\nただ家でのんびりしてたら、城の兵士さんが招集状持って、「城に来てもらう」\n\nとか言ってくるから城に来ただけなのに。\n\nこの王様は「おはよう」とか何も言わずに、第一声にとんでもないこと言ってきやがった。",
          ],
          [
            "私:「なんで私なんですか？強い人なんて私以外にもたくさんいるじゃないですか。」",
            "王:「フィーリングだ。」",
            "私:「え？」",
            "王:「なんとなくお主だと思ったんじゃ。」",
            "なんて言えばいいんだ。頭の中にツッコミと文句が1000個以上出てきて\n\n何を言えばいいかわからなくなってしまった。",
            "\n\n\n私:「ていうかなんで私１人なんですか？\n\n魔王とかいうとんでもない奴は人類全員で挑むべきでしょう。」",
            "\n\n\n\n\n王:「それなんだが。城にある書物を読んだところ、\n\n魔王の「孤独者」というスキルのせいで敵の数が多いほどステータスが強化されてしまうらしい。\n\nだから、サポートぐらいはできるだろうが戦闘はお主一人じゃないといけないんだ。」",
            "\n\n\n\n\n\n\n\n\nなんでそこはそんな慎重に立ち回ってんだこいつ。人選ぶの適当なくせに。",
            "",
          ],
          [
            "王:「あっ！！！ちなみに1週間ていうのは、、、」",
            "私:「分かってるよ。あんたの予知夢が１週間後しか見れないからだろ。」",
            "王:「あんたってなんだ、あんたって。私王様だぞ。あんたってなんだよ。」",
            "おいおい、この人怒ってるよ。\n\nこれから魔王討伐とかいうとんでもない任務任せようとしてる人に無茶苦茶怒ってんだけど。",
            "\n\n\n王:「とにかくお主には1週間後魔王と討伐してもらう。これは決定事項だ。」",
          ],
        ],
        #魔王討伐をする
        [
          [
            "私:「あーもう、分かりました。魔王討伐の任務引き受けます。」",
            "王:「おー、そうかそうか。ではよろしく頼む。」",
            "私:「その代わり、報酬は弾んでくださいね。」",
            "王:「そりゃもちろん。この城の財宝を好きなだけ持っていけ。」",
            "\n\n魔王討伐前に盗んでやろうかな、、、",
            "\n\n\n\nともあれ、こうして私の魔王討伐までの1週間が始まった。",
          ],
        ],
        #断る
        [
          [
            "私:「お断りします。」",
            "王:「えっ？」",
            "\n\n王:「ちょっと待て、ちょっと待て。確かに無理難題を言っているのは分かる。\n\nだがそこを頼む。一生のお願いだから。なんでもするから。」",
            "\n\n\n\n私:「・・・」",
            "\n\n\n\nあれ？今なんでもって、、、、",
          ]
        ],
        #雑談をする
        [
          [
            "私:「そんなことより、最近家のポチがね更に大きくなって、、、」",
            "王:「・・・」",
            "私:「・・・」",
            "王:「お主、今話逸らそうとしてない？」",
            "\n\n視線が痛い。この視線で魔王ぐらい倒せるんじゃないか。",
            "\n\n\n\n私:「してないですよ！！！！」",
            "\n\n\n\n王:「第一、お主犬飼ってないよな」",
            "\n\n\n\n私:「、、、、、、えへへ」",
          ]
        ],
        #バトル後
        [
          [
            "3時間経過した"
          ],
        ],
        #スキルツリー後
        [
          [
            "2時間経過した"
          ],
        ],
        #会話後
        [
          [
            "1時間経過した"
          ],
        ],
        #1日目の終了
        [
          [
            "こうして1日が終わった。",
            "\n\n魔王討伐まであと6日",
          ],
          [
            "ある少女の夢を見た。",
            "\n\n少女は少年と二人、野原を駆け回っている。",
            "\n\nその姿は一つの絵画のように美しく、幸せそのものだった。",
            "\n\nある日は二人で花畑で花飾りを作ったり、",
            "\n\nある日は二人で魔法の勉強をしたりして楽しい生活を送っていました。",
            "\n\n\n\nそして、遊び終わったら母親が作った美味しいご飯を食べ、",
            "\n\n\n\n食べ終わったら父に村の外での話を聞いていました。",
          ],
        ],
        #2日目の終了
        [
          [
            "こうして1日が終わった。",
            "\n\n魔王討伐まであと5日",
          ],
          [
            "ある少女の夢を見た。",
            "\n\n少女はいつも通り少女と一緒に夕方まで遊び、\n\n「またね」と言って家に帰りました。",
            "\n\n\n\n家に帰ると、少女の両親と知らない男の人が少女の帰りを待っていました。",
            "\n\n\n\n彼の両親は今まで見たこともない笑顔で少女を迎え、知らない男は少女の方へ歩いてきました。",
            "\n\n\n\n\n\n???:「君はね、今年の魔王様へのイケニエに選ばれたんだよ。」",
            "\n\n\n\n\n\n少女:「イケニエってなあに？」",
            "\n\n\n\n\n\n???:「簡単に言うと、村の代表になって皆を護ることだよ。」",
            "\n\n\n\n\n\n\n\n少女はそれを聞いて誇らしい気持ちになっていました。",      
          ],
          [
            "???:「じゃあ、私はこれで。」",
            "そう言って男は立ち去りました。",
            "\n\nしばしの沈黙。",
            "\n\n\n\n父・母:「うわあああああ。」",
            "\n\n\n\n\n\n少女の両親が突然泣き出してしまいました。",
            "\n\n\n\n\n\nその表情は先ほどの笑顔とかけ離れているようで、あまり違いがないようにも見えました。",
            "\n\n\n\n\n\n\n\n父:「なぁ、お父さんたちとこの村を出よう。」",
            "\n\n\n\n\n\n\n\n\n\nそう言って父は少女にイケニエとは何なのかを告げました。",
          ],
        ],
        #3日目の終了
        [
          [
            "こうして1日が終わった。",
            "\n\n魔王討伐まであと4日",
          ],
          [
            "ある少女の夢を見た。",
            "\n\nイケニエとして捧げられる2日前、少女と両親は村を出る準備を完璧に済ませ、家を出ました。",
            "\n\n少女達は、出発から10分足らずで村を抜け出すことに成功し、\n\n1時間程村から離れるために歩き続けました。",
            "\n\n\n\n少女:「お父さん、疲れた。」",
            "\n\n\n\n父:「そうか、じゃあここで少し休憩しよう。村からも結構離れたからな。」",
            "\n\n\n\n\n\nそう言って父が地面に座ろうとしたとき、",
          ],
          [
            "グサッ",
            "\n\n何か音がしたと思い少女が後ろを振り返ると、",
            "\n\nそこには、倒れた父の姿とその背中に刺さった矢、\n\nその矢からあふれ出んばかりの大量の血がありました。",
            "\n\n\n\n\n\n母:「きゃああああ、あなた。」",
            "\n\n\n\n\n\n\n\nそう言って母が父に近づこうとしたとき、",
            "\n\n\n\n\n\n\n\n\n\n父:「こっちに来るな、バカ。早く逃げろ。」",
            "\n\n\n\n\n\n\n\n\n\n\n\nそれが父が気力をふり絞ってはなった最後の言葉でした。",
          ],
          [
            "その直後、周りから大勢の兵士が現れ、少女たちを包囲していました。",
            "そして少女と母はあっけなく兵士の人たちに捕まってしまいました。",
            "兵士:「国王様に逆らった罰だ。」",
            "兵士はそう言って、母の首を剣ではねました。",
            "直後、少女は意識を失いました。",
            "\n\n\n\n\n少女が目を覚ましたとき、少女は裸で石の台の上にいました。",
            "\n\n\n\n\n\n\n???:「よお、お目覚めかい。」",
          ],
        ],
        #4日目の終了
        [
          [
            "こうして1日が終わった。",
            "\n\n魔王討伐まであと3日",
          ],
          [
            "ある少女の夢を見た。",
            "\n\n少女が目を覚ました時、彼の隣には今にも消えてしまいそうなナニカがいました。",
            "\n\nそれは、どう見てもニンゲンではないナニカでした。",
            "\n\n少女:「君は誰?」",
            "\n\n???:「俺はな、人間には魔王って呼ばれてるもんでよ」",
            "\n\n\n\n魔王:「そんな事よりよ、お前あの兵士達が憎くはねえか？」",
            "\n\n\n\n突然そんなことを言ってきた。",
            "\n\n\n\n少女:「・・・」",
            "\n\n\n\n少女は何も答えない。",
          ],
          [
            "魔王:「分かった。お前、俺が魔王って聞いてビビってんだろ。」",
            "少女:「・・・」",
            "少女は何も答えない。",
            "魔王:「いや俺はな、お前の復讐を助けてやろうかなって思ってんだよ。」",
            "少女:「フク、、シュウ？」",
            "魔王:「お前の両親を殺した兵士に痛い目を見させてやろうって言ってんだよ。」",
            "少女:「した、、い。」",
            "魔王:「そうか。じゃあ俺がお前の復讐を手伝ってやる。代わりに、、、」",
            "少女:「代わり？」",
            "魔王:「そりゃ条件付きに決まってるだろ。お前の体を俺によこせ。」",
            "少女:「何で？」",
            "魔王:「見ての通り、今の俺は消えかけてる。\n\nしかしだ、お前は自身は気づいてないかもしれんが、お前の中に眠る魔力はとんでもない。\n\nだからお前の体が欲しいんだよ。」",
          ],
          [
            "少女:「もしも、私が嫌って言ったら？」",
            "結構減っちまうが、お前を殺して魔力を貰う。",
            "処女は考えた。今この場で殺されるか、\n\n体を乗っ取られてでもあの兵士の人達をこらしめるか。",
            "\n\n少女:「いいよ、私の体を乗っ取って。その代わりちゃんとこらしめてよね。」",
            "\n\n魔王:「ああ、もちろん。それは保障しよう。」",
            "\n\n\n\n魔王:「では始めるぞ。」",
            "\n\n\n\n\n\nこうして少女の体は魔王のものになった。"
          ],
        ],
        #5日目の終了
        [
          [
            "こうして1日が終わった。",
            "\n\n魔王討伐まであと2日",
          ],
          [
            "ある少女の夢を見た。",
            "\n\n少女の過ごす日々は地獄そのものだった。",
            "\n\n確かに魔王は少女が住んでいた村を焼き払い、そこから逃げた者は魔法で拘束しなぶり殺した。",
            "\n\n当然、その中にはあの少年もいた。",
            "\n\n\n\n少女:「もうやめて！！！！！！」",
            "\n\n\n\n\n\nそんな少女の叫びも外に聞こえることも、魔王の耳に届くことも無かった。",
            "\n\n\n\n\n\n少女は体を動かすこともできず、魔王が繰り広げる惨劇を見る事しかできない。",
          ],
          [
            "それからも魔王は他の村や国を滅ぼし続けました。",
            "人を殺して得られる経験値の快感も、少女にとってはただの拷問でしかありませんでした。",
            "そして、少女はその様を永遠と見続けるうち、\n\n全てを諦め、「殺してほしい」という思いだけを持つようになりました。",
          ]
        ],
        #6日目の終了
        [
          [
            "こうして1日が終わった。",
            "\n\n魔王討伐まであと1日",
          ],
          [
            "ある少女の夢を見た。",
            "\n\nある日、少女の前に、一人の男が現れました。",
            "\n\nその男は、今まで少女が見てきたどの兵士よりも強かった。",
            "\n\n少女は、「今度こそ殺してもらえる」と思い、目の前の戦いを見ていました。",
            "\n\nしかし、そんな男でも魔王を殺すには至りませんでした。",
            "\n\n激しい戦いの末、男は魔王を封印することに成功しました。",
            "\n\n少女は死ねなかった絶望と同時に、希望を持ちました。",
            "\n\n\n\nもしかしたら、この封印が解ける頃には、この魔王を殺す人が現れるのではないかと。",
          ],
        ],
        #7日目の終了
        [
          [
            "こうして1日が終わった。",
            "\n\nついに明日、魔王討伐が始まる。",
          ],
        ],
        #会話1(liria)
        [
          [
            "???:「あっ！、、、久しぶり、、」",
            "もぐもぐ、、、もぐもぐ、、、",
            "私:「いっつも何か食べてるねリーリア。」",
            "\n\n店に入った瞬間、見知った顔が目に入った。",
            "\n\n到底人が食えるとは思えない量のパスタをむさぼってる女はリーリアという私の幼馴染だ。",
            "\n\n\n\n私:「何でそんなに食べて太らないの？」",
            "\n\n\n\nリーリア:「そんなの知らないよ。才能ってやつ？」",
            "\n\n\n\nなんだろう、無性に腹が立つ。",
          ],
          [
            "リーリア:「はぁ？魔王と戦うことになった！！！！？？？？？」",
            "私:「シッ！！声が大きいよ。」",
            "リーリア:「だって、信じられなくて。大丈夫なの？」",
            "私:「だってしょうがないでしょ、王の奴から直接言われちゃったんだから。」",
            "リーリア:「でも、、、」",
          ],
        ],
        #選択肢1
        [
          [
            "私:「いーきーたーくーなーいーー」",
            "リーリア:「えっ！？」",
            "私:「私だって怖いよー、行きたくないよー。」",
            "リーリア:「そうよね、分かるわよ」",
            "\n\nリーリアに慰められながら、気づいたら1時間位騒いでいた。",
            "\n\n\n\nリーリアの好感度が少し下がった。",
          ],
        ],
        #選択肢2
        [
          [
            "私:「大丈夫、きっと何とかなるよ」",
            "リーリア:「根拠は？」",
            "そんなものはない。今の私では魔王には到底及ばないだろうから。でも、、、",
            "私:「倒すよ、絶対。だから信じて待ってて！」",
            "リーリア:「ほんとずるいよね。そういうとこ、、、」",
            "私:「私、この小盛ピザ食べようかな。」",
            "リーリア:「かしこまりました！！」",
            "なんで店側みたいに言ってんの？客だよねあなた。",
            "リーリアと一緒にご飯を食べた。",
            "\n\nリーリアの好感度が上がった",
            "\n\n30分が経過した。",
          ],
        ],
        #選択肢3
        [
          [
            "私:「とりあえず、何かたべようかな。リーリアのおすすめある？」",
            "リーリアの顔が明るくなった。",
            "リーリア:「そうだなー、このお店で一番美味しいのはこのピザでしょ。\n\n一番おいしい。」",
            "\n\n私:「じゃあこのピザ食べようかな。」",
            "\n\n\n\n忘れてた。",
            "\n\n\n\nこの店の驚異的なボリュームを。食べきるのに2時間かかった。",
            "\n\n\n\n\n\nリーリアの好感度が少し上がった。",
          ],
        ],
        #会話2(liria)
        [
          [
            "リーリア:「あっ」\n\n私:「あっ」",
            "\n\n店に入ろうとしたら偶然リーリアにあった。",
            "\n\nいや、リーリアは毎日ここら辺の店にいるんだけど、、、",
            "\n\nリーリア:「せっかくだから一緒に食べようよ。」",
            "\n\n私:「うん。いいよ。」",
            "\n\n二人で店に入った。"
          ],
          [
            "リーリア:「ねー、このパスタとこのグラタンどっちがいいかな？」",
            "いや、そういうのはこう、服屋とかおしゃれな場所で発生するイベントでは？",
          ],
        ],
        #選択肢1
        [
          [
            "私:「リーリアってパスタが一番好きだったよね、、、じゃあパスタで。」",
            "リーリア:「やっぱりそう思う。じゃあパスタにしようかな。」",
            "最初から決まっていたのでは？",
            "私:「私はこの小盛アクアパッツァにしようかな。」",
            "\n\nちなみに、「小盛」と言っているがサイズはちょっと多いくらいだ。",
            "\n\n\n\nリーリアの好感度が上がった。",
            "\n\n\n\n30分が経過した。",
          ],
        ],
        #選択肢2
        [
          [
            "私:「じゃあ、、、グラタンで。」",
            "リーリア:「あーーー、じゃあグラタンにしようかな。」",
            "不服だよねあなた。明らかに不服だよね。",
            "私:「じゃあ私はこのアクアパッツァで。」",
            "\n\n\n\n忘れてた。",
            "\n\n\n\nこの店の驚異的なボリュームを。食べきるのに2時間かかった。",
            "\n\n\n\n\n\nリーリアの好感度が少し上がった。",
          ],
        ],
        #選択肢3
        [
          [
            "私:「決めかねてるの？」",
            "リーリア:「うん。どっちにしようかなって。」",
            "私:「じゃあ私がグラタン頼むから、リーリアはパスタ頼みなよ。」",
            "リーリア:「、、、、、シェアってこと？」",
            "あれ？なんか凄い嫌そうじゃない？",
            "私:「どう、、、したの？」",
            "リーリア:「私、、、、シェアするタイプの人嫌い。」",
            "私:「、、、じゃあグラタンで。」",
            "リーリア:「じゃあそうする。」",
            "すごい空気になってしまった。",
            "\n\nリーリアの好感度が下がった。",
            "\n\n30分が経過した。"
          ],
        ],
        #会話3(liria)
        [
          [
            "店に入ったとき、中にはいつも通りリーリアが、、、",
            "いなかった",
            "私:「店長！リーリアは今日来てないの？」",
            "店長:「そういえば、まだ今日は来てないね。」",
            "私:「どうしたんだろう？」",
            "店長:「確かにおかしいね。あの子が、、、」"
          ],
        ],
        #選択肢1
        [
          [
            "何事も何か口にしないと始まらない。",
            "私:「店長、パスタください。」",
            "店長:「あっああ、、、でも良いのかい？」",
            "私:「・・・」",
            "リーリア、このパスタ好きだったな",
            "もうこの世にいない彼女のためにこのパスタを食べよう。",
            "店長:「何か勝手に死んでることになってない？」",
            "\n\nリーリアの好感度が大幅に下がった。",
            "\n\n2時間が経過した。"
          ],
        ],
        #選択肢2
        [
          [
            "私:「とりあえず、リーリアの家に行ってみます。何かあったのかも。」",
            "店長:「そうかい。行ってらっしゃい。」",
            "私:「はい、行ってきます。」"
          ],
          [
            "リーリアの家に着いた。",
            "家からはガサガサと大きな音がしている。",
            "\n\nとりあえず中に入ってみよう。",
            "\n\n私:「リーリア？」",
            "\n\n返事はない。",
            "\n\n私:「入るよ、、、」",
            "\n\n\n\n家の中は綺麗だった。とりあえず音のする方へ行ってみる。",
            "\n\n\n\nそこには押し入れで何やらガサガサしているリーリアがいた。",           
          ],
          [
            "私:「リーリア、何してるの？」",
            "リーリア:「あっ！！ごめん気づかなかった。」",
            "私:「そんなことより何してるの？」",
            "リーリア:「いや、、あの、、ちょっと探し物してて。」",
            "私:「今日はいつもの店行かないの？」",
            "リーリア:「後で行くよ。先行ってて。」",
            "私:「分かった。とりあえず無事で良かった。」",
            "リーリア:「無事？ハハハ、大丈夫だよ、私強いし。」",
            "私:「そう、じゃあ先行ってるよ。」",
            "リーリア:「はいよ～。」",
            "そう言ってリーリアの家を後にした。",
            "その後しばらく待ったがリーリアは店には現れなかった。",
            "\n\nリーリアの好感度が大幅に上がった。",
            "\n\n3時間経過した。"
          ]
        ],
        #選択肢3
        [
          [
            "私:「とりあえずリーリアを探しに言ってくる。何かあったかもしれないし。」",
            "店長:「そうかい。行ってらっしゃい。」",
            "そうして店を出た",
            "とりあえず河川敷に行ってみよう。",
            "理由なんてない、なんとなくそう思ったから。",
            "\n\n河川敷に着いたが誰もいなかった。",
            "\n\n何でここに来ようと思ったんだろう？",
            "\n\n\n\nリーリアの好感度が少し上がった。",
            "\n\n\n\n1時間が経過した。",
          ],
        ],
        #成功(liria)
        [
          [
            "リーリア:「あっ、やっと来た。」",
            "私:「別に待ち合わせしてないでしょ。」",
            "リーリア:「そんなことより、早く座る座る。」",
            "今日のリーリアはやけに起源が良いように見える。",
            "私:「どうしたのリーリア。何か変だよ。」",
            "リーリア:「ふふふふ、じゃーん。これ覚えてる。」",
            "リーリアが出してきたのは1つのペンダントだ。",
          ],
          [
            "私:「これ、、、」",
            "リーリア:「そう！これ君が初めて私にくれたプレゼント。」",
            "私:「まさか、、、」",
            "リーリア:「昨日これ探してたからお店来れなかったの。」",
            "私:「そうだったんだ。」",
            "リーリア:「これあげる。」",
            "私:「いいの？」",
            "リーリア:「私にはこれくらいしか出来ないから。」",
            "\n\nリーリアに思い出のペンダントを貰った。"
          ],
          [ 
            "「思い出のペンダント」\n\n私が初めてリーリアにプレゼントしたペンダント。\n経験値が2倍になる。",
          ],
        ],
        #失敗(liria)
        [
          [
            "店に入った。",
            "リーリアはいなかった。",
            "私:「店長！リーリアは今日も来てないの？」",
            "店長:「あの子最近全然来ないのよ。前は毎日来てたのに。」",
            "私:「そうなんだ。」",
            "それから、私がリーリアに逢うことは無かった。"
          ],
        ],
        #encountマックス
        [
          [
            "もう行かなくて良いだろう。",
          ],
        ],
        #会話1(srag)
        [
          [
            "良いクエストがないかとギルドに来たものの、あまり良いものは無かった。",
            "私:「はぁ、だめか。地道に稼ぐしかないのかなー。」",
            "???:「おう、久しぶりだな。」",
            "突然話をかけられ振り向くと見覚えのある奴がいた。",
            "私:「おう、スラグ！！」",
            "この見た目は凄いいかつい男はスラグという冒険者だ。",
            "私がギルドで初めて出来た友達であり、正直唯一のギルド友達だ。",
            "スラグ:「浮かない顔してるがどうしたんだ？」",
            "私:「いやー、お金か経験値がいち早く欲しいんだけど、\n\n良いクエストが無くて。」",
            "\n\nスラグ:「ほう、、、」",
            "\n\n何かスラグが悪いことを考えてる気がする。"
          ],
          [
            "スラグ:「そんなお前に朗報だ。」",
            "私:「え？」",
            "スラグ:「何か最近、新しいダンジョンが見つかったんだよ。\n\nでな、そのダンジョンにはどうやらお金を増やせる宝があるらしいだよ。」",
            "\n\n私:「まさか？」",
            "\n\nスラグ:「そう！それを見つけに行こうってことだよ。\n\nただし、そのダンジョンでは経験値が一切手に入らないらしい。」",
            "\n\n\n\n私:「つまり？」",
            "\n\n\n\nスラグ:「そう！見つけない限りずっと無駄骨ってこと。」",
          ],
        ],
        #選択肢1
        [
          [
            "私:「そのダンジョン、私も参加するよ。」",
            "スラグ:「そうかそうか。そう言ってくれると思ったぜ。」",
            "私:「その代わり、探索時間は毎回1時間でお願い。」",
            "スラグ:「少し短い気もするが、まぁしゃあないな。」",
            "スラグとダンジョン調査の書類を提出した",
            "手続きに手間取って1時間かかってしまった。",
          ],
        ],
        #選択肢2
        [
          [
            "私:「断る。そんな余裕はない。」",
            "スラグ:「そうか、じゃあ他の奴探してみるか。話聞いてくれてありがとな。」",
            "そう言ってスラグは立ち去った。",
            "30分経過した。",
          ],
        ],
        #選択肢3
        [
          [
            "私:「他にも何か秘密あるでしょ、それ。」",
            "スラグ:「ないよ別に。\n\n強いて言えば、そこのモンスターは強力でギルドも調査手間取ってるらしいってくらいだ.」",
            "\n\n私:「でもそれ、逆に言うと、、、」",
            "\n\nスラグ:「そう！未発見の他の宝もあるかもしれないって事だ。」",
            "\n\n私:「よし乗った。私もそのダンジョン調査に参加するよ。」",
            "\n\nスラグ:「そうかそうか、じゃあ手続きしに行こうぜ。」",
            "\n\nスラグとダンジョン調査の書類を提出した",
            "\n\n30分経過した。"
          ],
        ],
        #会話2(srag)
        [
          [
            "スラグ:「おっ、来たか。じゃあ行きますか。」",
            "私:「うん、行こう。」",
          ],
          [
            "スラグ:「そういえば、何でお前良いクエスト探してたんだ？」",
            "私:「実は、魔王討伐の任務受けちゃったんだよ。」",
            "スラグ:「魔王！？マオウってあの魔王か？」",
            "私:「そう、その魔王だよ。\n\nだから急いでレベル上げとかしなきゃ行けないんだ。」",
            "\n\nスラグ:「そうか、、、じゃあさっさと見つけちまおう。」",
            "\n\n私:「そうだね。」",
            "\n\nさて、分かれ道か、、、"
          ],
        ],
        #選択肢1
        [
          [
            "私:「左に行こう。」",
            "スラグ:「根拠は？」",
            "私:「無い。」",
            "スラグ:「よし、行こう。」",
            "\n\n左の道に行ってすぐ、異変に気が付いた。",
            "\n\n私:「止まって。」",
            "\n\nスラグ:「どうした。」",
            "\n\n私:「何か空気がおかしい。」",
            "\n\n少し顔を出し、前方を見据えた。",
            "\n\nそこには、ドラゴンが一人立ちはだかるように立っていた。",
            "\n\nスラグ:「あれはアシッド・ドラゴンだな。」",
            "\n\nアシッド・ドラゴンは上級の冒険者でも苦戦するレベルのモンスターだが、",
          ],
          [
            "スラグ:「今回はこのくらいで引き上げて準備しよう。」",
            "スラグの判断は正しい、アシッド・ドラゴンは行動する度酸を吐き出す。",
            "そのため、基本的には長期戦になるほどこちらが不利になってしまう。",
            "私:「そうだな、今回は引き上げよう。」",
            "\n\n私たちはダンジョンを引き上げた。",
            "\n\n1時間経過した。"
          ],
        ],
        #選択肢2
        [
          [
            "しばらく真ん中の道を進むと、一つのボタンがあった。",
            "スラグ:「押してみるか？」",
            "私:「・・・」",
            "おそらくスラグは押す気はない。",
            "スラグがみたいのはボタンを押すときに発生する罠を確認しておきたいのだ。",
            "私:「慎重にな。」",
            "スラグ:「分かってるって。」",
          ],
          [
            "スッ",
            "\n\nスラグの足元から音がした。",
            "\n\nスラグ:「え？」",
            "\n\n瞬間,",
            "\n\n\n\nドーーン",
            "\n\n\n\n\n\nスラグの足元が爆発した。",
            "\n\n\n\n\n\n私:「スラグ！！！！」",
            "\n\n\n\n\n\nスラグ:「いってぇ。」",
          ],
          [
            "スラグの脚はぼろぼろになっていた。",
            "私:「とりあえずギルドに帰るぞ」",
            "スラグ:「ちくしょう、すまねえ。俺のミスだ。」",
            "私:「しょうかないよ。とりあえず今回はこのダンジョン諦めよう。」",
            "スラグ:「・・・」",
            "何も言わない。私たちはギルドに帰り、スラグの処置をしてもらった。",
            "\n\n30分経過した。"
          ]
        ],
        #選択肢3
        [
          [
            "右の道をしばらく歩いて気が付いた。",
            "私:「ここ迷路じゃない？」",
            "スラグ:「そうだな、とりあえず抜けるまではダンジョン抜けれねえな。」",
            "私:「しょうがない、攻略しよう。」",
            "\n\nそこから2時間程かけて私たちは迷路を抜けた。",
          ],
          [
            "私:「止まって。」",
            "スラグ:「どうした。」",
            "私:「何か空気がおかしい。」",
            "少し顔を出し、前方を見据えた。",
            "そこには、ドラゴンが一人立ちはだかるように立っていた。",
            "スラグ:「あれはアシッド・ドラゴンだな。」",
            "アシッド・ドラゴンは上級の冒険者でも苦戦するレベルのモンスターだが、",
            "スラグ:「今回はこのくらいで引き上げて準備しよう。」",
            "スラグの判断は正しい、アシッド・ドラゴンは行動する度酸を吐き出す。",
            "そのため、基本的には長期戦になるほどこちらが不利になってしまう。",
            "私:「そうだな、今回は引き上げよう。」",
            "\n\n私たちはダンジョンを引き上げた。",
            "\n\n2時間経過した。"
          ],
        ],
        #成功(srag)
        [
          [
            "前回のルートから、あのドラゴンの近くまで向かった。",
            "スラグ:「よし、じゃあ始めるぞ。」",
            "スラグは100個近い爆弾の準備を始めた。",
            "スラグはボマーという役職で、爆弾を駆使して戦っている。",
            "その腕前は一級品で、多人数パーティでも問題なく戦える。"
          ],
          [
            "スラグ:「5、、4、、、3、、、2、、1、、Go」",
            "その瞬間、スラグは大量の爆弾をドラゴンに投げつけた。",
            "爆発の度、ドラゴンから酸が飛び出しているのが分かる。",
            "ドラゴンがこちらに近づいてきた刹那、",
            "\n\nドーーン",
            "\n\n\n\nスラグが仕掛けていた設置型爆弾が軌道した。",
          ],
          [
            "スラグ:「今だ！！！」",
            "私:「くらええええええええ！！！！」",
            "渾身の一撃をドラゴンの首めがけてはなった。",
            "\n\nドラゴンの首は切断され、倒れた。",
            "\n\nスラグ:「よっっしゃあああああ！！」\n\n私:「やったああああああああ！！」",
          ],
          [
            "ドラゴンを討伐した私たちは、奥にあった扉を開けた。",
            "そこには、一つの腕輪があった。",
            "スラグ:「これだけか？」",
            "私:「これがお金を増やす宝。」",
            "スラグ:「これお前にやるよ。」",
            "私:「いいのか？ドラゴンを倒せたのはスラグのおかげなのに。」",
            "スラグ:「とどめをさしたのはお前だろ。じゃあお前が使え。」",
            "私:「ありがとう。使わせてもらいます。」",
            "スラグ:「おう、貸し1な。魔王、絶対倒せよ。」",
            "私:「ああ、任せろ。」"
          ],
          [
            "国王の腕輪\n\nかつての国王が愛用していたという腕輪。宝石や金が埋め込まれている。\nお金の取得量が2倍になる。",
          ]
        ],
        #会話1(魔王戦闘前)
        [
          [
            "目が覚めた。",
            "いよいよ、魔王との決戦が始まる。",
            "\n\nドーーーン！！！！",
            "\n\n\n\n私:「来た、、、ついに」",
            "\n\n\n\n震えが止まらない。",
            "\n\n\n\nでも、行くしかない。私がやるしかない。",
            "\n\n\n\n\n私は魔王の前に飛び出した。",
          ],
          [
            "私:「おい、そこの間抜け面！！！」",
            "魔王:「あ？誰だお前。」",
            "私:「私はお前を倒すものだ。」",
            "魔王:「は？貴様がか？アッハハハハ、、、」",
            "魔王が爆笑している。なんなんだこいつ。",
            "魔王:「悪いことは言わん、逃げたほうがいいぞ。」",
            "私:「こっちはな、お前のためにしっかり修行してんだよ。」",
            "魔王:「どのくらい？」",
            "私:「え？」",
            "魔王:「どのくらい修行したんだ？」",
            "私:「、、、一週間」",
            "魔王:「は？お前、、、俺のことなめてるよな」",
            "私:「(￣∇￣;)ハッハッハ」",
            "魔王:「ぶっ殺す、後悔しても遅いからな！！！」",
            "ついに、世界の命運をかけた戦いが始まる。"
          ],
        ],
        #会話2(魔王戦闘後)
        [
          [
            "こうしてこの物語は終焉を迎えた。",
          ],
        ],
      ]
    end

    #シナリオ進行
    def scene(scenario,turn,num)
      pos_y=0
      scenario[turn][0..num].each_with_index do |n,i|
        pos_y=100+i*(SIZE*2)
        message("#{n}",80,pos_y,@font)    
      end
      
      if scenario[turn][num]==nil
        if scenario[turn+1]==nil
          return 2
        else
          return 0
        end
      else 
        return 1
      end
    end

    #キーボード入力確認
    def tale(scene_num,picture)
        if scene(@scenario[scene_num],@page,@story_num)==0
          @page+=1
          @story_num=0
        elsif scene(@scenario[scene_num],@page,@story_num)==1
          if Input.key_push?(K_RETURN)
              @story_num+=1
          elsif Input.key_push?(K_LEFT)
              @page-=1
              @story_num=0
          end
        elsif scene(@scenario[scene_num],@page,@story_num)==2
          @page=0
          @story_num=0
          return 1
        end

        #背景を描画
        if scene_num==0 && @page==3 || scene_num==1 || scene_num==2 || scene_num==3 || scene_num==4 
          Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.castle_back)
        end

    end
end

story=Story.new

###############################社長クラス########################################################################################################################################################################
intro_font = Font.new(25)
#画像登録
class Picture
  attr_accessor :title_img,:title_name,:chara_pick,:castle_back,:red_frame,:battle_frame,:boss_frame,:woman1_normal,:woman1_pinchi,:woman1_tere,:woman2_normal,:woman2_pinchi,:woman3_normal,:woman3_pinchi,:man1_normal,:man1_pinchi,:man2_normal,:man2cls_pinchi,:man3_normal,:man3_pinchi,:enemy_goblin,:enemy_king,:nemy_goblin_face,:enemy_king_face,:town_noon,:town_night 
  def initialize
    #タイトル画面背景
    @title_img = Image.load("images/タイトル.jpg")
    #タイトル画像
    @title_name = Image.load("images/title_logo.png")
    #キャラ選択画面背景
    @chara_pick = Image.load("images/キャラ選択_背景.jpg")
    @castle_back = Image.load("images/castle_back.jpg")
    #赤枠
    @red_frame = Image.load("images/frame.png")
    #バトル下枠背景
    @battle_frame = Image.load("images/battle_back.png")
    #魔王戦背景
    boss_frame = Image.load("images/魔王城.png")
    #女性キャラ1
    @woman1_normal = Image.load("images/chara/woman1/face_normal.png")
    @woman1_pinchi = Image.load("images/chara/woman1/face_pinchi.png")
    @woman1_tere = Image.load("images/chara/woman1/face_tere.png")
    #女性キャラ2
    @woman2_normal = Image.load("images/chara/woman2/face_normal.png")
    @woman2_pinchi = Image.load("images/chara/woman2/face_pinchi.png")
    #woman2_tere = Image.load("images/chara/woman2/face_tere.png")
    #女性キャラ3
    @woman3_normal = Image.load("images/chara/woman3/face_normal.png")
    @woman3_pinchi = Image.load("images/chara/woman3/face_pinchi.png")
    #woman1_tere = Image.load("images/chara/woman1/face_tere.png")
    #男性キャラ1
    @man1_normal = Image.load("images/chara/man1/face_normal.png")
    @man1_pinchi = Image.load("images/chara/man1/face_pinchi.png")
    #男性キャラ2
    @man2_normal = Image.load("images/chara/man2/face_normal.png")
    @man2cls_pinchi = Image.load("images/chara/man2/face_pinchi.png")
    #男性キャラ3
    @man3_normal = Image.load("images/chara/man3/face_normal.png")
    @man3_pinchi = Image.load("images/chara/man3/face_pinchi.png")
    #敵キャラ
    @enemy_goblin = Image.load("images/enemy/1001010401.png")
    #敵キャラ2
    @enemy_king = Image.load("images/enemy/1322010402.png")
    #敵アイコン
    @enemy_goblin_face = Image.load("images/enemy_face/face_1.png")
    #ボスアイコン
    @enemy_king_face = Image.load("images/enemy_face/face_2.png")
    #行動選択背景(昼)
    @town_noon = Image.load("images/town_noon.jpg")
    #行動選択背景(夜)
    @town_night = Image.load("images/town_night.jpg")
  end
end

picture=Picture.new

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
    #画像
    #タイトル画面背景
    title_img = Image.load("images/タイトル.jpg")
    #タイトル画像
    title_name = Image.load("images/title_logo.png")

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
  def battle_now(hero,enemy,field,merchant,first,diff_level,liria,srag)
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
    enemy.set_status(diff_level,hero,field,liria,srag)
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
          #敵の行動で死ぬ場合
          if hero.hp <= 0
            return
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
          #敵の行動で死ぬ場合
          if hero.hp <= 0
            return
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
  #HP残量チェック
  def check_hp()
    if @hp <= 0
      return true
    else
      return false
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
  def set_status(stage_level,hero,field,liria,srag)
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
    if liria.party==true
      @exp=@exp.to_i*2
    else
      @exp = @exp.to_i
    end
    #お金
    if srag.party==true
      @money = (@exp / 1.5) * 5
    else
      @money = (@exp / 1.5) * 2.5
    end
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

#オブジェクト生成
field = Field.new
hero = Hero.new
enemy = Enemy.new
merchant = Merchant.new

################################################################################################################################################################################################################

####################################################スキルツリー##################################################
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
      attr_accessor :node_num, :node_name, :parent, :children, :effected_status, :effect_value, :need_money, :release_flag, :x, :y
  end

  def initialize
      @node_max_num = 29
      @root_x = (Window.width-200)/2
      @root_y = Window.height/2
      @max_depth = 3
      #スキルツリーのノード[ノードの名前,影響を与えるステータス,変化値,必要なゴールド,x座標,y座標]
      @tree_nodes = [
             ["魔王へ挑む者","root",0,0,@root_x,@root_y],#0

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
             ["ずのう+","bra",150,200,@root_x+200,@root_y-100],#12
             ["ずのう++","bra",200,300,@root_x+300,@root_y-100],#13
             ["ずのう+++","bra",300,500,@root_x+300,@root_y-200],#14

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
      @node_icon["root"] = Image.load("images/node_icons/root.png")#ルートノード画像
      @node_icon["hp"] = Image.load("images/node_icons/hp1.png")#HPノード画像
      @node_icon["mp"] = Image.load("images/node_icons/mp1.png")#MPノード画像
      @node_icon["pow"] = Image.load("images/node_icons/pow1.png")#POWERノード画像
      @node_icon["bra"] = Image.load("images/node_icons/bra1.png")#BRAINノード画像
      @node_icon["def"] = Image.load("images/node_icons/def1.png")#DEFENCEノード画像
      @node_icon["spe"] = Image.load("images/node_icons/spe1.png")#SPEEDノード画像
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
          @root.release_flag = 1
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
      hero.money -= node.need_money
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
          if node.release_flag == 0
              Window.draw_ex(node.x-nodew, node.y-nodeh, @node_icon[node.effected_status], scale_x:0.15, scale_y:0.15,center_x:nodew,center_y:nodeh, alpha:100,z:2)
          elsif node.release_flag == 1
              Window.draw_ex(node.x-nodew, node.y-nodeh, @node_icon[node.effected_status], scale_x:0.15, scale_y:0.15,center_x:nodew,center_y:nodeh, alpha:255,z:2)
          end
          if node.children.empty?
              next
          end
      end
  end

  def detail_print(n,hero) #選択されたノードを渡す
      detail_font = Font.new(20)
      ui_font = Font.new(32)
      node_release_button = Image.load("images/node_release_button.png")
      Window.draw_morph(0,0,1024,0,1024,768,0,768,@tree_back_img,alpha:100)#背景描画
      node = get_node(n)
          x = Input.mouse_pos_x  # マウスカーソルのx座標
          y = Input.mouse_pos_y  # マウスカーソルのy座標
          detail_pos_y = 50 #説明文の1行目のy座標
          Window.draw_box_fill(801, 0, 1023, 767, C_WHITE, z=1) #220x767

          Window.draw_font(10, 10, "おわる:右クリック", detail_font, color:C_RED, z:2)
          Window.draw_font(850, detail_pos_y, "「#{node.node_name}」", Font.new(22), color:C_BLACK, z:2)
          if n != 0
              Window.draw_font(810, detail_pos_y + 30, "効果:", detail_font, color:C_BLACK, z:2)
              Window.draw_font(810, detail_pos_y + 50, "#{node.effected_status}が#{node.effect_value}増加します", detail_font, color:C_BLACK, z:2)
              Window.draw_font(810, detail_pos_y + 80, "金額:", detail_font, color:C_BLACK, z:2)
              Window.draw_font(810, detail_pos_y + 100, "#{node.need_money}G", detail_font, color:C_BLACK, z:2)
          end
          if hero.money >= node.need_money
              Window.draw_font(810, detail_pos_y + 200, "所持金:#{hero.money}G", detail_font, color:C_BLACK, z:2)
          else
              Window.draw_font(810, detail_pos_y + 200, "所持金:#{hero.money}G", detail_font, color:C_RED, z:2)
          end
          if (node.parent == nil || node.parent.release_flag == 1) && hero.money >= node.need_money
              alpha = 255
          else
              alpha = 50
          end
          if node.release_flag == 1
              Window.draw_font(870, detail_pos_y + 150, "開放済み", detail_font, color:C_RED, z:2)
          else
              Window.draw_alpha(911-node_release_button.width/2, 620,node_release_button, alpha, z=2) #開放ボタンの表示
          end
          #Window.draw_scale(890, 120, coin_img, 0.1, 0.1, z=5)

          if 830 <= x && x <= 990 && 620 <= y && y <= 700
              #コマンド選択画像
              Window.draw_box(911-node_release_button.width/2 - 5, 615, 911 + node_release_button.width/2 + 5, 615 + node_release_button.height + 5, C_BLACK, z=2)
              
              if Input.mousePush?(M_LBUTTON) && node.parent != nil && node.parent.release_flag == 1 && hero.money >= node.need_money
                  #強化処理
                  open_node(n,hero)
              end
          end
  end

  
  #マウスクリックされたら呼ばれる, ノード番号を返す
  def click_node(x,y,node) #nodeは前にクリックされたノードを入れる
      x = Input.mouse_pos_x  # マウスカーソルのx座標
      y = Input.mouse_pos_y  # マウスカーソルのy座標

      @node_max_num.times do |i|
          #マウスカーソルがノードi内にあるか
          if @tree_nodes[i][4] -50 < x && x < @tree_nodes[i][4] + 50
              if @tree_nodes[i][5] -50 < y && y < @tree_nodes[i][5] + 50
                  return i
              end
          end
      end
      return node #node以外をクリックした時は前にクリックされたノードを返す
  end
end 

def skilltree_loop(tree,hero)
  selected_node = 0 #初期化, rootにする
  
  Window.loop do
      x=Input.mouse_pos_x
      y=Input.mouse_pos_y
      tree.node_print
      if Input.mouse_push?(M_LBUTTON)
          selected_node = tree.click_node(x,y,selected_node)
      end
      if selected_node != nil #selected_nodeがnil以外の時
          #Window.draw_font(870, 50, "#{selected_node}", Font.new(32), color:C_BLACK, z:2) #debug用
          tree.detail_print(selected_node,hero)
      end
      if Input.mouse_push?(M_RBUTTON)
          return
      end
  end
end

tree=SkillTree.new
tree.init
#################################################################################################################
#キャラ選択
def chara_choice(hero,picture,intro_font)
   #変数等準備
   is_select_num = nil #どのキャラが選択されたか

   #選択画面
   Window.loop do

    #背景を描画
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.castle_back)

    #下の枠
    Window.draw_box_fill(80, 580, 946, 730, C_WHITE, z=0)

    #キャラの顔
    Window.draw_morph(80,80,280,80,280,280,80,280,picture.woman1_normal)
    Window.draw_morph(420,80,620,80,620,280,430,280,picture.woman2_normal)
    Window.draw_morph(760,80,960,80,960,280,760,280,picture.woman3_normal)
    Window.draw_morph(80,350,280,350,280,550,80,550,picture.man1_normal)
    Window.draw_morph(420,350,620,350,620,550,430,550,picture.man2_normal)
    Window.draw_morph(760,350,960,350,960,550,760,550,picture.man3_normal)

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
      Window.draw_morph(80,80,280,80,280,280,80,280,picture.red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 0 #天使
        break
      end
    elsif x >= 420 && x <= 620 && y >= 80 && y <= 280 #上段真ん中
      Window.draw_font(110, 600, "【迷い人】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "回避確率が非常に高く、防御力が高めです。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "攻撃はやや低めのため、序盤は苦戦するかもしれません。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(420,80,620,80,620,280,430,280,picture.red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 1 #迷い人
        break
      end
    elsif x >= 760 && x <= 960 && y >= 80 && y <= 280 #右上
      Window.draw_font(110, 600, "【魔法研究者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "MPと頭脳がとても高く、魔法に特化しています。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "その分、物理的な攻撃には弱いので、注意が必要です。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(760,80,960,80,960,280,760,280,picture.red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 2 #魔法研究者
        break
      end
    elsif x >= 80 && x <= 280 && y >= 350 && y <= 550 #左下
      Window.draw_font(110, 600, "【勇者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "クリティカル率が非常に高く、攻撃力も高いです。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ステータスはやや攻撃寄りですが、バランス型です。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(80,350,280,350,280,550,80,550,picture.red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 3 #勇者
        break
      end
    elsif x >= 420 && x <= 620 && y >= 350 && y <= 550 #下段真ん中
      Window.draw_font(110, 600, "【信仰者】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "神からの啓示で、先制を取りやすくなります。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "また、お金のドロップ量が比較的高めに設定されています。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(420,350,620,350,620,550,430,550,picture.red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 4 #信仰者
        break
      end
    elsif x >= 760 && x <= 960 && y >= 350 && y <= 550 #右下
      Window.draw_font(110, 600, "【旅人】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "長年の討伐経験から、経験値の取得率が高くなっています。", intro_font, color:[0,0,0], z:2)
      Window.draw_font(110, 680, "ただし、初期ステータスは低めに設定されています。", intro_font, color:[0,0,0], z:3)
      Window.draw_morph(760,350,960,350,960,550,760,550,picture.red_frame)
      if Input.mousePush?(M_LBUTTON)
        is_select_num = 5 #旅人
        break
      end
    else #デフォルト
      Window.draw_font(110, 600, "【キャラ選択】", intro_font, color:[255,0,0], z:1)
      Window.draw_font(110, 640, "冒険者の中から魔王討伐者を一人決めよう。", intro_font, color:[0,0,0], z:2)
      #Window.draw_font(110, 680, "キャラには固有の役職と能力があり、様々な作戦を取ることができます。", intro_font, color:[0,0,0], z:3)
    end

  end

  #主人公タイプ設定
  hero.set_hero_level(is_select_num)
end

###################################################
first = true
#変数等準備
diff_level = 1
###########################################################

#選択肢
def judge(a,b,c,judge_frame,judge_frame_in)
    branch=0
        x = Input.mouse_pos_x  
        y = Input.mouse_pos_y  
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
def move(judge_frame,judge_frame_in,clock,story)
    message("今から何をしようか",400,100,@font)
    branch=judge("バトル","ステータスツリー","会話",judge_frame,judge_frame_in)
    return branch
end

def output_limit(clock)
    now_prog(clock)
    if clock.minute<10 
        message("#{clock.hour}:0#{clock.minute}",100,60,@font)
    else 
        message("#{clock.hour}:#{clock.minute}",100,60,@font)
    end

    message("残り#{clock.date-clock.now_day}日",750,60,@font)
    if clock.now_time>clock.deadline
        finish(clock)
    end
end

def now_prog(clock)
    clock.hour=(clock.wake_up+clock.now_time)/60
    clock.minute=(clock.wake_up+clock.now_time)%60
end    

#メッセージ出力
def message(mes,pos_x,pos_y,font)
    Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5)    
end

###############################################
  #ターンをリセット(迷い人のラプソディ用)
  hero.limit_turn = 12

  #主人公を生成
  hero.set_status

  #「逃げる」フラグ
  hero.is_escaped = nil

  #「ぼうぎょ」コマンド
  hero.is_def = nil

  first = true

  #ちらつき対策
 # Window.update
###############################################


#main文
progress=-1
branch=0
Window.loop do
  #スタート画面
  if progress==-1
    title_start(picture,@font)
    diff_select(picture,@font,field)
    #ターンをリセット(迷い人のラプソディ用)
    hero.limit_turn = 12  
    #主人公を生成
    hero.set_status
    #「逃げる」フラグ
    hero.is_escaped = nil
    #「ぼうぎょ」コマンド
    hero.is_def = nil
    
    first = true
    
    #ちらつき対策
    Window.update
    progress=0

  #序章
  elsif progress==0
    if story.tale(0,picture)==1
      progress=1
    end
    Window.draw_alpha(50,30, frame, 128)
  #キャラクターセレクト
  elsif progress==1
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.castle_back)
    chara_choice(hero,picture,intro_font)
    progress=2
  #一章
  elsif progress==2
    if story.tale(1,picture)==1
      progress=3
    end
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.castle_back)
    Window.draw_alpha(50,30, frame, 128)

  #選択1(魔王討伐に行くか)
  elsif progress==3
  Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.castle_back)
  if branch==0
    message("どうしよう？",450,80,@font)
    branch=judge("魔王討伐に行く","断る","雑談をする",judge_frame,judge_frame_in)
  end

  #魔王討伐に行く
  if branch==1
    if story.tale(2,picture)==1
      progress=4
      branch=0
    end
  #断る
  elsif branch==2
    if story.tale(3,picture)==1
      progress=progress
      branch=0
    end
  #雑談をする
  elsif branch==3
    if story.tale(4,picture)==1
      progress=progress
      branch=0
    end
  end
  Window.draw_alpha(50,30, frame, 128)

  #行動選択
  elsif progress==4
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    branch=move(judge_frame,judge_frame_in,clock,story)
    if branch==1
      progress=5
    elsif branch==2
      progress=6
    elsif branch==3
      progress=7
      branch=0
    end
    output_limit(clock)
    Window.draw_alpha(50,30, frame, 128)
  #バトル
  elsif progress==5
    field.battle_now(hero,enemy,field,merchant,first,diff_level,liria,srag)
    if hero.hp>0
      progress=8
    else 
      progress=99
    end
  #ステータスツリー
  elsif progress==6
    skilltree_loop(tree,hero)
    progress=8
  #会話
  elsif progress==7
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    Window.draw_alpha(50,30, frame, 128)
    if branch==0
      message("どこへ行こう？",450,80,@font)
      branch=judge("ご飯でも食べようかな","ギルドに行こうか","やっぱりやめよう",judge_frame,judge_frame_in)
    end
    #選択1
    if branch==1
        if liria.encount==0
          if story.tale(15,picture)==1
            progress=10
            branch=0
          end
        elsif liria.encount==1
          if story.tale(19,picture)==1
            progress=11
            branch=0
          end
        elsif liria.encount==2
          if story.tale(23,picture)==1
            progress=12
            branch=0
          end
        elsif liria.encount==3
          if liria.love>=100
            if story.tale(27,picture)==1
              liria.party=true
              progress=13
              branch=0
            end
          elsif liria.love<100
            if story.tale(28,picture)==1
              progress=13
              branch=0
            end
          end
        else
          if story.tale(29,picture)==1
            progress=7
            branch=0
          end
        end
    #選択2
    elsif branch==2
        if srag.encount==0
          if story.tale(30,picture)==1
            progress=14
            branch=0
          end
        elsif srag.encount==1
          if story.tale(34,picture)==1
            progress=15
            branch=0
          end
        elsif srag.encount==2
          if story.tale(38,picture)==1
              srag.party=true
              progress=17
              branch=0
          end
        else
          if story.tale(29,picture)==1
            progress=4
            branch=0
          end
        end
    #選択3
    elsif branch==3
      branch=0
      progress=4
    end
  #行動終わり
  elsif progress==8
    if branch==1
      if story.tale(5,picture)==1
        clock.now_time=clock.now_time+180
        progress=4
        branch=0
      end
    elsif branch==2
      if story.tale(6,picture)==1
        clock.now_time=clock.now_time+120
        progress=4
        branch=0
      end
    elsif branch==3        
      progress=4
      branch=0
    end

    if clock.now_time>=clock.deadline
      progress=9
    end

  #1日の終わり
  elsif progress==9
    if clock.now_day==0
      if story.tale(8,picture)==1
        clock.now_day=clock.now_day+1
        clock.now_time=0
        progress=4
      end
    elsif clock.now_day==1
      if story.tale(9,picture)==1
        clock.now_day=clock.now_day+1
        clock.now_time=0
        progress=4
      end
    elsif clock.now_day==2
      if story.tale(10,picture)==1
        clock.now_day=clock.now_day+1
        clock.now_time=0
        progress=4
      end
    elsif clock.now_day==3
      if story.tale(11,picture)==1
        clock.now_day=clock.now_day+1
        clock.now_time=0
        progress=4
      end
    elsif clock.now_day==4
      if story.tale(12,picture)==1
        clock.now_day=clock.now_day+1
        clock.now_time=0
        progress=4
      end
    elsif clock.now_day==5
      if story.tale(13,picture)==1
        clock.now_day=clock.now_day+1
        clock.now_time=0
        progress=4
      end
    elsif clock.now_day==6
      if story.tale(14,picture)==1
        clock.now_day=clock.now_day+1
        clock.now_time=0
        progress=18
        enemy.bossflag = true      
      end
    end

  #会話1(rilia1)
  elsif progress==10
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    Window.draw_alpha(50,30, frame, 128)
    if branch==0
      message("なんて言おう",450,80,@font)
      branch=judge("駄々をこねる","安心させる","とりあえずご飯を食べる",judge_frame,judge_frame_in)
    end
    #選択1
    if branch==1
      if story.tale(16,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love-10
        clock.now_time=clock.now_time+60
      end
    #選択2
    elsif branch==2
      if story.tale(17,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love+20
        clock.now_time=clock.now_time+30
      end
    #選択3
    elsif branch==3
      if story.tale(18,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love+10
        clock.now_time=clock.now_time+120     
      end
    end
  #会話2(rilia2)
  elsif progress==11
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    Window.draw_alpha(50,30, frame, 128)
    if branch==0
      message("どうしよう",450,80,@font)
      branch=judge("パスタを選ぶ","グラタンを選ぶ","シェアをする",judge_frame,judge_frame_in)
    end
    #選択1
    if branch==1
      if story.tale(20,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love+20
        clock.now_time=clock.now_time+30
      end
    #選択2
    elsif branch==2
      if story.tale(21,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love+10
        clock.now_time=clock.now_time+30
      end
    #選択3
    elsif branch==3
      if story.tale(22,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love-20
        clock.now_time=clock.now_time+30
      end
    end
    #会話3(rilia3)
  elsif progress==12
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    Window.draw_alpha(50,30, frame, 128)
    if branch==0
      message("どうしよう",450,80,@font)
      branch=judge("とりあえず何か食べる","リーリアの家に行く","河川敷に行く",judge_frame,judge_frame_in)
    end
    #選択1
    if branch==1
      if story.tale(24,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love-50
        clock.now_time=clock.now_time+120
      end
    #選択2
    elsif branch==2
      if story.tale(25,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love+50
        clock.now_time=clock.now_time+180
      end
      #選択3
    elsif branch==3
      if story.tale(26,picture)==1
        branch=3
        progress=8
        liria.encount=liria.encount+1
        liria.love=liria.love+10
        clock.now_time=clock.now_time+60
      end
    end
  #会話4(rilia4)
  elsif progress==13
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    Window.draw_alpha(50,30, frame, 128)
    branch=3
    progress=8
    liria.encount=liria.encount+1
  #会話1(srag1)
  elsif progress==14
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    Window.draw_alpha(50,30, frame, 128)
    if branch==0
      message("どうする？",450,80,@font)
      branch=judge("行く","行かない","もう少し話を聞く",judge_frame,judge_frame_in)
    end
    #選択1
    if branch==1
      if story.tale(31,picture)==1
        branch=3
        progress=8
        srag.encount=srag.encount+1
        clock.now_time=clock.now_time+60
      end
    #選択2
    elsif branch==2
      if story.tale(32,picture)==1
        branch=3
        progress=8
        srag.encount=srag.encount+5
        clock.now_time=clock.now_time+30
      end
    #選択3
    elsif branch==3
      if story.tale(33,picture)==1
        branch=3
        progress=8
        srag.encount=srag.encount+1
        clock.now_time=clock.now_time+30
      end
    end
  #会話2(srag2)
  elsif progress==15
    Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
    Window.draw_alpha(50,30, frame, 128)
    if branch==0
      message("どこに行く？",450,80,@font)
      branch=judge("左","真ん中","右",judge_frame,judge_frame_in)
    end
    #選択1
    if branch==1
      if story.tale(35,picture)==1
        branch=3
        progress=8
        srag.encount=srag.encount+1
        clock.now_time=clock.now_time+60
      end
    #選択2
    elsif branch==2
      if story.tale(36,picture)==1
        branch=3
        progress=8
        srag.encount=srag.encount+5
        clock.now_time=clock.now_time+30
      end
    #選択3
    elsif branch==3
      if story.tale(37,picture)==1
        branch=3
        progress=8
        srag.encount=srag.encount+1
        clock.now_time=clock.now_time+120
      end
    end
    #会話3(srag3)
    elsif progress==17
      Window.draw_morph(0,0,1024,0,1024,768,0,768,picture.town_noon)
      Window.draw_alpha(50,30, frame, 128)
      branch=3
      progress=8
      srag.encount=srag.encount+1

    #魔王討伐
    elsif progress==18
      if story.tale(39,picture)==1  
        field.battle_now(hero,enemy,field,merchant,first,diff_level,liria,srag)
        if hero.hp>0
          progress=19
        else 
          progress=99
        end    
      end
    #エンディング
    elsif progress==19
      #エンディング処理
      if story.tale(40,picture)==1
        endroll
        gameclear
        break
      end
    elsif progress==99
      gameover
      break
    end
end

require 'dxruby'

#初期値
#画面サイズ
Window.width = 1024
Window.height = 768

TITLE=50
SIZE=20

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

#枠
frame=Image.new(924,700,[100,0,0])

#ストーリー
@font=Font.new(SIZE,fontname="MS 明朝")

#シナリオ
@story=[
    #序章(王様視点)
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
    #キャラ選択
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
    #会話1(tanaka)
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
    #会話2(tanaka)
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
    #会話1(suzuki)
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
    #会話2(suzuki)
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
]

#シナリオ
def scene(turn,num)
   
    @story[turn][0..num].each_with_index do |n,i|
       message("#{n}",50,50+i*(SIZE*2),@font)    
    end

    if @story[turn][num]==nil
        false
    else 
        true
    end
end

#キャラ選択
def chara_choice

end

#選択肢
def judge

end

#行動選択
def move
    message("今から何をしようか",50,50,@font)
    judge
end

#1日の流れ
def live

end

#メッセージ出力
def message(mes,pos_x,pos_y,font)
    Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5)    
end

#main文
story_num=0
page=0
Window.loop do
       if !scene(page,story_num)
            page+=1
            story_num=0
        else
            if Input.key_push?(K_RETURN)
                story_num+=1
            elsif Input.key_push?(K_LEFT)
                page-=1
                story_num=0
            end
        end
        Window.draw_alpha(50,30, frame, 128)
end
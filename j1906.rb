
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

class Story
    attr_accessor :scene_num,:page,:story_num
    def initialize
        @scene_num=0 #シナリオ番号
        @page=0      #ページ番号
        @story_num=0 #文章番号
    end
end

story=Story.new

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

end

#選択肢
def judge

end

#行動選択
def move
    message("今から何をしようか",50,50,@font)
    branch=judge
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

    message("残り#{clock.date-clock.now_day}",500,10,@font)
end

def now_prog(clock)
    clock.hour=(clock.wake_up+clock.now_time)/60
    clock.minute=(clock.wake_up+clock.now_time)%60
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
    Window.draw_alpha(50,30, frame, 128)
end
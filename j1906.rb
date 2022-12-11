
require 'dxruby'

#初期値
#画面サイズ
Window.width = 1024
Window.height = 768

TITLE=50
SIZE=20

#枠
frame=Image.new(924,700,[100,0,0])

#ストーリー
@font=Font.new(SIZE,fontname="MS 明朝")

#シナリオ
@story=[
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
]

#シナリオ
def scene(turn,num)
   
    @story[turn][0..num].each_with_index do |n,i|
       Window.draw_font(50,50+i*(SIZE*2),"#{n}",@font,z:5)    
    end

    if @story[turn][num]==nil
        false
    else 
        true
    end
end

#行動選択
def judge
    Window.draw_font(50,50,"今から何をしようか",@font,z:5)    
end

#1日の流れ
def live

end

#メッセージ出力
def message(mes,pos_x,pos_y)
    Window.draw_font(pos_x,pos_y,"#{mes}",@font,z:5)    
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

require 'dxruby'

#初期値
HEIGHT=1024
WIDTH=761

TITLE=50
SIZE=20

#ストーリー
@font=Font.new(SIZE,fontname="MS 明朝")

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

def judge
    Window.draw_font(50,50,"今から何をしようか",@font,z:5)    
end

def live

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
end
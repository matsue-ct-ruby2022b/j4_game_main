
require 'dxruby'

#�X�g�[���[
@font=Font.new(SIZE,fontname="MS ����")

@story=[
    [
        "����������",
        "����������",
        "����������",
        "����������",
    ],
    [
        "����������",
        "����������",
        "����������",
        "����������",
    ],
    [
        "����������",
        "����������",
        "����������",
        "����������",
    ],
    [
        "�����Ă�",
        "�����Ă�",
        "�����Ă�",
        "�����Ă�",
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
    Window.draw_font(50,50),"�����牽�����悤��",@font,z:5)    
end

def live

end

#main��
story_num=0
page=0
Window.loop do
       if !scene(page,story_num)
            page+=1
            sroty_num=0
        else
            if Input.key_push?(K_RETURN)
                sroty_num+=1
            elsif Input.key_push?(K_LEFT)
                page-=1
                sroty_num=0
            end
        end
    end

end
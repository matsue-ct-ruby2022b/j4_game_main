require 'dxruby'

#画面サイズ
Window.width = 1024
Window.height = 768

SIZE1=20
SIZE2=50

def message(mes,pos_x,pos_y,font)
	Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5)    
end

i = 0

Window.loop do

	@font1=Font.new(SIZE1,fontname="MS 明朝")
	@font2=Font.new(SIZE2,fontname="MS 明朝")
	
	message("Program",50,50-i,@font2)
	message("井山 剣心",50,250-i,@font1)
	message("Iyama Kenshin",50,280-i,@font1)			
	message("風穴 輔",50,480-i,@font1)
	message("Kazaana Tasuku",50,510-i,@font1)
	message("金築 孝典",50,710-i,@font1)
	message("kanetsuki Takanori",50,740-i,@font1)			
	message("久野 智貴",50,940-i,@font1)
	message("Kuno Tomoki",50,970-i,@font1)
	message("高橋 千賢",50,1170-i,@font1)			
	message("Takahashi Tisato",50,1200-i,@font1)
	
	i += 1

	if(i>1200)
		break
	end

end


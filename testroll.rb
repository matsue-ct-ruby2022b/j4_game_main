require 'dxruby'

#画面サイズ
Window.width = 1024
Window.height = 768


def endroll
	i = 0
	text=50
	SIZE1=20
	SIZE2=50
	Window.loop do

		@font1=Font.new(SIZE1,fontname="MS 明朝")
		@font2=Font.new(SIZE2,fontname="MS 明朝")
		
		def message(mes,pos_x,pos_y,font)
			Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5,color:[255,255,255])    
		end


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
	SIZE3=100
	def message(mes,pos_x,pos_y,font)
		Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5,color:[255,0,0])    
	end

	Window.loop do
		Window.draw_box_fill(0,0,1024,768,[255,255,255],z=0)
		@font3=Font.new(SIZE3,fontname="MS 明朝")
		message("GAME CLEAR!!",200,300,@font3)

		if Input.key_push?(K_RETURN)
			break
		end
	end
end

def gameover
	SIZE3=100
	def message(mes,pos_x,pos_y,font)
		Window.draw_font(pos_x,pos_y,"#{mes}",font,z:5,color:[255,0,0])    
	end

	Window.loop do
		@font3=Font.new(SIZE3,fontname="MS 明朝")
		message("GAME OVER",200,300,@font3)

		if Input.key_push?(K_RETURN)
			break
		end
	end

end

endroll
gameclear

gameover
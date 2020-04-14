
BuyWithoutSell(name1,name2,price,count){


	Startt:
	BackToMenu()
	Random, sleepTime, 500, 1000
	Sleep, %sleepTime%

	GoToMarketFromMenu()
	Random, sleepTime, 500, 1000
	Sleep, %sleepTime%

	DeleteFilters(0)
	Random, sleepTime, 500, 1000
	Sleep, %sleepTime%

	CreateFilters(name1,name2,price,count)
	Random, sleepTime, 500, 1000
	Sleep, %sleepTime%
	ImageSearch, xp, yp,559, 48,725, 98, *80 buttons\rub.png
	if(xp=="")
	{
		Goto, Startt
	}
	
	loop
	{
		Buy(1,0)
		ImageSearch, xp, yp,404, 518,489, 560, *80 buttons/err.png
		if(xp > 0)
		{
	
			Goto, Startt
			
		}

	}	 

	return
}

Main(name1,name2,price,image,count){



Start:
endTime:= abs(UnixTime_fromUTC(A_NowUTC)) + 400
Repeat:
BackToMenu()
Random, sleepTime, 500, 1000
Sleep, %sleepTime%

GoToMarketFromMenu()
Random, sleepTime, 500, 1000
Sleep, %sleepTime%

DeleteFilters(0)
Random, sleepTime, 500, 1000
Sleep, %sleepTime%

CreateFilters(name1,name2,price,count)
Random, sleepTime, 500, 1000
Sleep, %sleepTime%
ImageSearch, xp, yp,559, 48,725, 98, *80 buttons\rub.png
if(errorLevel == 1)
{
	Goto, Start
}





while (cTime<endTime){
	Buy(0,0)
	ImageSearch, xp, yp,404, 518,489, 560, *80 buttons\err.png
	if(xp > 0)
	{
				Goto, Repeat
		
	}
	
	cTime:=abs(UnixTime_fromUTC(A_NowUTC))
	
	}	 

	send, н
	ImageSearch, x_ok, y_ok, 910, 541, 990, 680, *140 buttons\o.png

	if(x_ok>0)
	{
		x_ok:= x_ok + 10
		y_ok:= y_ok + 10
		MouseClick, left,  x_ok,  y_ok
	}
	ImageSearch, x_ok, y_ok, 910, 541, 990, 680, *140 buttons\o.png

	if(x_ok>0)
	{
		x_ok:= x_ok + 10
		y_ok:= y_ok + 10
		MouseClick, left,  x_ok,  y_ok
	}
	ImageSearch, x_ok, y_ok, 910, 541, 990, 680, *140 buttons\o.png

	if(x_ok>0)
	{
		x_ok:= x_ok + 10
		y_ok:= y_ok + 10
		MouseClick, left,  x_ok,  y_ok
	}
	CheckOpenWindow()
	Random, sleepTime, 500, 1000
	Sleep, %sleepTime%

	GoToTrader()
	Random, sleepTime, 5000, 8000
	Sleep, %sleepTime%

	Sell(image)
	Random, sleepTime, 5000, 8000
	Sleep, %sleepTime%

	MoneyTransfer(0)
	Random, sleepTime, 500, 1000
	Sleep, %sleepTime%

	Main(name1,name2,price,image,count)
	return
}





UnixTime_fromUTC(Time) { ; return unix timestamp from UTC Time
;-------------------------------------------------------------------------------
    Result := Time
    Result -= 19700101000000, Seconds
    Return, -Result
}
;Возврат в меню
BackToMenu(){
	Send, {Esc}
	Random, sleepTime, 100, 200
	Sleep, %sleepTime%
	Send, {Esc}
	Sleep, %sleepTime%
	Send, {Esc}
	Send, {Esc}
	Send, {Esc}
	return
}

CheckOpenWindow(){
	ImageSearch, xp, yp, 687, 217, 1475, 846, *70 buttons\close.png
	if (xp>0){
		MouseClick, left,  xp,  yp
	}
}

GoToMarketFromMenu(){
	MouseClick, left,  960,  800
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  950,  30
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%
	return
}



global prev:= 0
global old:=0
Buy(fImage,sImage){

	send, н
	now := abs(UnixTime_fromUTC(A_NowUTC))
	if((now-old)>=2)
	{
		send, {f5}
		old:=abs(UnixTime_fromUTC(A_NowUTC))
		goto, ReCheck
		
	}

	
	
	
	
	
	ImageSearch, xp, yp, 1359, 111, 1391, 132, *80 buttons\arrow.png          ;стрелка сортировки цены
	cTime:=abs(UnixTime_fromUTC(A_NowUTC))
	if((mod(cTime,2)==0)&&(cTime!=prev)&&(xp>0))
	{
		MouseClick, left,  926,  39,,0
		
		prev := cTime
	}
	
	
	ReCheck:
	loop 2
	{
		ImageSearch, xp, yp, 1706, 157, 1816, 749, *120 buttons\buy.png			;кнопка купить
		ImageSearch, x_ok, y_ok, 910, 541, 990, 680, *140 buttons\o.png         ;кнопка ок
		ImageSearch, x_sold, y_sold,788, 498, 1160, 550, *80 buttons\выкуплено.png ;сообщение о выкупе части товаров

		if((x_ok>0)&&(x_sold == ""))
		{
			x_ok:= x_ok + 10
			y_ok:= y_ok + 10

			MouseClick, left,  x_ok,  y_ok,,0
			Goto, End
		}else if((x_ok>0)&&(x_sold>0))
		{
			x_ok:= x_ok + 10
			y_ok:= y_ok + 10
			MouseClick, left,  x_ok,  y_ok,,0
			fImage:=0
			Goto, ReCheck
		}
		
		if (xp>0){
		
			xp:= xp + 28
			yp:= yp + 14
			MouseClick, left,  xp,  yp, ,0
			
			;Нажатие на кнопку "всё"
			;ImageSearch, xp, yp,793, 495, 1146, 560, *80 Боты\buttons\выкуплено.png
			if(fImage == 1)
			{
				
				;Random, sleepTime, 250, 300
				;Sleep, %sleepTime%
				MouseClick, left,  1179, 481,,0
			}
			
			send, {н 4}

			Random, sleepTime, 150, 200
            Sleep, %sleepTime%
			Goto, ReCheck
		}


	}

	End:

	MouseGetPos, xpos, ypos
	if((xpos>1706 && xpos<1816 )&& (ypos>157 && ypos<749 ))
	{
		xpos:=xpos+100
		MouseMove, %xpos%,%ypos%,0
	}
	if((xpos>934 && xpos<977 )&& (ypos>541 && ypos<596 ))
	{
		xpos:=xpos+100
		MouseMove, %xpos%,%ypos%,0
	}
	
	return
}
;создание фильтров
CreateFilters(name1,name2,price,count){
	MouseClick, left,  102,78
	Random, sleepTime, 10, 15
	Sleep, %sleepTime%
	MouseClick, left,  288,118
	Send, %name1%                     ;Название
	Random, sleepTime, 2000, 3000
	Sleep, %sleepTime%

	Send, %name2%
	Random, sleepTime, 3000, 4000
	Sleep, %sleepTime%

	MouseClick, left,  309,160
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	ImageSearch, x, y, 461, 60, 496,106 , *100 buttons\t.png       ;Шестеренка настроек        
	MouseClick, left,  %x%,  %y%
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  660,116
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  654,179
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  806,150
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	Send, %price%                           ;Цена
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%
	
	MouseClick, left,  637, 184
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	Send, %count%                        ;Количество от
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  509,276
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  609,429
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%
	return
}

;удаление фильтров
DeleteFilters(image){
	i := 0
	loop
	{
		ImageSearch, x, y, 510, 50, 1166,80 , *100 buttons\e.png   ;крестик фильтров
		MouseClick, left,  %x%,  %y%
		Random, sleepTime, 100, 150
		Sleep, %sleepTime%
		if (ErrorLevel = 1){
			break
		}
		i:=i+1
		if(i>1500)
		{
			
			BackToMenu()
		}
		
	}
	return
}

;Перенос денег
MoneyTransfer(image){
	ImageSearch, x, y, 1155, 255, 1900, 945, *25 buttons\m.png   ;деньги
	MouseMove, %x%, %y%
	Random, sleepTime, 5, 10
	Sleep, %sleepTime%
	Click, Down
	Random, sleepTime, 15, 20
	Sleep, %sleepTime%
	MouseMove, 1369,929
	Random, sleepTime, 5, 10
	Sleep, %sleepTime%
	Click, Up
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%
	loop
	{
		MouseMove, %x%, %y%
		Random, sleepTime, 5, 10
		Sleep, %sleepTime%
		Click, Down
		Random, sleepTime, 15, 20
		Sleep, %sleepTime%
		MouseMove, 1369,929
		Random, sleepTime, 5, 10
		Sleep, %sleepTime%
		Click, Up
		Random, sleepTime, 50, 100
		Sleep, %sleepTime%
		ImageSearch, x, y, 1155, 255, 1900, 945, *25 buttons\m.png   ;денеги
		if (ErrorLevel = 1){
			break
		}
	}
	return
}
;Выход
Exit(){
	ExitApp
}

;выход на барахолку
GoToMarket(){
	MouseClick, left,  1810,  25
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  948,  32
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%
	return
}

;выход к торговцу
GoToTrader(){
	MouseClick, left,  754,  32
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	;MouseClick, left,  1218,  408 лыжник
	MouseClick, left,  875,  429 ;Бабка
	Random, sleepTime, 50, 100
	Sleep, %sleepTime%

	MouseClick, left,  238,  40
	Random, sleepTime, 2000, 2000
	Sleep, %sleepTime%
	return
}

;продажа товаров
Sell(image)
{

	ImageSearch, x, y, 1155, 255, 1900, 945, *50 %image%
	loop
	{
		Send, {Ctrl Down}
		MouseClick, left,  %x%,  %y%,,0

		
		ImageSearch, x, y, 1155, 255, 1900, 945, *50 %image%
		if (ErrorLevel = 1){
		Send, {Ctrl Up}
			MouseClick, left,  846,  166,,0
			Random, sleepTime, 50, 100
			Sleep, %sleepTime%
			break
		}
	}
	Send, {Ctrl Up}
	return
}
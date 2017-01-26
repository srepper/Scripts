^WheelUp::SendInput {Left}			;ctrl-mouse wheel up toggles stash tabs left
^WheelDown::SendInput {Right}		;ctrl-mouse wheel down toggles stash tabs right	

; Return to hideout
F2::
	Send {Enter}/hideout{Enter}
	Send {Enter}{Up}{Up}{Escape}
	return

; Destroy item on cursor	
^!D::
	BlockInput On
	Send {Enter}/destroy{Enter}{Enter}{Up}{Up}{Escape}
	BlockInput Off
	return

; Remaining monsters in zone
XButton1::
	BlockInput On
	Send {Enter}/remaining{Enter}{Enter}{Up}{Up}{Escape}
	BlockInput Off
	return

; Display /played time
^!]::
	BlockInput On
	Send {Enter}/played{Enter}{Enter}{Up}{Up}{Escape}
	BlockInput Off
	return

; Shift-click every inventory slot
!Numpad9::
	KeyWait, LAlt, L
	KeyWait, RAlt, L
	BlockInput On
	clickEntireInventory()
	Send {LAlt}
	BlockInput Off
	return

; Move every single-slot item up one slot from current position
!Numpad8::
	KeyWait, LAlt, L
	KeyWait, RAlt, L
	BlockInput On
	moveColumnUpOne()
	Send {LAlt}
	BlockInput Off
	return

; Shift-click every stash slot
!Numpad7::
	KeyWait, LAlt, L
	KeyWait, RAlt, L
	BlockInput On
	clickEntireStash()
	;Send {LAlt}
	BlockInput Off
	return

; Organize items in Chaos Recipe tab based on my own organizational preference
!Numpad5::
	KeyWait, LAlt, L
	KeyWait, RAlt, L
	BlockInput On
	organizeRecipeTab()
	Send {LAlt}
	BlockInput Off
	return

logoutCommand()
{
	BlockInput On
	WinGetPos, , , winWidth, winHeight
	SendInput, {Esc}
	MouseMove, winWidth / 2, winHeight * 0.41
	Sleep, 20
	Send {LButton}
	BlockInput Off
	return
}

clickEntireInventory()
{
	startPosX := x := 1730
	startPosY := y := 820
	
	Loop, 12
	{
		Loop, 5
		{
			clickAndNextVertical(x, y)
		}
		nextLineRight(startPosY, x, y)
	}
}

clickEntireStash()
{
	startPosX := x := 60
	startPosY := y := 250

	Loop, 12
	{
		Loop, 12
		{
			clickAndNextVertical(x, y)
		}
		nextLineRight(startPosY, x, y)
	}
}

organizeRecipeTab()
{
	moveArmour()
	moveWeapons()
	moveJewelry()
	moveBelts()
}

moveColumnUpOne()
{
	i := 0
	MouseGetPos, mouseX, mouseY
	while(mouseY > 215)
	{
		i := i + 1
		moveItemSingleLineVertical(mouseX, mouseY, -1)
		if (i > 12)
			break
	}
}

moveArmour()
{
	startPosX := x := 655
	y := 285
	moveWideItemsLeft(startPosX, x, y, 0)
	Loop, 2
	{
		moveWideItemsLeft(startPosX, x, y, 175)
	}
	moveWideItemsLeft(startPosX, x, y, 140)
}

moveWeapons()
{
	startPosX := x := 690
	startPosY := y := 950
	Loop, 2
	{
		Loop, 10
		{
			moveItemSingleLineHorizontal(x, y, -1)
		}
		x := startPosX
		y := startPosY
	}
}

moveJewelry()
{
	startPosX := x := 760
	startPosY := y := 600
	Loop, 2
	{
		Loop, 6
		{
			moveItemSingleLineVertical(x, y, -1)
		}
		x := startPosX
		y := startPosY
	}
	nextLineRight(startPosY, x, y)
	Loop, 6
	{
		moveItemSingleLineVertical(x, y, -1)
	}
}

moveBelts()
{
	startPosX := x := 795
	startPosY := y := 670
	Loop, 6
	{
		moveItemSingleLineVertical(x, y, 1)
	}
}

moveWideItemsLeft(startPosX, ByRef x, ByRef y, moveDown)
{
	x := startPosX
	y := y + moveDown
	Loop, 5
	{
		moveWideItemLeft(x, y)
	}
}

clickAndNextHorizontal(ByRef x, ByRef y)
{
	MouseMove, x, y
	Sleep, 50
	Send ^{LButton}
	x := x + 70
}

clickAndNextVertical(ByRef x, ByRef y)
{
	MouseMove, x, y
	Sleep, 50
	Send ^{LButton}
	y := y + 70
}

nextLineRight(startPosY, ByRef x, ByRef y)
{
	x := x + 70
	y := startPosY
}

moveWideItemLeft(ByRef x, y)
{
	MouseMove, x, y
	Sleep, 150
	Send {LButton}
	x := x - 140
}

moveItemSingleLineHorizontal(ByRef x, y, direction)
{
	MouseMove, x, y
	Sleep, 150
	Send {LButton}
	x := x + (70 * direction)
}

moveItemSingleLineVertical(x, ByRef y, direction)
{
	MouseMove, x, y
	Sleep, 150
	Send {LButton}
	y := y + (70 * direction)
}

LUAGUI_NAME = "Form Movement++ Lua"
LUAGUI_AUTH = "SapphireSapphic"
LUAGUI_DESC = "Script to handle progressive growth abilities for drive forms. Credits to Num, for various offsets & code taken from GoA ROM Lua."

function _OnInit()
	if (GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301) and ENGINE_TYPE == "ENGINE" then --PCSX2
		canExecute=true
		ConsolePrint("Form Movement++ PCSX2 Ver")
		Save = 0x032BB30 --Save File
	elseif GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		canExecute=true
		ConsolePrint("Form Movement++ Lua")
		Save = 0x09A7070 - 0x56450E
	end
	sora = Save + 0x24F0 + 0x0054
	valor = Save + 0x32FE + 0x0016 -- First Unused Slot
	wisdom = Save + 0x3336 + 0x000E
	limit = Save + 0x336E
	master = Save + 0x33A6 + 0x0014
	final = Save + 0x33DE + 0x0010
	anti = Save + 0x340C + 0x000C --No Experience Slot
end

function _OnFrame()
	formAbilities()
	extraAbilities()
end

function formAbilities()
	for Slot = 68,75 do
		local Current = sora + 2*Slot
		local Ability = ReadShort(Current) & 0x0FFF
		if Ability >= 0x05E and Ability <= 0x061 then --High Jump
			WriteShort(limit,Ability + 0x8000)
			WriteShort(master,Ability + 0x8000)
		elseif Ability >= 0x062 and Ability <= 0x065 then --Quick Run
			WriteShort(limit+2,Ability + 0x8000)
			WriteShort(master+2,Ability + 0x8000)
			WriteShort(final,Ability + 0x8000)
		elseif Ability >= 0x234 and Ability <= 0x237 then --Dodge Roll
			WriteShort(wisdom,Ability + 0x8000)
			WriteShort(master+4,Ability + 0x8000)
			WriteShort(final+2,Ability + 0x8000)
		elseif Ability >= 0x066 and Ability <= 0x069 then --Aerial Dodge
			WriteShort(valor,Ability + 0x8000)
			WriteShort(wisdom+2,Ability + 0x8000)
			WriteShort(limit+4,Ability + 0x8000)
			WriteShort(final+4,Ability + 0x8000)
		elseif Ability >= 0x06A and Ability <= 0x06D then --Glide
			WriteShort(valor+2,Ability + 0x8000)
			WriteShort(wisdom+4,Ability + 0x8000)
			WriteShort(limit+6,Ability + 0x8000)
			WriteShort(master+6,Ability + 0x8000)
		end
	end
end

function extraAbilities()
	WriteShort(wisdom+6, 0x8195) --Draw x2
	WriteShort(wisdom+8, 0x8195)
	WriteShort(master+8, 0x821C) --Drive Converter
	WriteShort(final+6, 0x8195) --Draw x2
	WriteShort(final+8, 0x8195)
	WriteShort(anti, 0x8191) --Exp Boost x2
	WriteShort(anti+2, 0x8191)
	WriteShort(anti+4, 0x8195) --Draw x2
	WriteShort(anti+6, 0x8195)
	WriteShort(anti+8, 0x8196) --Jackpot x2
	WriteShort(anti+10, 0x8196)
	WriteShort(anti+12, 0x8197) --Lucky Lucky x2
	WriteShort(anti+14, 0x8197)
	WriteShort(anti+16, 0x819F) --Second Chance
	WriteShort(anti+18, 0x81A0) --Once More
end

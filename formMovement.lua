LUAGUI_NAME = "Form Movement++ Lua"
LUAGUI_AUTH = "SapphireSapphic"
LUAGUI_DESC = "Script to handle progressive growth abilities for drive forms. Credits to Num, for various offsets & code taken from GoA ROM Lua."

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		canExecute=true
		ConsolePrint("Form Movement++ Lua")
		Save = 0x09A7070 - 0x56450E
		sora = Save + 0x24F0 + 0x0054
		valor = Save + 0x32FE + 0x0014 -- (Anchor + Offset + First Empty Slot
		wisdom = Save + 0x3336 + 0x000E
		limit = Save + 0x336E
		master = Save + 0x33A6 + 0x0014
		final = Save + 0x33DE + 0x0010
	end
end

function _OnFrame()
	formAbilities()
end

function formAbilities()
	for Slot = 68,75 do
		local Current = sora + 2*Slot
		local Ability = ReadShort(Current)
		if Ability >= 0x062 and Ability <= 0x065 then --Quick Run
			WriteShort(limit,Ability + 0x8000)
			WriteShort(master,Ability + 0x8000)
			WriteShort(final,Ability + 0x8000)
			--ConsolePrint("Writing Quick Run "..Ability - 0x061)
		elseif Ability >= 0x8062 and Ability <= 0x8065 then --Quick Run Eq
			WriteShort(limit,Ability)
			WriteShort(master,Ability)
			WriteShort(final,Ability)
			--ConsolePrint("Writing Quick Run "..Ability - 0x061)
		elseif Ability >= 0x234 and Ability <= 0x237 then --Dodge Roll
			WriteShort(wisdom,Ability + 0x8000)
			WriteShort(master+2,Ability + 0x8000)
			WriteShort(final+2,Ability + 0x8000)
			--ConsolePrint("Writing Dodge Roll "..Ability - 0x233)
		elseif Ability >= 0x8234 and Ability <= 0x8237 then --Dodge Roll Eq
			WriteShort(wisdom,Ability)
			WriteShort(master+2,Ability)
			WriteShort(final+2,Ability)
			--ConsolePrint("Writing Dodge Roll "..Ability - 0x233)
		elseif Ability >= 0x066 and Ability <= 0x069 then --Aerial Dodge
			WriteShort(valor,Ability + 0x8000)
			WriteShort(wisdom+2,Ability + 0x8000)
			WriteShort(limit+2,Ability + 0x8000)
			WriteShort(final+4,Ability + 0x8000)
			--ConsolePrint("Writing Aerial Dodge "..Ability - 0x065)
		elseif Ability >= 0x8066 and Ability <= 0x8069 then --Aerial Dodge Eq
			WriteShort(valor,Ability)
			WriteShort(wisdom+2,Ability)
			WriteShort(limit+2,Ability)
			WriteShort(final+4,Ability)
			--ConsolePrint("Writing Aerial Dodge "..Ability - 0x065)
		elseif Ability >= 0x06A and Ability <= 0x06D then --Glide
			WriteShort(valor+2,Ability + 0x8000)
			WriteShort(wisdom+4,Ability + 0x8000)
			WriteShort(limit+4,Ability + 0x8000)
			WriteShort(master+4,Ability + 0x8000)
			--ConsolePrint("Writing Glide Lvl "..Ability - 0x069)
		elseif Ability >= 0x806A and Ability <= 0x806D then --Glide Eq
			WriteShort(valor+2,Ability)
			WriteShort(wisdom+4,Ability)
			WriteShort(limit+4,Ability)
			WriteShort(master+4,Ability)
			--ConsolePrint("Writing Glide Lvl "..Ability - 0x069)
		end
	end
end
--[[ 
▀▄ ▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀          
▀▄ ▄▀                                      ▀▄ ▄▀ 
▀▄ ▄▀    BY Ahmed ALobaidy                   ▀▄ ▄▀ 
▀▄ ▄▀     BY Ahmed ALobaidy (@A7mEd_B98)    ▀▄ ▄▀ 
▀▄ ▄▀ JUST WRITED BY Ahmed ALobaidy          ▀▄ ▄▀   
▀▄ ▄▀disable chat: تعطيل تفعيل دردشه محدد  ▀▄ ▄▀ 
▀▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀
--]]
local function is_channel_disabled( receiver )
	if not _config.disabled_channels then
		return false
	end

	if _config.disabled_channels[receiver] == nil then
		return false
	end

  return _config.disabled_channels[receiver]
end

local function enable_channel(receiver)
	if not _config.disabled_channels then
	   _config.disabled_channels = {}
	end

	if _config.disabled_channels[receiver] == nil then
	return "البوت🤖 بالتاكيد تم ✅تشغيله في المجموعه👥"
	end
	
	_config.disabled_channels[receiver] = false

	save_config()
	return "تم ✅تشغيل البوت 🤖في المجموعه👥"
end

local function disable_channel( receiver )
	if not _config.disabled_channels then
       _config.disabled_channels = {}
	end
	
	_config.disabled_channels[receiver] = true

	save_config()
	return "تم✅ اطفاء ❌البوت🤖 في المجموعه👥"
end

local function pre_process(msg)
	local receiver = get_receiver(msg)
	
	-- If sender is moderator then re-enable the channel
	--if is_sudo(msg) then
	if is_momod(msg) then
	  if msg.text == "bot on" then
	    enable_channel(receiver)
	  end
	end

  if is_channel_disabled(receiver) then
  	msg.text = "البوت🤖 بالتاكيد تم ✅اطفاء❌ في المجموعه👥"
  end

	return msg
end

local function run(msg, matches)
	local receiver = get_receiver(msg)
	-- Enable a channel
	if matches[1] == 'bot on' then
		return enable_channel(receiver)
	end
	-- Disable a channel
	if matches[1] == 'bot off' then
		return disable_channel(receiver)
	end
end

return {
	description = "Plugin to manage Bot.", 
	usage = {
		"Bot on: enable BOT In a Group",
		"Bot off: disable Bot In a Group" },
	patterns = {
		"^(bot on)",
		"^(bot off)" }, 
	run = run,
	privileged = true,
	--moderated = true,
	pre_process = pre_process
}

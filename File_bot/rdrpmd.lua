--[[
BY : TshAkETEAM
Channel Files : https://t.me/tshakeFiles
]]
local function keko_tshake(data)
local msg = data.message_
redis = (loadfile "./libs/redis.lua")()
database = Redis.connect('127.0.0.1', 6379)
sudos = dofile('sudo.lua')
HTTPS = require("ssl.https")
JSON = (loadfile  "./libs/dkjson.lua")()
bot_id_keko = {string.match(token, "^(%d+)(:)(.*)")}
bot_id = tonumber(bot_id_keko[1])
local function send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
local TextParseMode = {ID = "TextParseModeMarkdown"}
  tdcli_function ({
  ID = "SendMessage",
  chat_id_ = chat_id,
  reply_to_message_id_ = reply_to_message_id,
  disable_notification_ = disable_notification,
  from_background_ = 1,
  reply_markup_ = nil,
  input_message_content_ = {
  ID = "InputMessageText",
  text_ = text,
  disable_web_page_preview_ = disable_web_page_preview,
  clear_draft_ = 0,
  entities_ = {},
  parse_mode_ = TextParseMode,
  },
  }, dl_cb, nil)
  end
local msg = data.message_
text = msg.content_.text_
function is_creator(msg)
user_id = msg.sender_user_id_
chat_id = msg.chat_id_
local var = false
local creator = database:sismember('tshake:'..bot_id..'creator:'..chat_id, user_id) 
local admin = database:sismember('tshake:'..bot_id..'admins:', user_id)
if creator then var = true end
if admin then var = true end
for k,v in pairs(sudo_users) do
if user_id == v then var = true end end
local keko_add_sudo = redis:get('tshake:'..bot_id..'sudoo'..user_id..'')
if keko_add_sudo then var = true end
return var
end
if text == "مسح ردود الميديا بالرد" and is_creator(msg) then
local list = redis:smembers("tshake"..bot_id.."md:rprd"..msg.chat_id_)
for k,v in pairs(list) do
database:del("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_)
database:del("tshake"..bot_id.."keko:gifrd"..v..msg.chat_id_)
database:del("tshake"..bot_id.."keko:vord"..v..msg.chat_id_)
database:del("tshake"..bot_id.."keko:strd"..v..msg.chat_id_)
database:srem("tshake"..bot_id.."md:rprd"..msg.chat_id_,v)
  end
 send(msg.chat_id_, msg.id_, 1, "• `تم مسح ردود الميديا` 🗑", 1, 'md')
    end
if  text == "ردود الميديا بالرد" and is_creator(msg) then
    local list = database:smembers("tshake"..bot_id.."md:rprd"..msg.chat_id_)
    text = "💾┇قائمة ردود الميديا ،\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ \n"
    for k,v in pairs(list) do
  text = text.."*|"..k.."|*~⪼("..v..")\n"
	  if #text > 7000 then
    send(msg.chat_id_, msg.id_, 1, text, 1, 'md')
	text = ""
	end
    end
    if #list == 0 then
  text = "✖┇لايوجد ردود ميديا"
  end
    send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
  end
if (text and text == 'اضف رد ميديا بالرد' 
and is_creator(msg) ) then 
  send(msg.chat_id_, msg.id_, 1, '📜┇الان ارسل الكلمه', 1, 'md')
database:set("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_,"yes")
  return false
end  
if text then 
local keko = database:get("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_)
if keko == 'yes' then 
  send(msg.chat_id_, msg.id_, 1, "📥┇الان ارسل الميديا \n ℹ️┇كمثال (متحركه،بصمه،ملصق)", 1, 'md')
database:set("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_,"yes2")
database:set("tshake"..bot_id.."keko:add2rd"..msg.sender_user_id_..msg.chat_id_, text)
database:sadd("tshake"..bot_id.."md:rprd"..msg.chat_id_,text)
return false
end
end
if (data.message_.content_.sticker_ or data.message_.content_.voice_ or data.message_.content_.animation_) then
local keko = database:get("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_)
if keko == 'yes2' then
send(msg.chat_id_, msg.id_, 1, "☑️┇تم الحفظ", 1, 'md')
database:del("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_)
local keko = database:get("tshake"..bot_id.."keko:add2rd"..msg.sender_user_id_..msg.chat_id_)
if data.message_.content_.sticker_ then 
database:set("tshake"..bot_id.."keko:strd"..keko..msg.chat_id_, data.message_.content_.sticker_.sticker_.persistent_id_)
  end 
  if data.message_.content_.voice_ then
  database:set("tshake"..bot_id.."keko:vord"..keko..msg.chat_id_, data.message_.content_.voice_.voice_.persistent_id_)
  end 
  if data.message_.content_.animation_ then 
database:set("tshake"..bot_id.."keko:gifrd"..keko..msg.chat_id_, data.message_.content_.animation_.animation_.persistent_id_)
end
database:del("tshake"..bot_id.."keko:add2rd"..msg.sender_user_id_..msg.chat_id_)
  return false
  end
  end
    if (text and text == 'حذف رد ميديا بالرد' and  is_creator(msg) ) then 
      send(msg.chat_id_, msg.id_, 1, '📜┇الان ارسل الكلمه', 1, 'md')
database:set("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_,"yes3")
return false
end
if text then
local keko = database:get("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_)
if (keko and keko == 'yes3') then 
send(msg.chat_id_, msg.id_, 1, "☑️┇تم الحذف", 1, 'md')
database:del("tshake"..bot_id.."keko:addard"..msg.sender_user_id_..msg.chat_id_)
database:del("tshake"..bot_id.."keko:gifrd"..text..msg.chat_id_)
database:del("tshake"..bot_id.."keko:vord"..text..msg.chat_id_)
database:del("tshake"..bot_id.."keko:strd"..text..msg.chat_id_)
database:srem("tshake"..bot_id.."md:rprd"..msg.chat_id_,text)
return false
end
end
if text and msg.reply_to_message_id_ ~= 0 then
local gif = database:get("tshake"..bot_id.."keko:gifrd"..text..msg.chat_id_)
local vo = database:get("tshake"..bot_id.."keko:vord"..text..msg.chat_id_)
local st = database:get("tshake"..bot_id.."keko:strd"..text..msg.chat_id_)  
local id_keko = msg.reply_to_message_id_/2097152/0.5 
if vo then 
local url = 'https://api.telegram.org/bot'..token..'/sendVoice?chat_id='..msg.chat_id_..'&voice='..vo..'&reply_to_message_id='..id_keko
HTTPS.request(url)
return false
end 
      if st then 
      local url = 'https://api.telegram.org/bot'..token..'/sendSticker?chat_id='..msg.chat_id_..'&sticker='..st..'&reply_to_message_id='..id_keko
      HTTPS.request(url)
      return false
      end
      if gif then 
        local url = 'https://api.telegram.org/bot'..token..'/sendDocument?chat_id='..msg.chat_id_..'&document='..gif..'&reply_to_message_id='..id_keko
        HTTPS.request(url)
      return false
      end
      end
end
return {
	keko_tshake = keko_tshake,
}
--[[
BY : TshAkETEAM
Channel Files : https://t.me/tshakeFiles
]]

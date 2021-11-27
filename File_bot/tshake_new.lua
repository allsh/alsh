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
  function getUser(user_id, cb)
    tdcli_function ({
  ID = "GetUser",
  user_id_ = user_id
    }, cb, nil)
  end

local msg = data.message_
text = msg.content_.text_
if text then 
if is_creator(msg) then 
if text == "وضع توحيد" then 
database:set("keko:add_h"..bot_id..msg.chat_id_..msg.sender_user_id_,"keko")
send(msg.chat_id_, msg.id_, 1, "🔘┇ ارسال التوحيد الان", 1, 'html')
return "keko"
end
if database:get("keko:add_h"..bot_id..msg.chat_id_..msg.sender_user_id_) then 
send(msg.chat_id_, msg.id_, 1, "📎┇ تم تعين : {"..text.."}", 1, 'html')
database:del("keko:add_h"..bot_id..msg.chat_id_..msg.sender_user_id_)
database:set("keko_is_gr_tshake"..bot_id..msg.chat_id_,text)
end
if text == "تعين عدد الكتم" then
send(msg.chat_id_, msg.id_, 1, "🗳┇ ارسال عدد الكتم الان", 1, 'html')
database:set("keko:add_h2"..bot_id..msg.chat_id_..msg.sender_user_id_,"keko")
return "keko"
end
if database:get("keko:add_h2"..bot_id..msg.chat_id_..msg.sender_user_id_) then 
send(msg.chat_id_, msg.id_, 1, "🔖┇ تم تعين : {"..text.."} عدد لكتم العضو", 1, 'html')
database:del("keko:add_h2"..bot_id..msg.chat_id_..msg.sender_user_id_)
database:set("keko_is_gr_tshake_dan"..bot_id..msg.chat_id_,text)
end  
if text == "تفعيل التوحيد" then 
send(msg.chat_id_, msg.id_, 1, "☑️┇ تم تفعيل توحيد", 1, 'html')
database:set("keko_is_gr_tshake_ok"..bot_id..msg.chat_id_,"ok")
end
if text == "تعطيل التوحيد" then 
send(msg.chat_id_, msg.id_, 1, "🔓┇ تم تعطيل توحيد", 1, 'html')
database:del("keko_is_gr_tshake_ok"..bot_id..msg.chat_id_)
end
end
end

if not msg.forward_info_  then
if database:get("keko_is_gr_tshake_ok"..bot_id..msg.chat_id_) and database:get("keko_is_gr_tshake"..bot_id..msg.chat_id_) then 
id = msg.sender_user_id_
function keko_tsahke_new(tshake1,tshake2)
if tshake2 and tshake2.first_name_ then 
if tshake2.first_name_:match("(.*)"..database:get("keko_is_gr_tshake"..bot_id..msg.chat_id_).."(.*)") then 
database:srem('tshake:'..bot_id..'muted:'..msg.chat_id_, msg.sender_user_id_)
else
local tshake_nnn = database:get("keko_is_gr_tshake_dan"..bot_id..msg.chat_id_) or 5
local tshake_nnn2 = database:get("keko_is_gr_tshake_dan22"..bot_id..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(tshake_nnn2) == tonumber(tshake_nnn) or tonumber(tshake_nnn2) > tonumber(tshake_nnn)) then 
database:sadd('tshake:'..bot_id..'muted:'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby("keko_is_gr_tshake_dan22"..bot_id..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, 1, "👋🏻┇عزيزي  ~⪼ ["..tshake2.username_.."](https://t.me/"..(tshake2.username_ or "tshaketeam")..")\n📜┇عليك وضع التوحيد ~⪼ {`"..database:get("keko_is_gr_tshake"..bot_id..msg.chat_id_).."`} بجانب اسمك\n\n❗️┇عدد المحاولات المتبقيه {"..(tonumber(tshake_nnn) - tonumber(tshake_nnn2)).."}", 1, 'html')
end
end
end
end
getUser(id, keko_tsahke_new)
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

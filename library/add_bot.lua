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
msg = data.message_
bot=dofile('./libs/utils.lua')
text = msg.content_.text_
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
function getUser(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end
function is_sudo(msg)
sudo_users = {sudo_add,bot_id}
local var = false
for k,v in pairs(sudo_users) do
if msg.sender_user_id_ == v then var = true end
end
local keko_add_sudo = redis:get('tshake:'..bot_id..'sudoo'..msg.sender_user_id_..'')
if keko_add_sudo then var = true end return var
end
if (text and text == "تفعيل" and is_sudo(msg) and database:get("tshake:get_back_add_bot:"..bot_id)) then 
if database:get("tshake:link:auto:launch"..bot_id) then 
database:set("lock_link:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_inline:tshake"..msg.chat_id_..bot_id,"ok")
end 
if database:get("tshake:fwd:auto:launch"..bot_id) then 
database:set("lock_fwd:tshake"..msg.chat_id_..bot_id,"ok")
end 
if database:get("tshake:medea:auto:launch"..bot_id) then 
database:set("lock_media:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_audeo:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_video:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_photo:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_stecker:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_voice:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_gif:tshake"..msg.chat_id_..bot_id,"ok")
database:set("lock_note:tshake"..msg.chat_id_..bot_id,"ok")
end 
if database:get("tshake:username:auto:launch"..bot_id) then 
database:set("lock_username:tshake"..msg.chat_id_..bot_id,"ok")
end 
if database:get("tshake:spam:auto:launch"..bot_id) then 
database:set("lock_lllll:tshake"..msg.chat_id_..bot_id,"ok")
end 

if database:get("tshake:auto:seva:admin:auto:launch"..bot_id) then 
local function cb2(extra,result,success)
for k,v in pairs(result.members_) do
database:sadd('tshake:'..bot_id..'mods:'..msg.chat_id_, v.user_id_)
end
end
bot.channel_get_admins(msg.chat_id_,cb2)
end

if database:get("tshake:spam:auto:launch"..bot_id) then 

local function cb_ts(t1,t2)
for k,v in pairs(t2.members_) do
if v.status_.ID == "ChatMemberStatusCreator" then 
database:sadd('tshake:'..bot_id..'creator:'..msg.chat_id_, v.user_id_)
end
end
end
bot.channel_get_admins(msg.chat_id_,cb_ts)
end 

end

if (text and text:match("(.*) (بعد التفعيل)") and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
ts2 = {string.match(text, "^(.*) (بعد التفعيل)$")}
ts = ts2[1]
if ts then

u = nil
if ts == "قفل الروابط" then 
u = "link"
elseif ts == "قفل التوجيه" then
u = "fwd"
elseif ts == "قفل الميديا" then 
u = "medea"
elseif ts == "قفل المعرفات" then 
u = "username"
elseif ts == "قفل التكرار" then 
u = "spam"
elseif ts == "رفع الادمنيه" then 
u = "auto:seva:admin"
elseif ts == "رفع المنشئ" then
u = "auto:save:crete"
end

a = nil
if ts == "فتح الروابط" then 
a = "link"
elseif ts == "فتح التوجيه" then
a = "fwd"
elseif ts == "فتح الميديا" then 
a = "medea"
elseif ts == "فتح المعرفات" then 
a = "username"
elseif ts == "فتح التكرار" then 
a = "spam"
elseif ts == "الغاء رفع الادمنيه" then 
a = "auto:seva:admin"
elseif ts == "الغاء رفع المنشئ" then
a = "auto:save:crete"
end

if u then 
database:set("tshake:"..u..":auto:launch"..bot_id,"ok")
send(msg.chat_id_, msg.id_, 1, "✔┇تم الحفظ ", 1, 'html')
elseif a then 
database:del("tshake:"..a..":auto:launch"..bot_id)
send(msg.chat_id_, msg.id_, 1, "✔┇تم الحفظ ", 1, 'html')
end

end
end

if (text and text == "تفعيل الاعدادات المسبقه" and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
send(msg.chat_id_, msg.id_, 1, "✔┇تم تفعيل عمليه الاعدادات المسبقه عند التفعيل ", 1, 'html')
database:set("tshake:get_back_add_bot:"..bot_id,"ok")
end 

if (text and text == "تعطيل الاعدادات المسبقه" and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
send(msg.chat_id_, msg.id_, 1, "🔓┇تم تعطيل خاصيه الاعدادات المسبقه عند التفعيل", 1, 'html')
database:del("tshake:get_back_add_bot:"..bot_id)
end 

end
return {
keko_tshake = keko_tshake,
}
--[[
BY : TshAkETEAM
Channel Files : https://t.me/tshakeFiles
]]

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
bot=dofile('./libs/utils.lua')
-----------------------------
function load_keko(fileName) 
local keko = io.open(fileName)
if not keko then
return {}
end
local keko2 = keko:read('*all')
keko:close()
local keko3 = JSON.decode(keko2)
return keko3
end
function save_keko(fileName, data) 
local keko = JSON.encode(data)
local keko2 = io.open(fileName, 'w')
keko2:write(keko)
keko2:close()
end
function kekoSetl(keko, keko2)
local keko3 = 'Gr_'..bot_id..'.json'
if (keko and keko2 and keko3) then 
local keko_data = load_keko(keko3)
if not keko_data then
keko_data = {}
save_keko(keko3, keko_data)
end
if not (keko_data[tostring(keko)]) then 
keko_data[tostring(keko)] = {}
end
table.insert(keko_data[tostring(keko)], keko2)
save_keko(keko3, keko_data)
end
if not keko then print('no keko') end
if not keko2 then print('no keko2') end
if not keko3 then print('no keko3') end
end

function kekoGetl(keko)
local keko3 = 'Gr_'..bot_id..'.json'
local keko_text = nil 
local keko_data = load_keko(keko3)
if keko_data then 
keko_text = keko_data[tostring(keko)]
else 
return false
end
return keko_text
end
function download_to_file(url, file_path)
local respbody = {}
local options = {
url = url,
sink = ltn12.sink.table(respbody),
redirect = true
}
local response = nil
options.redirect = false
response = {HTTPS.request(options)}
local code = response[2]
local headers = response[3]
local status = response[4]
if code ~= 200 then return false, code end
file = io.open(file_path, "w+")
file:write(table.concat(respbody))
file:close()
return file_path, code
end
if (text and text == "تفعيل عمل نسخه للمجموعات" and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
send(msg.chat_id_, msg.id_, 1, "✔┇ تم تفعيل عمل نسخه للمجموعات", 1, 'html')
database:set("tshake:auto:save:gr:"..bot_id,"ts")
end 
if (text and text == "تعطيل عمل نسخه للمجموعات" and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
send(msg.chat_id_, msg.id_, 1, "📤┇ تم تعطيل عمل نسخه للمجموعات", 1, 'html')
database:del("tshake:auto:save:gr:"..bot_id)
end 
if (text and database:get("tshake:auto:save:gr:"..bot_id)) then
x = database:get("Tshake:time:save:gr"..bot_id)
if x then 
if x ~= os.date("%x") then 
io.popen('fm -fr Gr_'..bot_id..'.json')
local Tshake_gr = database:smembers('tshake:'..bot_id.."groups") or 0
for i=1, #Tshake_gr do
kekoSetl("Tshake_GR", Tshake_gr[i])
end
local tshakee = 'https://api.telegram.org/bot' .. token .. '/sendDocument'
local curl = 'curl "' .. tshakee .. '" -F "chat_id=' .. (database:get("tshake"..bot_id..":sudo:gr") or sudo_add) .. '" -F "document=@Gr_'..bot_id..'.json' .. '" -F "caption='..os.date("%x")..'"'
io.popen(curl)
io.popen('fm -fr Gr_'..bot_id..'.json')
database:set("Tshake:time:save:gr"..bot_id,os.date("%x"))
end
else 
database:set("Tshake:time:save:gr"..bot_id,os.date("%x"))
end
end

if (text and text == 'قفل الميديا في المجموعات' and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
send(msg.chat_id_, msg.id_, 1, "🖲┇جاري قفل الميديا", 1, 'html')
local Tshake_gr = database:smembers('tshake:'..bot_id.."groups") or 0
for i=1, #Tshake_gr do
database:set("lock_mark:tshake"..Tshake_gr[i]..bot_id,"ok")
database:set("lock_link:tshake"..Tshake_gr[i]..bot_id,"ok")
database:set("lock_new:tshake"..Tshake_gr[i]..bot_id,"ok")
database:set("lock_video:tshake"..Tshake_gr[i]..bot_id,"ok")
database:set('tshake:'..bot_id..'get:photo'..Tshake_gr[i],"ok")
database:set("lock_media:tshake"..Tshake_gr[i]..bot_id,"ok")
database:set("lock_photo:tshake"..Tshake_gr[i]..bot_id,"ok")
database:set("lock_gif:tshake"..Tshake_gr[i]..bot_id,"ok")
database:set("lock_note:tshake"..Tshake_gr[i]..bot_id,"ok")
end
send(msg.chat_id_, msg.id_, 1, "✔┇تم قفل الميديا", 1, 'html')
end 
if (text and text == 'رفع المنشئين في المجموعات' and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
send(msg.chat_id_, msg.id_, 1, "🖲┇جاري رفع المنشئين", 1, 'html')
local Tshake_gr = database:smembers('tshake:'..bot_id.."groups") or 0
for i=1, #Tshake_gr do
local function cb(t1,t2)
for k,v in pairs(t2.members_) do
if v.status_.ID == "ChatMemberStatusCreator" then 
database:sadd('tshake:'..bot_id..'creator:'..Tshake_gr[i], v.user_id_)
print(v.user_id_)
end
end
end
bot.channel_get_admins(Tshake_gr[i],cb)
end
send(msg.chat_id_, msg.id_, 1, "✔┇تم رفع المنشئين", 1, 'html')
end 
if (text and text == 'جلب ملف الكروبات' and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
local Tshake_gr = database:smembers('tshake:'..bot_id.."groups") or 0
send(msg.chat_id_, msg.id_, 1, "🖲┇جاري صنع الملف .", 1, 'html')
for i=1, #Tshake_gr do
kekoSetl("Tshake_GR", Tshake_gr[i])
end
send(msg.chat_id_, msg.id_, 1, "📤┇جاري الرسال ملف الكروبات ..", 1, 'html')
local tshakee = 'https://api.telegram.org/bot' .. token .. '/sendDocument'
local curl = 'curl "' .. tshakee .. '" -F "chat_id=' .. msg.chat_id_ .. '" -F "caption='..os.date("%x")..'" -F "document=@' .. 'Gr_'..bot_id..'.json' .. '"'
io.popen(curl)
io.popen('fm -fr Gr_'..bot_id..'.json')
end
if msg.content_.document_ and database:get("tshake:set:gr:new"..bot_id..msg.sender_user_id_) then
send(msg.chat_id_, msg.id_, 1, "📤┇جاري الرفع ..", 1, 'html')
local id_keko = msg.content_.document_.document_.persistent_id_
local url_keko3 = 'https://api.telegram.org/bot' .. token .. '/getfile?file_id='..id_keko
local keko3 = HTTPS.request(url_keko3)
local keko6 = JSON.decode(keko3)
local photo_keko = download_to_file('https://api.telegram.org/file/bot'..token..'/'..keko6.result.file_path, msg.content_.document_.file_name_)
send(msg.chat_id_, msg.id_, 1, "✔┇ جاري تحويل المجموعات", 1, 'html')
local all_new_tshake = kekoGetl("Tshake_GR")
if not all_new_tshake then 
send(msg.chat_id_, msg.id_, 1, "📤┇حدث خطا", 1, 'html')
return 'stop'
end
for i=1, #all_new_tshake do 
database:sadd( 'tshake:'..bot_id.."groups",all_new_tshake[i])
end
send(msg.chat_id_, msg.id_, 1, "✔┇تم حفض المجموعات", 1, 'html')
database:del("tshake:set:gr:new"..bot_id..msg.sender_user_id_)
io.popen('fm -fr Gr_'..bot_id..'.json')
end
if (text and text == 'رفع ملف الكروبات' and tonumber(msg.sender_user_id_) == tonumber(sudo_add)) then 
send(msg.chat_id_, msg.id_, 1, "📤┇ارسال الان ملف الكروبات", 1, 'html')
database:set("tshake:set:gr:new"..bot_id..msg.sender_user_id_,"ok")
io.popen('fm -fr Gr_'..bot_id..'.json')
end
end
return {
keko_tshake = keko_tshake,
}
--[[
BY : TshAkETEAM
Channel Files : https://t.me/tshakeFiles
]]

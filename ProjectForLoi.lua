repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer.Character
repeat wait() until game.Players.LocalPlayer.Backpack
--game.Players.LocalPlayer.PlayerGui.Main.DragonSelection.Root.DragonSelectionMenu.Enabled = false
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local fileName = player.Name .. "_ServerTime.json"

local getSavedTime = 0

-- Đọc dữ liệu từ file nếu có
local success, result = pcall(function()
    return HttpService:JSONDecode(readfile(fileName))
end)

if success then
    getSavedTime = result
    print("Saved Time: " .. getSavedTime)
else
    -- Nếu không có file, tạo file mới
    writefile(fileName, HttpService:JSONEncode(math.floor(workspace.DistributedGameTime + 0.5)))
    print("New file created, starting time saved.")
end

-- Lưu thời gian khi người chơi rời đi

-- Vòng lặp cập nhật thời gian
local startTime = math.floor(workspace.DistributedGameTime + 0.5)
local previousServerTime = startTime - getSavedTime

spawn(function()
while wait(1) do
    local elapsedTime = math.floor(workspace.DistributedGameTime + 0.5) - previousServerTime
    print("Elapsed Time:", elapsedTime)

    if elapsedTime >= notifyTime then
        print("Saving progress...")
        writefile(fileName, HttpService:JSONEncode(0))
        GetLatestData()
        PrintTableData()
        SendDataJson()
        previousServerTime = math.floor(workspace.DistributedGameTime + 0.5)  -- Reset thời gian
    else
        writefile(fileName, HttpService:JSONEncode(elapsedTime))
    end
end
end)

function GetLatestData()
Name = game:GetService('Players').LocalPlayer.Name
Level = game:GetService('Players').LocalPlayer.Data.Level.Value
Bounty = game:GetService('Players').LocalPlayer.leaderstats['Bounty/Honor'].Value
DevilFruit = game:GetService('Players').LocalPlayer.Data.DevilFruit.Value
Race = game:GetService('Players').LocalPlayer.Data.Race.Value
Fragments = game:GetService('Players').LocalPlayer.Data.Fragments.Value
Beli = game:GetService('Players').LocalPlayer.Data.Beli.Value
Valor = game:GetService('Players').LocalPlayer.Data.Valor.Value
--Remote Event
game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.GetPlayerData:InvokeServer()
game:GetService("ReplicatedStorage").Remotes.GetFruitData:InvokeServer()

Fruit = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits",false)
Inventory = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")

--RaceCheck
RaceAwakenValue = 1
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaceV4Progress","Check") == 4 then
    RaceAwakenValue = 4
    --RaceV3 Check
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad","1") == -2 then
    RaceAwakenValue = 3
    --RaceV2 Check
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist") == -2 then
    RaceAwakenValue = 2
end

if game.PlaceId == 7449423635 then
    Sea3 = true
EliteHunterProcess = ", Total Killed Elite Hunter: "..game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress")
Spy = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan",1)
if Spy == -1 then
   SpyText = ", Spy: Still in Cooldown"
else
    SpyText = ", Spy: Found Leviathan"
end
else
    EliteHunterProcess = ""
    SpyText = ""
end
end
-----
PlayerCurrentMelee = ""
PlayerCurrentMeleeLevel = ""

PlayerCurrentSword = ""
PlayerCurrentSwordLevel = ""

PlayerCurrentFruit = ""
PlayerCurrentFruitLevel = ""

PlayerCurrentGun = ""
PlayerCurrentGunLevel = ""
pcall(function()
for i ,v in pairs(game:GetService('Players').LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        if v.ToolTip == "Melee" then
            PlayerCurrentMelee = v.Name
            PlayerCurrentMeleeLevel = game:GetService('Players').LocalPlayer.Backpack[v.Name].Level.Value
        elseif v.ToolTip == "Blox Fruit" then
            PlayerCurrentFruit = v.Name
            PlayerCurrentFruitLevel = game:GetService('Players').LocalPlayer.Backpack[v.Name].Level.Value
        elseif v.ToolTip == "Sword" then
            PlayerCurrentSword = v.Name
            PlayerCurrentSwordLevel = game:GetService('Players').LocalPlayer.Backpack[v.Name].Level.Value
        elseif v.ToolTip == "Gun" then
            PlayerCurrentGun = v.Name
            PlayerCurrentGunLevel = game:GetService('Players').LocalPlayer.Backpack[v.Name].Level.Value
        end
    end
end
for i ,v in pairs(game:GetService('Players').LocalPlayer.Character:GetChildren()) do
    if v:IsA("Tool") then
        if v.ToolTip == "Melee" then
            PlayerCurrentMelee = v.Name
            PlayerCurrentMeleeLevel = game:GetService('Players').LocalPlayer.Character[v.Name].Level.Value
        elseif v.ToolTip == "Blox Fruit" then
            PlayerCurrentFruit = v.Name
            PlayerCurrentFruitLevel = game:GetService('Players').LocalPlayer.Character[v.Name].Level.Value
        elseif v.ToolTip == "Sword" then
            PlayerCurrentSword = v.Name
            PlayerCurrentSwordLevel = game:GetService('Players').LocalPlayer.Character[v.Name].Level.Value
        elseif v.ToolTip == "Gun" then
            PlayerCurrentGun = v.Name
            PlayerCurrentGunLevel = game:GetService('Players').LocalPlayer.Character[v.Name].Level.Value
        end
    end
end
end)

-- Get Fruit Data
if SendPlayerFruitDataAsWebhook then
pcall(function()
    FruitTable = {}
    PlayerFruitTable = {}
        for i,v in pairs(Fruit) do
            for a,b in pairs(v) do
                   if a == "Name" then
                table.insert(FruitTable,b)
                    end
            end
        end
     ---get Fruit in Inventory
           for i,v in pairs(Inventory) do
                if table.find(FruitTable,v.Name) then
                    for i1,v1 in pairs(v) do
                        if i1 == "Count" then
                            table.insert(PlayerFruitTable,v.Name.." ["..v1.."]")
                        end
                    end
                end
           end
--Function chia bang lam 3
 totalElements = #PlayerFruitTable
 partSize = math.ceil(totalElements / 3)  -- Chia tổng số phần tử cho 3 và làm tròn lên

-- Chia bảng thành 3 phần
 firstPart = {}
 secondPart = {}
 thirdPart = {}

-- Phần đầu tiên
for i = 1, partSize do
    table.insert(firstPart, PlayerFruitTable[i])
end

-- Phần thứ hai
for i = partSize + 1, 2 * partSize do
    if PlayerFruitTable[i] then
        table.insert(secondPart, PlayerFruitTable[i])
    end
end

-- Phần thứ ba
for i = 2 * partSize + 1, totalElements do
    if PlayerFruitTable[i] then
        table.insert(thirdPart, PlayerFruitTable[i])
    end
end

 PlayerFruitList1 = "•Fruit Inventory:\n"
    for _, player in ipairs(firstPart) do
        PlayerFruitList1 = PlayerFruitList1 ..  player .. "\n"
    end

 PlayerFruitList2 = "•Fruit Inventory:\n"
    for _, player in ipairs(secondPart) do
        PlayerFruitList2 = PlayerFruitList2 ..  player .. "\n"
    end

 PlayerFruitList3 = "•Fruit Inventory:\n"
    for _, player in ipairs(thirdPart) do
        PlayerFruitList3 = PlayerFruitList3 ..  player .. "\n"
    end
end)
end
-------------
--Collect Player Data
function PrintTableData()
if SendDataAsJson then
    pcall(function()
        FruitTable2 = {}
        PlayerFruitTable2 = {}
        TestTable2 = {}
        PlayerFruitData = {}

        ---Get Player Melee
        PrintMelee = ""
        NameMelee = {"BlackLeg","Electro","FishmanKarate","DragonClaw","Superhuman","DeathStep","SharkmanKarate","ElectricClaw","DragonTalon","Godhuman","SanguineArt"}
        for i,v in pairs(NameMelee) do
            if v == "DragonClaw" then  
                local a = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1") 
                if a == 1 or a == 2 then
                    PrintMelee = PrintMelee..v..", "
                end
            else
                local a = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..v,true)
            if a == 1 or a == 2 then
           PrintMelee = PrintMelee..v..", "
        end
        end
    end

        function splitCamelCase(str)
            return str:gsub("([a-z])([A-Z])", "%1 %2") -- Thêm khoảng trắng giữa chữ hoa và chữ thường
        end
        -- Tách các từ trong chuỗi và xử lý chúng
        local result = {}
        for word in PrintMelee:gmatch("%S+") do
            table.insert(result, tostring(splitCamelCase(word)))
        end
        
        -- Kết hợp các từ đã tách lại thành một chuỗi, cách nhau bởi dấu phẩy
        finalResult = table.concat(result, " ")
    --
            -- ListFruit from FruitStock:
            for i,v in pairs(Fruit) do
                for a,b in pairs(v) do
                       if a == "Name" then
                    table.insert(FruitTable2,b)
                        end
                end
            end
            ---
            for i,v in pairs(Inventory) do
                if table.find(FruitTable2,v.Name) then               
                    table.insert(TestTable2,v.Name)
                end
            end
            ---
            for i,v in pairs(Inventory) do
                if table.find(FruitTable2,v.Name) then               
                            table.insert(PlayerFruitData,v)
                end
           end
            ---
    PrintTable = "Player Name: "..Name..", ".."Level: "..Level..", ".."Bounty: "..Bounty..", ".."Race: "..Race.." [V"..tostring(RaceAwakenValue).."]"..", ".."Fragments: "..Fragments..", ".."Beli: "..Beli..", ".."Valor Level: "..Valor..EliteHunterProcess..SpyText.." | ".."CurrentMelee: "..PlayerCurrentMelee..", ".."Mastery: "..PlayerCurrentMeleeLevel.." | ".."CurrentBloxFruit: "..PlayerCurrentFruit..", ".."Mastery: "..PlayerCurrentFruitLevel.." | ".."CurrentSword: "..PlayerCurrentSword..", ".."Mastery: "..PlayerCurrentSwordLevel.." | ".."CurrentGun: "..PlayerCurrentGun..", ".."Mastery: "..PlayerCurrentGunLevel.." | ".."Melee: "..finalResult:sub(1,-2).." | "
           for i,v in pairs(FruitTable2) do
            NameFruit = v
            if table.find(TestTable2,v) then
                PrintTable = PrintTable.."Fruit Name: "..NameFruit..", "
                for l,k in pairs(PlayerFruitData) do
                    if k.Name == NameFruit then
                        for a,b in pairs(k) do
                            if a ~= "AwakeningData" and a ~= "Equipped" and a~= "MasteryRequirements" and a ~= "Type" and a~= "Name" and a ~= "Value" and a ~= "Rarity" then
                                if a~= "Mastery" then
                                PrintTable = PrintTable..a..": "..b..", "
                                else
                                    PrintTable = PrintTable..a..": "..b.." | "
                                end
                            end
                        end
                    end
                end
            else
               PrintTable = PrintTable.."Fruit Name: "..v..", ".."Count: 0"..", ".."Mastery: - | "
           end
        end
    
               for i,v in pairs(Inventory) do
                        for i1,v1 in pairs(v) do
                            if v.Type == "Sword"  then
                                if i1 ~= "Rarity" and i1 ~= "MasteryRequirements" and i1 ~= "Scrolls" and i1 ~= "Equipped" and i1 ~= "Type" then
                                    if i1 == "Name" then
                                        PrintTable = PrintTable.."Sword "..i1..": "..v1..", "
                                        else
                                            if i1 == "Mastery" then
                                                PrintTable = PrintTable..i1..": "..v1.." | "
                                                else
                                                PrintTable = PrintTable..i1..": "..v1..", "
                                            end
                                    end
                            end
                        end
                    end
               end
               for i,v in pairs(Inventory) do
                for i1,v1 in pairs(v) do
                    if v.Type == "Gun"  then
                        if i1 ~= "Rarity" and i1 ~= "MasteryRequirements" and i1 ~= "Scrolls" and i1 ~= "Equipped" and i1 ~= "Type" then
                            if i1 == "Name" then
                                PrintTable = PrintTable.."Gun "..i1..": "..v1..", "
                                else
                                    if i1 == "Mastery" then
                                        PrintTable = PrintTable..i1..": "..v1.." | "
                                        else
                                        PrintTable = PrintTable..i1..": "..v1..", "
                                    end
                            end
                    end
                end
            end
       end
                for i,v in pairs(Inventory) do
                    for i1,v1 in pairs(v) do
                        if v.Type == "Wear"  then
                            if i1 ~= "Rarity" and i1 ~= "MasteryRequirements" and i1 ~= "Scrolls" and i1 ~= "Equipped" and i1 ~= "Type" then
                                if i1 == "Name" then
                                    PrintTable = PrintTable.."Accessory "..i1..": "..v1..", "
                                    else
                                        if i1 == "Mastery" then
                                            PrintTable = PrintTable..i1..": "..v1.." | "
                                            else
                                            PrintTable = PrintTable..i1..": "..v1..", "
                                        end
                                end
                        end
                    end
                end
                end
                for i,v in pairs(Inventory) do
                    for i1,v1 in pairs(v) do
                        if v.Type == "Material"  then
                            if i1 ~= "Rarity" and i1 ~= "MasteryRequirements" and i1 ~= "Scrolls" and i1 ~= "Equipped" and i1 ~= "Type" then
                                if i1 == "Name" then
                                    PrintTable = PrintTable.."Material "..i1..": "..v1..", "
                                    else
                                        if i1 == "MaxCount" then
                                            PrintTable = PrintTable..i1..": "..v1.." | "
                                            else
                                            PrintTable = PrintTable..i1..": "..v1..", "
                                        end
                                end
                        end
                    end
                end
                end
               
                for i,v in pairs(Inventory) do
                    for i1,v1 in pairs(v) do
                        if v.Type == "Premium"  then
                            if i1 ~= "Rarity" and i1 ~= "MasteryRequirements" and i1 ~= "Scrolls" and i1 ~= "Equipped" and i1 ~= "Type" and i1 ~= "Value" and i1 ~= "Texture" then
                                if i1 == "Name" then
                                    PrintTable = PrintTable.."Premium "..i1..": "..v1..", "
                                    else
                                        if i1 == "SubType" then
                                            PrintTable = PrintTable..i1..": "..v1.." | "
                                            else
                                            PrintTable = PrintTable..i1..": "..v1..", "
                                        end
                                end
                        end
                    end
                end
                end

                for i,v in pairs(Inventory) do
                    for i1,v1 in pairs(v) do
                        if v.Type == "Scroll"  then
                            if i1 ~= "Rarity" and i1 ~= "MasteryRequirements" and i1 ~= "Scrolls" and i1 ~= "Equipped" and i1 ~= "Type" and i1 ~= "Value" and i1 ~= "Texture" then
                                if i1 == "Name" then
                                    PrintTable = PrintTable.."Scroll "..i1..": "..v1..", "
                                    else
                                        if i1 == "MaxCount" then
                                            PrintTable = PrintTable..i1..": "..v1.." | "
                                            else
                                            PrintTable = PrintTable..i1..": "..v1..", "
                                        end
                                end
                        end
                    end
                end
                end

                for i,v in pairs(Inventory) do
                    for i1,v1 in pairs(v) do
                        if v.Type == "Usable"  then
                            if i1 ~= "Rarity" and i1 ~= "MasteryRequirements" and i1 ~= "Scrolls" and i1 ~= "Equipped" and i1 ~= "Type" and i1 ~= "Value" and i1 ~= "Texture" then
                                if i1 == "Name" then
                                    PrintTable = PrintTable.."Useable "..i1..": "..v1..", "
                                    else
                                        if i1 == "MaxCount" then
                                            PrintTable = PrintTable..i1..": "..v1.." | "
                                            else
                                            PrintTable = PrintTable..i1..": "..v1..", "
                                        end
                                end
                        end
                    end
                end
                end
                        
    end)
    end
end
---------------------
-- webhook func
function SendWebhook1()
    if SendPlayerDataAsWebhook then

local data = {

   ["content"] = "",
   
   ["avatar_url"] = "https://i.imgur.com/OBqZkBq.png",

   ["embeds"] = {

       {

           ["title"] = 'Player Data Collected! '..tostring(os.date("[%X]")),

           ["description"] = "__Player Info:__".."**\nName:  **"..Name.."\n **Level:  **"..Level.."\n**Bounty: **"..Bounty.."\n**Current Fruit:  **"..DevilFruit.."\n**Race:  **"..Race.."\n**Fragments:  **"..Fragments.."\n**Beli:  **"..Beli.."\n**Valor Level:  **"..Valor,

           ["type"] = "rich",

           ["color"] = tonumber(0x7269da),

           ["thumbnail"] = {
                ["url"] = "https://i.imgur.com/LOkRYqi.png"
           },
           ["fields"] = { -- Make a table
				{ -- now make a new one for each field you wish to add
					["name"] = PlayerCurrentMelee;
					["value"] = "Mastery: "..PlayerCurrentMeleeLevel; -- The text,value or information under the title of the field aka name.
					["inline"] = true; -- means that its either inline with others, from left to right or if it is set to false, from up to down.
				},
				{
					["name"] = PlayerCurrentFruit;
					["value"] = "Mastery: "..PlayerCurrentFruitLevel;
					["inline"] = true;
				},
                {
					["name"] = "";
					["value"] = "";
					["inline"] = true;
				},
                {
					["name"] = PlayerCurrentSword;
					["value"] = "Mastery: "..PlayerCurrentSwordLevel;
					["inline"] = true;
				},
                {
					["name"] = PlayerCurrentGun;
					["value"] = "Mastery: "..PlayerCurrentGunLevel;
					["inline"] = true;
				}
			},

           ["footer"] = {
                ["text"] = "Date: "..tostring(os.date("%d/%m/%Y"))
           },

       }

   }

}

local newdata = game:GetService("HttpService"):JSONEncode(data)
local headers = {

   ["content-type"] = "application/json"

}

request = http_request or request or HttpPost or syn.request

local abcdef = {Url = DiscordWebhookUrl, Body = newdata, Method = "POST", Headers = headers}

request(abcdef)

end
end

function SendWebhook2(msg)
    if SendPlayerFruitDataAsWebhook then
    Content = '';
    Embed = {
        title = msg;
        color = tonumber(0xFF0000);
        description = " ";
    };
    (syn and syn.request or http_request) {
        Url = DiscordWebhookUrl;
        Method = 'POST';
        Headers = {
            ['Content-Type'] = 'application/json';
        };
        Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
    };
    end
end

function SendDataJson()
    if SendDataAsJson then
        local Name = game.Players.LocalPlayer.Name.."_Data" .. ".json"
        writefile(Name, game:GetService("HttpService"):JSONEncode(PrintTable))

        local fileName = game.Players.LocalPlayer.Name.."_Data" .. ".json" -- Đặt tên tệp JSON của bạn
        local fileData = readfile(fileName) -- Đọc nội dung tệp JSON
        
        -- URL avatar
        local AvatarUrl = "https://i.imgur.com/OBqZkBq.png" -- Thay bằng URL avatar của bạn
        
        -- Tạo nội dung body của yêu cầu với multipart/form-data
        local boundary = "------------------------" .. game:GetService("HttpService"):GenerateGUID(false)
        local body = "--" .. boundary .. "\r\n"
            .. "Content-Disposition: form-data; name=\"file\"; filename=\"" .. fileName .. "\"\r\n"
            .. "Content-Type: application/json\r\n\r\n"
            .. fileData .. "\r\n"
            .. "--" .. boundary .. "\r\n"
            .. "Content-Disposition: form-data; name=\"avatar_url\"\r\n\r\n"
            .. AvatarUrl .. "\r\n"
            .. "--" .. boundary .. "--"
        
        -- Định nghĩa headers
        local headers = {
            ["Content-Type"] = "multipart/form-data; boundary=" .. boundary,
            ["Content-Length"] = tostring(#body),
        }
        
        -- Gửi yêu cầu HTTP
        local requestFunction = http_request or request or HttpPost or syn.request
        if requestFunction then
            local response = requestFunction({
                Url = DiscordWebhookUrl, -- Thay trực tiếp URL webhook Discord tại đây
                Method = "POST",
                Headers = headers,
                Body = body,
            })
        
            -- Hiển thị phản hồi để kiểm tra lỗi hoặc thành công
            if response then
                if tonumber(response.StatusCode) < 400 then
                print("Trạng thái: Successfully Excuted")
                game:GetService'StarterGui':SetCore("SendNotification", {
                    Title = "Shin dep trai", -- Notification title
                    Text = "Sent Data Successfully", -- Notification text
                    Icon = "https://i.imgur.com/LOkRYqi.png", -- Notification icon (optional)
                    Duration = 5, -- Duration of the notification (optional, may be overridden if more than 3 notifs appear)
                  })
                else
                print("Trạng thái: Webhook failed")
                end
            else
                print("Không nhận được phản hồi từ máy chủ.")
            end
        else
            print("Không tìm thấy hàm gửi HTTP!")
        end
    end
end


--Run Function
SendWebhook1()

SendWebhook2(PlayerFruitList1)
SendWebhook2(PlayerFruitList2)
SendWebhook2(PlayerFruitList3)


--
wait(_G.AutoExecuteData["TimePerExecute"])

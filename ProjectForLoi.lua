
--game.Players.LocalPlayer.PlayerGui.Main.DragonSelection.Root.DragonSelectionMenu.Enabled = false
Name = game:GetService('Players').LocalPlayer.Name
Level = game:GetService('Players').LocalPlayer.Data.Level.Value
Bounty = game:GetService('Players').LocalPlayer.leaderstats['Bounty/Honor'].Value
DevilFruit = game:GetService('Players').LocalPlayer.Data.DevilFruit.Value
Race = game:GetService('Players').LocalPlayer.Data.Race.Value
Fragments = game:GetService('Players').LocalPlayer.Data.Fragments.Value
Beli = game:GetService('Players').LocalPlayer.Data.Beli.Value
Valor = game:GetService('Players').LocalPlayer.Data.Valor.Value

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
end)

-- Get Fruit Data
pcall(function()
    FruitTable = {}
    PlayerFruitTable = {}
    local args = {
        [1] = "GetFruits",
        [2] = false
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    
    game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.GetPlayerData:InvokeServer()
    game:GetService("ReplicatedStorage").Remotes.GetFruitData:InvokeServer()
    
        Fruit = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        for i,v in pairs(Fruit) do
            for a,b in pairs(v) do
                   if a == "Name" then
                table.insert(FruitTable,b)
                    end
            end
        end
     ---get Fruit in Inventory
        local args = {
            [1] = "getInventory"
        }
            game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.GetPlayerData:InvokeServer()
            game:GetService("ReplicatedStorage").Remotes.GetFruitData:InvokeServer()
        
           local Inventory = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
           for i,v in pairs(Inventory) do
                if table.find(FruitTable,v.Name) then
                    for i1,v1 in pairs(v) do
                        if i1 == "Count" then
                            table.insert(PlayerFruitTable,v.Name.." ["..v1.."]")
                        end
                    end
                end
           end
    end)
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

--Function chia bang lam 3
    local totalElements = #PlayerFruitTable
    local partSize = math.ceil(totalElements / 3)  -- Chia tổng số phần tử cho 3 và làm tròn lên
    
    -- Chia bảng thành 3 phần
    local firstPart = {}
    local secondPart = {}
    local thirdPart = {}
    
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
    
    local PlayerFruitList1 = "•Fruit Inventory:\n"
        for _, player in ipairs(firstPart) do
            PlayerFruitList1 = PlayerFruitList1 ..  player .. "\n"
        end
    
    local PlayerFruitList2 = "•Fruit Inventory:\n"
        for _, player in ipairs(secondPart) do
            PlayerFruitList2 = PlayerFruitList2 ..  player .. "\n"
        end
    
    local PlayerFruitList3 = "•Fruit Inventory:\n"
        for _, player in ipairs(thirdPart) do
            PlayerFruitList3 = PlayerFruitList3 ..  player .. "\n"
        end
-------------------
--Collect Player Data
pcall(function()
    FruitTable2 = {}
    PlayerFruitTable2 = {}
    TestTable2 = {}
    PlayerFruitData = {}
    --Remote Event
    game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.GetPlayerData:InvokeServer()
    game:GetService("ReplicatedStorage").Remotes.GetFruitData:InvokeServer()   
        Fruit2 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
        Inventory2 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
--
        -- ListFruit from FruitStock:
        for i,v in pairs(Fruit2) do
            for a,b in pairs(v) do
                   if a == "Name" then
                table.insert(FruitTable2,b)
                    end
            end
        end
        ---
        for i,v in pairs(Inventory2) do
            if table.find(FruitTable2,v.Name) then               
                table.insert(TestTable2,v.Name)
            end
        end
        ---
        for i,v in pairs(Inventory2) do
            if table.find(FruitTable2,v.Name) then               
                        table.insert(PlayerFruitData,v)
            end
       end
        ---
PrintTable = "Player Name: "..Name..", ".."Level: "..Level..", ".."Bounty: "..Bounty..", ".."Race: "..Race..", ".."Fragments: "..Fragments..", ".."Beli: "..Beli..", ".."Valor Level: "..Valor..", ".."Melee: "..PlayerCurrentMelee..", ".."Mastery: "..PlayerCurrentMeleeLevel..", ".."Blox Fruit: "..PlayerCurrentFruit..", ".."Mastery: "..PlayerCurrentFruitLevel..", ".."Sword: "..PlayerCurrentSword..", ".."Mastery: "..PlayerCurrentSwordLevel..", ".."Gun: "..PlayerCurrentGun..", ".."Mastery: "..PlayerCurrentGunLevel.."| "

       for i,v in pairs(FruitTable2) do
        NameFruit = v
        if table.find(TestTable2,v) then
            PrintTable = PrintTable.."Fruit Name: "..NameFruit.." , "
            for l,k in pairs(PlayerFruitData) do
                if k.Name == NameFruit then
                    for a,b in pairs(k) do
                        if a ~= "AwakeningData" and a ~= "Equipped" and a~= "MasteryRequirements" and a ~= "Type" and a~= "Name" and a ~= "Value" and a ~= "Rarity" then
                            if a~= "Mastery" then
                            PrintTable = PrintTable..a.." = "..b.." , "
                            else
                                PrintTable = PrintTable..a.." = "..b.." | "
                            end
                        end
                    end
                end
            end
        else
           PrintTable = PrintTable.."Fruit Name: "..v.." , ".."Count = 0".." , ".."Mastery : Unknown | "
       end
    end
end)
---------------------

function SendDataJson()
    if SendDataAsJson then
    local Name = game.Players.LocalPlayer.Name.."_Data" .. ".json"
    writefile(Name, game:service'HttpService':JSONEncode(PrintTable))
    
    local fileName = game.Players.LocalPlayer.Name.."_Data" .. ".json" -- Đặt tên tệp JSON của bạn

    -- URL webhook Discord
    
    -- Đọc nội dung tệp JSON
    local fileData = readfile(fileName)
    
    -- Tạo nội dung body của yêu cầu với multipart/form-data
    local boundary = "------------------------" .. game:GetService("HttpService"):GenerateGUID(false)
    local body = "--" .. boundary .. "\r\n"
        .. "Content-Disposition: form-data; name=\"file\"; filename=\"" .. fileName .. "\"\r\n"
        .. "Content-Type: application/json\r\n\r\n"
        .. fileData .. "\r\n--" .. boundary .. "--"
    
    -- Định nghĩa headers
    local headers = {
        ["Content-Type"] = "multipart/form-data; boundary=" .. boundary,
        ["Content-Length"] = tostring(#body),
    }
    
    -- Gửi yêu cầu HTTP
    local requestFunction = http_request or request or HttpPost or syn.request
    if requestFunction then
        local response = requestFunction({
            Url = DiscordWebhookUrl,
            Method = "POST",
            Headers = headers,
            Body = body,
        })
    
        -- Hiển thị phản hồi để kiểm tra lỗi hoặc thành công
        if response then
            print("Trạng thái: " .. response.StatusCode)
            print("Phản hồi: " .. response.Body)
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

SendDataJson()
--

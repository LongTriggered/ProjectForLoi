repeat wait() until game:IsLoaded()
repeat wait() until game:GetService('Players').LocalPlayer.Character
repeat wait() until game:GetService('Players').LocalPlayer.Backpack
--Needed
game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.GetPlayerData:InvokeServer()
game:GetService("ReplicatedStorage").Remotes.GetFruitData:InvokeServer()

local Sea = 0
if game.PlaceId == 2753915549 then
    Sea = 1
elseif game.PlaceId == 4442272183 then
    Sea = 2
elseif game.PlaceId == 7449423635 then
	Sea = 3
end
Player = game:GetService('Players').LocalPlayer

function getCharacter()
    CharacterReturn = game:GetService('Players').LocalPlayer.Character or game:GetService('Players').LocalPlayer.CharacterAdded:Wait()
    return CharacterReturn
end

function getData()
    local datachinh = {
        data = {
                player_info = {
                    ["Player Name"]                 = Player.Name,
                    ["Level"]                       = tostring(Player.Data.Level.Value),
                    ["Bounty"]                      = tostring(Player.leaderstats['Bounty/Honor'].Value),
                    ["Race"]                        = tostring(Player.Data.Race.Value..getRaceLevel()),
                    ["Fragments"]                   = tostring(Player.Data.Fragments.Value),
                    ["Beli"]                        = tostring(Player.Data.Beli.Value),
                    ["Valor Level"]                 = tostring(Player.Data.Valor.Value),
                    ["Fruit Capacity"]              = tostring(Player.Data.FruitCap.Value),
                    ["Total Killed Elite Hunter"]   = tostring(checkEliteHunter()),
                    ["Spy"]                         = tostring(checkSpy()),
                    ["Combo"]                       = getCombo()
                            },
                melees_info = getAllMelee(),
                fruits_info = getFruitInventory(),
                time        = os.time()
                }     
            }
    for i,v in pairs(getItemType()) do -- for items_info
        local rename_to_s_info = string.sub(v, 1, 1):lower() .. string.sub(v,2).."s_info"
            datachinh.data[rename_to_s_info] = getItem()[v]
    end
    return datachinh
end

function getRaceLevel()
    local RaceV4     = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaceV4Progress","Check")
    local RaceV3     = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad","1")
    local RaceV2     = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist")
    if RaceV4 == 4 then
        return " [V4]"                
    elseif RaceV3 == -2 then
        return " [V3]"
    elseif RaceV2 == -2 then
        return " [V2]"                
    else
        return " [V1]"                
    end
end

function getInventory()
    local Inventory = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
    return Inventory
end

function getFruitStock()
    local Fruit = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits",false)
    return Fruit
end

function getCombo()
    local ComboTable = {
        Melee = {
            Name = "",
            Mastery = ""
        },
        BloxFruit = {
            Name = "",
            Mastery = ""
        },
        Sword = {
            Name = "",
            Mastery = ""
        },
        Gun = {
            Name = "",
            Mastery = ""
        }
    }
    
    --Check in Backpack
    for i ,v in pairs(Player.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            if v.ToolTip == "Melee" or v.ToolTip == "Blox Fruit" or v.ToolTip == "Sword" or v.ToolTip == "Gun" then
                ComboTable[tostring(string.gsub(v.ToolTip," ",""))].Name =  v.Name
                ComboTable[tostring(string.gsub(v.ToolTip," ",""))].Mastery = tostring(Player.Backpack[v.Name].Level.Value)
            end
        end
    end
        --Check in Character
    for i ,v in pairs(getCharacter():GetChildren()) do
        if v:IsA("Tool") then
            if v.ToolTip == "Melee" or v.ToolTip == "Blox Fruit" or v.ToolTip == "Sword" or v.ToolTip == "Gun" then
                ComboTable[tostring(string.gsub(v.ToolTip," ",""))].Name =  v.Name
                ComboTable[tostring(string.gsub(v.ToolTip," ",""))].Mastery = tostring(getCharacter()[v.Name].Level.Value)
            end
        end
    end
    
    -- function getCurrentCombo()
    --     local combo = {}
    --     for _, v in ipairs({"Melee", "Fruit", "Sword", "Gun"}) do
    --         combo["PlayerCurrent"..v], combo["PlayerCurrent"..v.."Level"] = "", ""
    --     end
        
    --     for _, c in pairs({game.Players.LocalPlayer.Backpack, getCharacter()}) do
    --         for _, t in pairs(c:GetChildren()) do
    --             if t:IsA("Tool") then
    --                 local tip = t.ToolTip == "Blox Fruit" and "Fruit" or t.ToolTip
    --                 if combo["PlayerCurrent"..tip] then
    --                     combo["PlayerCurrent"..tip], combo["PlayerCurrent"..tip.."Level"] = t.Name, t.Level.Value
    --                 end
    --             end
    --         end
    --     end
    --     return combo
    -- end

    return ComboTable
end

function getAllMelee()
    local listAchievedMelee = {}
    local listMelee = {"BlackLeg","Electro","FishmanKarate","DragonClaw","Superhuman","DeathStep","SharkmanKarate","ElectricClaw","DragonTalon","Godhuman","SanguineArt"}

    for i,v in ipairs(listMelee) do
        local a = (v == "DragonClaw") and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1") or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy" .. v, true)
        if a == 1 or a == 2 then
            table.insert(listAchievedMelee, {Name = v})
        else
            print('khong co '..v)
        end
    end
    return listAchievedMelee
end

function getFruitInventory()
    local allfruitstock, allfruitstockname, allplayerfruit, allplayerfruitname, mixedTable = {}, {}, {}, {}, {}

    for i,v in pairs(getFruitStock()) do -- Get Fruits in FruitStock
        if  v.Name == "Dragon-Dragon" then
            table.insert(allfruitstock, {Name = "Dragon (West)-Dragon (West)" ,Rarity = "4"})
            table.insert(allfruitstock, {Name = "Dragon (East)-Dragon (East)", Rarity = "4"})
            table.insert(allfruitstockname,"Dragon (West)-Dragon (West)" )
            table.insert(allfruitstockname,"Dragon (East)-Dragon (East)")
        else
            table.insert(allfruitstock, {Name = v.Name, Rarity = tostring(v.Rarity)})
            table.insert(allfruitstockname,v.Name)
        end
    end

    for i,v in pairs(getInventory()) do     -- Get Fruit in Inventory
        if  table.find(allfruitstockname,v.Name) then
            table.insert(allplayerfruit,v)
            table.insert(allplayerfruitname,v.Name)
       end
    end

    for i, v in ipairs(allfruitstock) do
        if table.find(allplayerfruitname, v.Name) then -- if player fruit in fruitstock
            for a,b in pairs(allplayerfruit) do
                if b.Name == v.Name then
                    table.insert(mixedTable, {Name = v.Name, Rarity = v.Rarity, Count = tostring(b.Count), Mastery = tostring(b.Mastery)})
                end
            end
        else
            table.insert(mixedTable,{Name = v.Name,  Rarity = v.Rarity, Count = "0", Mastery = "-"})
        end
    end

    return mixedTable
end

function getItemType()
    local item_type = {}

    for i,v in pairs(getInventory()) do -- Lay tat ca item type trong inv
        if v.Type ~= "Blox Fruit" then
            table.insert(item_type,v.Type) 
        end
    end

    table.sort(item_type)
    for i = #item_type, 2, -1 do -- Loại bỏ phần tử trùng lặp
        if item_type[i] == item_type[i-1] then
            table.remove(item_type, i)
        end
    end

    return item_type
end

function getItem()

    local AlternativeInventory = {}
    for i,v in pairs(getInventory()) do
        AlternativeInventory[v.Name] = {}
        for a,b in pairs(v) do
            if a ~= "Rarity" and a ~= "MasteryRequirements" and a ~= "Scrolls" and a ~= "Equipped" and a ~= "Type" and a ~= "Value" and a ~= "Texture" then
                AlternativeInventory[v.Name][a] = b
            end
        end
    end


    local item_table = {}
        for i,v in pairs(getItemType()) do -- {Gun,Material,Sword,Usable,Wear,..}
            -- local typetable = string.sub(v, 1, 1):lower() .. string.sub(v,2).."s_info"
            item_table[v] = {}
            for a,b in pairs(getInventory()) do
                if b.Type == v then
                    for a1, b1 in pairs(b) do
                        if a1 ~= "Rarity" and a1 ~= "MasteryRequirements" and a1 ~= "Scrolls" and a1 ~= "Equipped" and a1 ~= "Type" and a1 ~= "Value" and a1 ~= "Texture" then
                                table.insert(item_table[v], b)
                        end
                    end
                end
            end
        end
    return AlternativeInventory
end

function checkEliteHunter()
    if Sea == 3 then

        local EliteHunterProcess = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress")
        return EliteHunterProcess

    else
        return '`Không tìm thấy`'
    end
end

function checkSpy()
    if Sea == 3 then

        local Spy = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan",1)
        if Spy == -1 then
            return "Still in Cooldown"
        else
            return "Found Leviathan"
        end

    else
        return '`Không tìm thấy`'
    end
end

function fileCheck(filename)
    local success, result = pcall(function()
        return game:GetService('HttpService'):JSONDecode(readfile(Player.Name.. "_" ..filename.. ".json"))
    end)
    if success then
        print('co file '..filename)
        return true
    else print('deo co file '..filename) return false
    end
end

function fileCreate(filename,table)
    writefile(Player.Name.. "_" ..filename.. ".json", game:GetService('HttpService'):JSONEncode(table))
end

function fileGet(filename)
    return game:GetService('HttpService'):JSONDecode(readfile(Player.Name.. "_" ..filename.. ".json"))
end

function sendJson(filename,data)
    fileCreate(filename,data)
    local fileData = readfile(Player.Name.. "_" ..filename.. ".json")
    -- URL avatar
    local AvatarUrl = "https://i.imgur.com/OBqZkBq.png" -- Thay bằng URL avatar của bạn
    
    -- Tạo nội dung body của yêu cầu với multipart/form-data
    local boundary = "------------------------" .. game:GetService("HttpService"):GenerateGUID(false)
    local body = "--" .. boundary .. "\r\n"
        .. "Content-Disposition: form-data; name=\"file\"; filename=\"" .. Player.Name.. "_" ..filename.. ".json" .. "\"\r\n"
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
    local requestFunction = http_request or request or HttpPost
    if requestFunction then
        local response = requestFunction({
            Url = DiscordWebhookUrl,
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

game:GetService('Players').PlayerRemoving:Connect(function(player) -- Save Time when player leave
    if player.Name == game:GetService('Players').LocalPlayer.Name and _G.AutoExecuteData["AutoExecute"] then 
           fileCreate("Time",PassedTime)
        end
end)

function Notify()
    if not _G.AutoExecuteData["AutoExecute"] then
        print('Sending Data, method: Non AutoExecute')
        sendJson("Data",getData())
    else
        local ExecutedTime = os.time()
        local SavedTime = 0

        -- if ExecutedTime == _G.AutoExecuteData["NotifyTime"] then
        --     print('Sending Data, Method: AutoExecute("Server time reached NotifyTime)')
        -- end

        if not fileCheck("Time") then -- Check saved time
            fileCreate("Time", 0)
            print('does not have Time file')
        else
            SavedTime = fileGet("Time")
            print("archieved SavedTime "..SavedTime)
        end

        while _G.AutoExecuteData["AutoExecute"] do
                local CurrentTime = os.time()
                PassedTime = CurrentTime - ExecutedTime + SavedTime
                print(PassedTime)
                if PassedTime >= _G.AutoExecuteData["NotifyTime"] then
                    print("Sending Data, Method: AutoExecute(PassedTime reached NotifyTime)")
                    sendJson("Data",getData())
                    ExecutedTime = os.time()
                    SavedTime = 0
                end
                task.wait(1)
            end
        end
    end

for i,v in pairs(getItem()) do
	for a,b in pairs(v) do
		print(a,b)
	end
	print("-----------")
end
print('2')

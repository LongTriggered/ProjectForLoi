
 DiscordWebhookUrl = "https://discord.com/api/webhooks/1328437666416562280/IFvig8H4Ll47jk2V_nHcEqZcpcnQe9c5DMhHx_TnTg3kW4sNU7kdUwnGbIUNH6Kregg5"
--game.Players.LocalPlayer.PlayerGui.Main.DragonSelection.Root.DragonSelectionMenu.Enabled = false
Name = game.Players.LocalPlayer.Name
Level = game.Players.LocalPlayer.Data.Level.Value
Bounty = game.Players.LocalPlayer.leaderstats['Bounty/Honor'].Value
DevilFruit = game.Players.LocalPlayer.Data.DevilFruit.Value
Race =game.Players.LocalPlayer.Data.Race.Value
Fragments = game.Players.LocalPlayer.Data.Fragments.Value
Beli = game.Players.LocalPlayer.Data.Beli.Value

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
function SendWebHook1()

local data = {

   ["content"] = "",
   
   ["avatar_url"] = "https://i.imgur.com/LOkRYqi.png",

   ["embeds"] = {

       {

           ["title"] = 'Player Data Collected! '..tostring(os.date("[%X]")),

           ["description"] = "__Player Info:__".."**\nName:  **"..Name.."\n **Level:  **"..Level.."\n**Bounty: **"..Bounty.."\n**Current Fruit:  **"..DevilFruit.."\n**Race:  **"..Race.."\n**Fragments:  **"..Fragments.."\n**Beli:  **"..Beli,

           ["type"] = "rich",

           ["color"] = tonumber(0x7269da),

           ["footer"] = {
                ["text"] = "Date: "..tostring(os.date("%d/%m/%Y"))
           },

           ["image"] = {

               ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..

                   tostring(game:GetService("Players").LocalPlayer.Name)

           }

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
    ---
SendWebHook1()

function sendwebhook2(msg)
    Content = '';
    Embed = {
        title = msg;
        color = tonumber(0xFF0000);
        description = " ";
    };
    (syn and syn.request or http_request) {
        Url = "https://discord.com/api/webhooks/1328437666416562280/IFvig8H4Ll47jk2V_nHcEqZcpcnQe9c5DMhHx_TnTg3kW4sNU7kdUwnGbIUNH6Kregg5";
        Method = 'POST';
        Headers = {
            ['Content-Type'] = 'application/json';
        };
        Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
    };
    end
    
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
    
    sendwebhook2(PlayerFruitList1)
    sendwebhook2(PlayerFruitList2)
    sendwebhook2(PlayerFruitList3)

--Send Data Into Json code ( t luoi gop code lai )
    pcall(function()
        FruitTable2 = {}
        PlayerFruitTable2 = {}
        TestTable2 = {}
        local args = {
            [1] = "GetFruits",
            [2] = false}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))    
        game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.GetPlayerData:InvokeServer()
        game:GetService("ReplicatedStorage").Remotes.GetFruitData:InvokeServer()
            Fruit2 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            for i,v in pairs(Fruit2) do
                for a,b in pairs(v) do
                       if a == "Name" then
                    table.insert(FruitTable2,b)
                        end
                end
            end
            local args = {[1] = "getInventory"}
                game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.GetPlayerData:InvokeServer()
                game:GetService("ReplicatedStorage").Remotes.GetFruitData:InvokeServer()   
               local Inventory2 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               for i,v in pairs(Inventory2) do
                    if table.find(FruitTable2,v.Name) then               
                                table.insert(TestTable2,v)
                    end
               end
        end)
        PrintTable = ""
        for i,v in pairs(TestTable2) do
            PrintTable = PrintTable.."Fruit Name: "..v.Name.." , "
           for a,b in pairs(v) do
            if a ~= "Type" and a ~= "Equipped" and a ~= "MasteryRequirements" and a~= "AwakeningData" and a~= "Name" and a~= "Value" then
                if a~= "Mastery" then
            PrintTable = PrintTable..a.."="..b.." , "
                else
            PrintTable = PrintTable..a.."="..b.." | "
                end
        end
    end
    end
    local Name = game.Players.LocalPlayer.Name.."_Data" .. ".json"
    writefile(Name, game:service'HttpService':JSONEncode(PrintTable))
    [[
    local set
    if not pcall(function() readfile(Name) end) then 
        writefile(Name, game:service'HttpService':JSONEncode(PrintTable))
         end
    
    set = game:service'HttpService':JSONDecode(readfile(Name))
    ]]
    ---

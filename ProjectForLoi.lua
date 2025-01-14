
 DiscordWebhookUrl =
   "https://discord.com/api/webhooks/1328437666416562280/IFvig8H4Ll47jk2V_nHcEqZcpcnQe9c5DMhHx_TnTg3kW4sNU7kdUwnGbIUNH6Kregg5"
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
local FruitTable = {}
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
                print("Ten :",v.Name)
                for i1,v1 in pairs(v) do
                    if i1 == "Count" then
                        print("So luong: ",v1)
                    end
                end
            end
       end
end)
-- webhook func
function SendWebHook()

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

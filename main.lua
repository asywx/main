-- Roblox Fly + Random TP + Aimbot + ESP + Auto Shoot (Solara kompatibilis)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- VirtualInputManager betöltése az Auto Shoot szimulációhoz
local VirtualInputManager = game:GetService("VirtualInputManager")

-- UI Létrehozása
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolaraFlyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Fő Panel (Átméretezve a plusz gomb miatt)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 350)
MainFrame.Position = UDim2.new(0.5, -110, 0.4, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Cím / Fejléc
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BorderSizePixel = 0
Title.Text = "SOLARA MULTITOOL v3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Fly Ki/Be Kapcsoló Gomb
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0, 180, 0, 35)
FlyButton.Position = UDim2.new(0.5, -90, 0, 45)
FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FlyButton.Text = "Fly: OFF"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextSize = 15
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = FlyButton

-- Random TP Gomb
local TpButton = Instance.new("TextButton")
TpButton.Size = UDim2.new(0, 180, 0, 35)
TpButton.Position = UDim2.new(0.5, -90, 0, 90)
TpButton.BackgroundColor3 = Color3.fromRGB(40, 100, 200)
TpButton.Text = "Random TP"
TpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TpButton.TextSize = 15
TpButton.Font = Enum.Font.SourceSansBold
TpButton.Parent = MainFrame

local TpCorner = Instance.new("UICorner")
TpCorner.CornerRadius = UDim.new(0, 6)
TpCorner.Parent = TpButton

-- ESP Ki/Be Kapcsoló Gomb
local EspButton = Instance.new("TextButton")
EspButton.Size = UDim2.new(0, 180, 0, 35)
EspButton.Position = UDim2.new(0.5, -90, 0, 135)
EspButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
EspButton.Text = "ESP: OFF"
EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EspButton.TextSize = 15
EspButton.Font = Enum.Font.SourceSansBold
EspButton.Parent = MainFrame

local EspCorner = Instance.new("UICorner")
EspCorner.CornerRadius = UDim.new(0, 6)
EspCorner.Parent = EspButton

-- Auto Shoot Ki/Be Kapcsoló Gomb
local AutoShootButton = Instance.new("TextButton")
AutoShootButton.Size = UDim2.new(0, 180, 0, 35)
AutoShootButton.Position = UDim2.new(0.5, -90, 0, 180)
AutoShootButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AutoShootButton.Text = "Auto Shoot: OFF"
AutoShootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoShootButton.TextSize = 15
AutoShootButton.Font = Enum.Font.SourceSansBold
AutoShootButton.Parent = MainFrame

local AutoShootCorner = Instance.new("UICorner")
AutoShootCorner.CornerRadius = UDim.new(0, 6)
AutoShootCorner.Parent = AutoShootButton

-- Aimbot Infó Panel
local AimLabel = Instance.new("TextLabel")
AimLabel.Size = UDim2.new(1, 0, 0, 25)
AimLabel.Position = UDim2.new(0, 0, 0, 230)
AimLabel.BackgroundTransparency = 1
AimLabel.Text = "[Jobb Klikk: AIMBOT]"
AimLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
AimLabel.TextSize = 14
AimLabel.Font = Enum.Font.SourceSansBold
AimLabel.Parent = MainFrame

-- Sebesség Kijelző
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0, 0, 0, 260)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Sebesség: 50"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.Parent = MainFrame

-- Sebesség Csökkentése (-)
local DecSpeed = Instance.new("TextButton")
DecSpeed.Size = UDim2.new(0, 40, 0, 30)
DecSpeed.Position = UDim2.new(0, 20, 0, 295)
DecSpeed.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DecSpeed.Text = "-"
DecSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
DecSpeed.TextSize = 18
DecSpeed.Font = Enum.Font.SourceSansBold
DecSpeed.Parent = MainFrame

local DecCorner = Instance.new("UICorner")
DecCorner.CornerRadius = UDim.new(0, 4)
DecCorner.Parent = DecSpeed

-- Sebesség Növelése (+)
local IncSpeed = Instance.new("TextButton")
IncSpeed.Size = UDim2.new(0, 40, 0, 30)
IncSpeed.Position = UDim2.new(1, -60, 0, 295)
IncSpeed.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
IncSpeed.Text = "+"
IncSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
IncSpeed.TextSize = 18
IncSpeed.Font = Enum.Font.SourceSansBold
IncSpeed.Parent = MainFrame

local IncCorner = Instance.new("UICorner")
IncCorner.CornerRadius = UDim.new(0, 4)
IncCorner.Parent = IncSpeed


-- GLOBÁLIS BEÁLLÍTÁSOK ÉS LOGIKÁK --
local flying = false
local speed = 50
local espEnabled = false
local autoShootEnabled = false
local holdingRightClick = false
local espObjects = {}
local bodyVelocity, bodyGyro

-- REPÜLÉS --
local function startFlying()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local root = character.HumanoidRootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.cframe = root.CFrame
    bodyGyro.Parent = root

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = root

    character:FindFirstChildOfClass("Humanoid").PlatformStand = true

    coroutine.wrap(function()
        while flying and character and root and bodyVelocity and bodyGyro do
            local moveDirection = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end

            if moveDirection.Magnitude > 0 then bodyVelocity.velocity = moveDirection.Unit * speed else bodyVelocity.velocity = Vector3.new(0, 0, 0) end
            bodyGyro.cframe = Camera.CFrame
            RunService.RenderStepped:Wait()
        end
    end)()
end

local function stopFlying()
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then character:FindFirstChildOfClass("Humanoid").PlatformStand = false end
end

-- RANDOM TP --
local function teleportToRandomPlayer()
    local allPlayers = Players:GetPlayers()
    local targets = {}
    for _, player in ipairs(allPlayers) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then table.insert(targets, player) end
    end
    if #targets > 0 then
        local randomPlayer = targets[math.random(1, #targets)]
        local myCharacter = LocalPlayer.Character
        if myCharacter and myCharacter:FindFirstChild("HumanoidRootPart") then
            local wasFlying = flying
            if wasFlying then stopFlying() end
            myCharacter.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            if wasFlying then task.wait(0.1) startFlying() end
        end
    end
end

-- AIMBOT ÉS AUTO SHOOT --
local function getClosestPlayerToCursor()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            local head = player.Character.Head
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if distance < shortestDistance then shortestDistance = distance; closestPlayer = player end
            end
        end
    end
    return closestPlayer
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then holdingRightClick = true end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then holdingRightClick = false end
end)

-- ESP --
local function createESP(player)
    if espObjects[player] then return end
    local box = Instance.new("BoxHandleAdornment")
box.Name = "SolaraESPBox"; box.AlwaysOnTop = true; box.ZIndex = 5; box.Color3 = Color3.fromRGB(255, 50, 50); box.Transparency = 0.5
local billboard = Instance.new("BillboardGui")
billboard.Name = "SolaraESPName"; billboard.AlwaysOnTop = true; billboard.Size = UDim2.new(0, 200, 0, 50); billboard.StudsOffset = Vector3.new(0, 3, 0)
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0); label.BackgroundTransparency = 1; label.TextColor3 = Color3.fromRGB(255, 255, 255); label.TextStrokeTransparency = 0; label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0); label.TextSize = 12; label.Font = Enum.Font.SourceSansBold; label.Parent = billboard
espObjects[player] = {Box = box, Billboard = billboard, Label = label}
end
local function removeESP(player)
if espObjects[player] then espObjects[player].Box:Destroy(); espObjects[player].Billboard:Destroy(); espObjects[player] = nil end
end
-- FŐ CIKLUS (RenderStepped) --
local lastShot = 0
RunService.RenderStepped:Connect(function()
local targetPlayer = nil
-- Aimbot logikája
if holdingRightClick then
targetPlayer = getClosestPlayerToCursor()
if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPlayer.Character.Head.Position)
-- Auto Shoot logikája (Csak ha be van kapcsolva ÉS van érvényes célpont bemérve)
if autoShootEnabled and tick() - lastShot > 0.1 then -- Kis késleltetés a kattintások közt a stabilitásért
lastShot = tick()
VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0) -- Bal klikk lenyomása
task.wait(0.02)
VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0) -- Bal klikk elengedése
end
end
end
-- ESP logikája
for _, player in ipairs(Players:GetPlayers()) do
if espEnabled and player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
createESP(player)
local data = espObjects[player]
local root = player.Character.HumanoidRootPart
data.Box.Adornee = player.Character; data.Box.Size = player.Character:GetExtentsSize(); data.Box.Parent = root
data.Billboard.Adornee = root; data.Billboard.Parent = root
local distance = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude) or 0)
data.Label.Text = player.Name .. " [" .. distance .. "m]"
else
removeESP(player)
end
end
end)
Players.PlayerRemoving:Connect(removeESP)
-- UI GOMBOK KEZELÉSE --
FlyButton.MouseButton1Click:Connect(function()
flying = not flying
if flying then FlyButton.Text = "Fly: ON"; FlyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50); startFlying() else FlyButton.Text = "Fly: OFF"; FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50); stopFlying() end
end)
TpButton.MouseButton1Click:Connect(function() teleportToRandomPlayer() end)
EspButton.MouseButton1Click:Connect(function()
espEnabled = not espEnabled
if espEnabled then EspButton.Text = "ESP: ON"; EspButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50) else EspButton.Text = "ESP: OFF"; EspButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50); for p, _ in pairs(espObjects) do removeESP(p) end end
end)
AutoShootButton.MouseButton1Click:Connect(function()
autoShootEnabled = not autoShootEnabled
if autoShootEnabled then
AutoShootButton.Text = "Auto Shoot: ON"
AutoShootButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
else
AutoShootButton.Text = "Auto Shoot: OFF"
AutoShootButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end
end)
IncSpeed.MouseButton1Click:Connect(function() speed = math.min(speed + 10, 300); SpeedLabel.Text = "Sebesség: " .. speed end)
DecSpeed.MouseButton1Click:Connect(function() speed = math.max(speed - 10, 10); SpeedLabel.Text = "Sebesség: " .. speed end)
LocalPlayer.CharacterAdded:Connect(function() flying = false; FlyButton.Text = "Fly: OFF"; FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) end)

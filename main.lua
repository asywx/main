local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualInputManager = game:GetService("VirtualInputManager")

-- UI Létrehozása
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolaraFlyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Fő Panel (Magasság megnövelve 520-ra az új gombok miatt)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 520)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, -260)
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
Title.Text = "SOLARA MULTITOOL PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Fly Gomb (F)
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0, 180, 0, 32)
FlyButton.Position = UDim2.new(0.5, -90, 0, 45)
FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FlyButton.Text = "Fly: OFF [F]"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextSize = 14
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = FlyButton

-- Noclip Gomb (N)
local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(0, 180, 0, 32)
NoclipButton.Position = UDim2.new(0.5, -90, 0, 82)
NoclipButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
NoclipButton.Text = "Noclip: OFF [N]"
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.TextSize = 14
NoclipButton.Font = Enum.Font.SourceSansBold
NoclipButton.Parent = MainFrame

local NoclipCorner = Instance.new("UICorner")
NoclipCorner.CornerRadius = UDim.new(0, 6)
NoclipCorner.Parent = NoclipButton

-- Random TP Gomb
local TpButton = Instance.new("TextButton")
TpButton.Size = UDim2.new(0, 180, 0, 32)
TpButton.Position = UDim2.new(0.5, -90, 0, 119)
TpButton.BackgroundColor3 = Color3.fromRGB(40, 100, 200)
TpButton.Text = "Random TP"
TpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TpButton.TextSize = 14
TpButton.Font = Enum.Font.SourceSansBold
TpButton.Parent = MainFrame

local TpCorner = Instance.new("UICorner")
TpCorner.CornerRadius = UDim.new(0, 6)
TpCorner.Parent = TpButton

-- Nearest TP Gomb (ÚJ!)
local TpNearestButton = Instance.new("TextButton")
TpNearestButton.Size = UDim2.new(0, 180, 0, 32)
TpNearestButton.Position = UDim2.new(0.5, -90, 0, 156)
TpNearestButton.BackgroundColor3 = Color3.fromRGB(40, 140, 200)
TpNearestButton.Text = "TP to Nearest Player"
TpNearestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TpNearestButton.TextSize = 14
TpNearestButton.Font = Enum.Font.SourceSansBold
TpNearestButton.Parent = MainFrame

local TpNearestCorner = Instance.new("UICorner")
TpNearestCorner.CornerRadius = UDim.new(0, 6)
TpNearestCorner.Parent = TpNearestButton

-- ESP Gomb (E)
local EspButton = Instance.new("TextButton")
EspButton.Size = UDim2.new(0, 180, 0, 32)
EspButton.Position = UDim2.new(0.5, -90, 0, 193)
EspButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
EspButton.Text = "ESP: OFF [E]"
EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EspButton.TextSize = 14
EspButton.Font = Enum.Font.SourceSansBold
EspButton.Parent = MainFrame

local EspCorner = Instance.new("UICorner")
EspCorner.CornerRadius = UDim.new(0, 6)
EspCorner.Parent = EspButton

-- Aimbot Gomb (K)
local AimbotToggleBtn = Instance.new("TextButton")
AimbotToggleBtn.Size = UDim2.new(0, 180, 0, 32)
AimbotToggleBtn.Position = UDim2.new(0.5, -90, 0, 230)
AimbotToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AimbotToggleBtn.Text = "Aimbot: OFF [K]"
AimbotToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggleBtn.TextSize = 14
AimbotToggleBtn.Font = Enum.Font.SourceSansBold
AimbotToggleBtn.Parent = MainFrame

local AimToggleCorner = Instance.new("UICorner")
AimToggleCorner.CornerRadius = UDim.new(0, 6)
AimToggleCorner.Parent = AimbotToggleBtn

-- Auto Shoot Gomb (É)
local AutoShootButton = Instance.new("TextButton")
AutoShootButton.Size = UDim2.new(0, 180, 0, 32)
AutoShootButton.Position = UDim2.new(0.5, -90, 0, 267)
AutoShootButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AutoShootButton.Text = "Auto Shoot: OFF [É]"
AutoShootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoShootButton.TextSize = 14
AutoShootButton.Font = Enum.Font.SourceSansBold
AutoShootButton.Parent = MainFrame

local AutoShootCorner = Instance.new("UICorner")
AutoShootCorner.CornerRadius = UDim.new(0, 6)
AutoShootCorner.Parent = AutoShootButton

-- ==================== STATISZTIKÁK ÉS IRÁNYÍTÓK ====================

-- 1. Repülési Sebesség (Fly Speed)
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 305)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Repülési Sebesség: 50"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.Parent = MainFrame

local DecSpeed = Instance.new("TextButton")
DecSpeed.Size = UDim2.new(0, 35, 0, 25)
DecSpeed.Position = UDim2.new(0, 20, 0, 325)
DecSpeed.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DecSpeed.Text = "-"
DecSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
DecSpeed.TextSize = 16
DecSpeed.Font = Enum.Font.SourceSansBold
DecSpeed.Parent = MainFrame
Instance.new("UICorner", DecSpeed).CornerRadius = UDim.new(0, 4)

local IncSpeed = Instance.new("TextButton")
IncSpeed.Size = UDim2.new(0, 35, 0, 25)
IncSpeed.Position = UDim2.new(1, -55, 0, 325)
IncSpeed.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
IncSpeed.Text = "+"
IncSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
IncSpeed.TextSize = 16
IncSpeed.Font = Enum.Font.SourceSansBold
IncSpeed.Parent = MainFrame
Instance.new("UICorner", IncSpeed).CornerRadius = UDim.new(0, 4)

-- 2. Séta Sebesség (WalkSpeed - ÚJ!)
local WalkLabel = Instance.new("TextLabel")
WalkLabel.Size = UDim2.new(1, 0, 0, 20)
WalkLabel.Position = UDim2.new(0, 0, 0, 355)
WalkLabel.BackgroundTransparency = 1
WalkLabel.Text = "Séta Sebesség: 16"
WalkLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
WalkLabel.TextSize = 12
WalkLabel.Font = Enum.Font.SourceSans
WalkLabel.Parent = MainFrame

local DecWalk = Instance.new("TextButton")
DecWalk.Size = UDim2.new(0, 35, 0, 25)
DecWalk.Position = UDim2.new(0, 20, 0, 375)
DecWalk.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DecWalk.Text = "-"
DecWalk.TextColor3 = Color3.fromRGB(255, 255, 255)
DecWalk.TextSize = 16
DecWalk.Font = Enum.Font.SourceSansBold
DecWalk.Parent = MainFrame
Instance.new("UICorner", DecWalk).CornerRadius = UDim.new(0, 4)

local IncWalk = Instance.new("TextButton")
IncWalk.Size = UDim2.new(0, 35, 0, 25)
IncWalk.Position = UDim2.new(1, -55, 0, 375)
IncWalk.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
IncWalk.Text = "+"
IncWalk.TextColor3 = Color3.fromRGB(255, 255, 255)
IncWalk.TextSize = 16
IncWalk.Font = Enum.Font.SourceSansBold
IncWalk.Parent = MainFrame
Instance.new("UICorner", IncWalk).CornerRadius = UDim.new(0, 4)

-- 3. Ugrás Ereje (JumpPower - ÚJ!)
local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(1, 0, 0, 20)
JumpLabel.Position = UDim2.new(0, 0, 0, 405)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "Ugrás Ereje: 50"
JumpLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpLabel.TextSize = 12
JumpLabel.Font = Enum.Font.SourceSans
JumpLabel.Parent = MainFrame

local DecJump = Instance.new("TextButton")
DecJump.Size = UDim2.new(0, 35, 0, 25)
DecJump.Position = UDim2.new(0, 20, 0, 425)
DecJump.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DecJump.Text = "-"
DecJump.TextColor3 = Color3.fromRGB(255, 255, 255)
DecJump.TextSize = 16
DecJump.Font = Enum.Font.SourceSansBold
DecJump.Parent = MainFrame
Instance.new("UICorner", DecJump).CornerRadius = UDim.new(0, 4)

local IncJump = Instance.new("TextButton")
IncJump.Size = UDim2.new(0, 35, 0, 25)
IncJump.Position = UDim2.new(1, -55, 0, 425)
IncJump.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
IncJump.Text = "+"
IncJump.TextColor3 = Color3.fromRGB(255, 255, 255)
IncJump.TextSize = 16
IncJump.Font = Enum.Font.SourceSansBold
IncJump.Parent = MainFrame
Instance.new("UICorner", IncJump).CornerRadius = UDim.new(0, 4)

-- Reset Character Gomb (Kényelmi funkció)
local ResetCharBtn = Instance.new("TextButton")
ResetCharBtn.Size = UDim2.new(0, 180, 0, 30)
ResetCharBtn.Position = UDim2.new(0.5, -90, 0, 470)
ResetCharBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ResetCharBtn.Text = "Reset Custom Speed/Jump"
ResetCharBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
ResetCharBtn.TextSize = 12
ResetCharBtn.Font = Enum.Font.SourceSansBold
ResetCharBtn.Parent = MainFrame
Instance.new("UICorner", ResetCharBtn).CornerRadius = UDim.new(0, 6)


-- GLOBÁLIS LOGIKÁK --
local flying = false
local noclip = false
local speed = 50
local walkSpeedValue = 16
local jumpPowerValue = 50
local espEnabled = false
local aimbotEnabled = false
local autoShootEnabled = false
local espObjects = {}
local bodyVelocity, bodyGyro

-- FLY --
local function startFlying()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
Körültekintően használja a kódot.
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
if moveDirection.Magnitude > 0 then
bodyVelocity.velocity = moveDirection.Unit * speed
else
bodyVelocity.velocity = Vector3.new(0, 0, 0)
end
bodyGyro.cframe = Camera.CFrame
RunService.RenderStepped:Wait()
end
end)()
end
local function stopFlying()
if bodyVelocity then bodyVelocity:Destroy() end
if bodyGyro then bodyGyro:Destroy() end
local character = LocalPlayer.Character
if character and character:FindFirstChildOfClass("Humanoid") then
character:FindFirstChildOfClass("Humanoid").PlatformStand = false
end
end
local function toggleFly()
flying = not flying
if flying then
FlyButton.Text = "Fly: ON [F]"
FlyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
startFlying()
else
FlyButton.Text = "Fly: OFF [F]"
FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopFlying()
end
end
-- NOCLIP --
local function toggleNoclip()
noclip = not noclip
if noclip then
NoclipButton.Text = "Noclip: ON [N]"
NoclipButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
else
NoclipButton.Text = "Noclip: OFF [N]"
NoclipButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end
end
-- RANDOM TP --
local function teleportToRandomPlayer()
local allPlayers = Players:GetPlayers()
local targets = {}
for _, player in ipairs(allPlayers) do
if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
table.insert(targets, player)
end
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
-- NEAREST TP (ÚJ!) --
local function teleportToNearestPlayer()
local myCharacter = LocalPlayer.Character
if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then return end
local myRoot = myCharacter.HumanoidRootPart
local nearestPlayer = nil
local shortestDistance = math.huge
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
local pRoot = player.Character.HumanoidRootPart
local distance = (myRoot.Position - pRoot.Position).Magnitude
if distance < shortestDistance then
shortestDistance = distance
nearestPlayer = player
end
end
end
if nearestPlayer then
local wasFlying = flying
if wasFlying then stopFlying() end
myRoot.CFrame = nearestPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
if wasFlying then task.wait(0.1) startFlying() end
end
end
-- AIMBOT TARGET FINDER --
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
if distance < shortestDistance then
shortestDistance = distance
closestPlayer = player
end
end
end
end
return closestPlayer
end
local function toggleAimbot()
aimbotEnabled = not aimbotEnabled
if aimbotEnabled then
AimbotToggleBtn.Text = "Aimbot: ON [K]"
AimbotToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
else
AimbotToggleBtn.Text = "Aimbot: OFF [K]"
AimbotToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end
end
-- AUTO SHOOT --
local function toggleAutoShoot()
autoShootEnabled = not autoShootEnabled
if autoShootEnabled then
AutoShootButton.Text = "Auto Shoot: ON [É]"
AutoShootButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
else
AutoShootButton.Text = "Auto Shoot: OFF [É]"
AutoShootButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end
end
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
if espObjects[player] then
espObjects[player].Box:Destroy()
espObjects[player].Billboard:Destroy()
espObjects[player] = nil
end
end
local function toggleESP()
espEnabled = not espEnabled
if espEnabled then
EspButton.Text = "ESP: ON [E]"
EspButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
else
EspButton.Text = "ESP: OFF [E]"
EspButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
for p, _ in pairs(espObjects) do removeESP(p) end
end
end
-- BILLENTYŰK FIGYELÉSE (Keybinds) --
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end
if input.KeyCode == Enum.KeyCode.F then
toggleFly()
elseif input.KeyCode == Enum.KeyCode.N then
toggleNoclip()
elseif input.KeyCode == Enum.KeyCode.E then
toggleESP()
elseif input.KeyCode == Enum.KeyCode.K then
toggleAimbot()
elseif input.KeyCode == Enum.KeyCode.Semicolon then -- Magyar 'É'
toggleAutoShoot()
end
end)
-- FŐ ITERÁCIÓS CIKLUS --
local lastShot = 0
RunService.RenderStepped:Connect(function()
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
-- WALKPOWER / JUMPPOWER KÉNYSZERÍTÉS (ÚJ!) --
if humanoid then
humanoid.WalkSpeed = walkSpeedValue
if humanoid.UseJumpPower then
humanoid.JumpPower = jumpPowerValue
else
-- Ha a játék JumpHeight-ot használ JumpPower helyett, átszámoljuk durván arra
humanoid.JumpHeight = (jumpPowerValue * jumpPowerValue) / (2 * workspace.Gravity)
end
end
-- NOCLIP ITERÁCIÓ --
if noclip and character then
for _, part in ipairs(character:GetDescendants()) do
if part:IsA("BasePart") and part.CanCollide then
part.CanCollide = false
end
end
end
-- AIMBOT ÉS AUTO SHOOT --
local isRightClickPressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
if aimbotEnabled and isRightClickPressed then
local targetPlayer = getClosestPlayerToCursor()
if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPlayer.Character.Head.Position)
if autoShootEnabled and tick() - lastShot > 0.08 then
lastShot = tick()
VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
task.wait(0.01)
VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end
end
end
-- ESP FRISSÍTÉSE --
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
-- KATTINTÁSOK REGISZTRÁCIÓJA --
FlyButton.MouseButton1Click:Connect(toggleFly)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)
TpButton.MouseButton1Click:Connect(teleportToRandomPlayer)
TpNearestButton.MouseButton1Click:Connect(teleportToNearestPlayer) -- Új esemény
EspButton.MouseButton1Click:Connect(toggleESP)
AimbotToggleBtn.MouseButton1Click:Connect(toggleAimbot)
AutoShootButton.MouseButton1Click:Connect(toggleAutoShoot)
-- Sebesség gombok
IncSpeed.MouseButton1Click:Connect(function()
speed = math.min(speed + 10, 300)
SpeedLabel.Text = "Repülési Sebesség: " .. speed
end)
DecSpeed.MouseButton1Click:Connect(function()
speed = math.max(speed - 10, 10)
SpeedLabel.Text = "Repülési Sebesség: " .. speed
end)
-- Séta gombok (Új!)
IncWalk.MouseButton1Click:Connect(function()
walkSpeedValue = math.min(walkSpeedValue + 5, 250)
WalkLabel.Text = "Séta Sebesség: " .. walkSpeedValue
end)
DecWalk.MouseButton1Click:Connect(function()
walkSpeedValue = math.max(walkSpeedValue - 5, 0)
WalkLabel.Text = "Séta Sebesség: " .. walkSpeedValue
end)
-- Ugrás gombok (Új!)
IncJump.MouseButton1Click:Connect(function()
jumpPowerValue = math.min(jumpPowerValue + 10, 300)
JumpLabel.Text = "Ugrás Ereje: " .. jumpPowerValue
end)
DecJump.MouseButton1Click:Connect(function()
jumpPowerValue = math.max(jumpPowerValue - 10, 0)
JumpLabel.Text = "Ugrás Ereje: " .. jumpPowerValue
end)
-- Alaphelyzet gomb (Új!)
ResetCharBtn.MouseButton1Click:Connect(function()
walkSpeedValue = 16
jumpPowerValue = 50
WalkLabel.Text = "Séta Sebesség: 16"
JumpLabel.Text = "Ugrás Ereje: 50"
end)
LocalPlayer.CharacterAdded:Connect(function()
flying = false
noclip = false
FlyButton.Text = "Fly: OFF [F]"
FlyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
NoclipButton.Text = "Noclip: OFF [N]"
NoclipButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end)

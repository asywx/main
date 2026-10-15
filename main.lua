local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Korábbi UI takarítása
if CoreGui:FindFirstChild("SolaraSmoothBlackUI") then CoreGui.SolaraSmoothBlackUI:Destroy() end
if CoreGui:FindFirstChild("SolaraKeySystemUI") then CoreGui.SolaraKeySystemUI:Destroy() end

-- === KULCS BEÁLLÍTÁSA ===
local CorrectKey = "SOLARA_FREE_2026" -- Ezt írd át amire szeretnéd!
local KeyVerified = false

-- === ÁLLAPOTOK ===
local FlyEnabled = false
local EspEnabled = false
local NoclipEnabled = false
local UiVisible = false -- Alapból hamis, csak sikeres kulcs után nyitható
local FlySpeed = 50
local BodyGyro, BodyVelocity
local ActiveEspObjects = {}
local NoclipConnection

-- === KEY SYSTEM UI LÉTREHOZÁSA ===
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "SolaraKeySystemUI"
KeyGui.Parent = CoreGui
KeyGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.4, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(40, 40, 40)
KeyStroke.Thickness = 1
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
KeyTitle.Text = "  SOLARA KEY SYSTEM"
KeyTitle.TextColor3 = Color3.fromRGB(235, 235, 235)
KeyTitle.TextSize = 13
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyFrame

local KeyTitleCorner = Instance.new("UICorner")
KeyTitleCorner.CornerRadius = UDim.new(0, 10)
KeyTitleCorner.Parent = KeyTitle

local KeyLine = Instance.new("Frame")
KeyLine.Size = UDim2.new(1, 0, 0, 1)
KeyLine.Position = UDim2.new(0, 0, 0, 39)
KeyLine.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyLine.BorderSizePixel = 0
KeyLine.Parent = KeyFrame

-- Kulcs beviteli mező (TextBox)
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -40, 0, 35)
TextBox.Position = UDim2.new(0, 20, 0, 65)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextBox.BorderSizePixel = 0
TextBox.Text = ""
TextBox.PlaceholderText = "Írd ide a kulcsot..."
TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 14
TextBox.Font = Enum.Font.SourceSans
TextBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = TextBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.fromRGB(45, 45, 45)
BoxStroke.Thickness = 1
BoxStroke.Parent = TextBox

-- Ellenőrzés Gomb
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(1, -40, 0, 35)
SubmitBtn.Position = UDim2.new(0, 20, 0, 115)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "Kulcs Ellenőrzése"
SubmitBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Parent = KeyFrame

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = SubmitBtn

-- === FŐ MENÜ UI (SMOOTH BLACK THEME) ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolaraSmoothBlackUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 220)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Alapból rejtve
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(40, 40, 40)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Title.Text = "  SOLARA MENU [RShift]"
Title.TextColor3 = Color3.fromRGB(235, 235, 235)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, 0, 0, 1)
Line.Position = UDim2.new(0, 0, 0, 39)
Line.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Line.BorderSizePixel = 0
Line.Parent = MainFrame

-- Menü elrejtése/megjelenítése (Right Shift) - Csak ha a kulcs már jó!
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift and KeyVerified then
        UiVisible = not UiVisible
        MainFrame.Visible = UiVisible
    end
end)

-- === SMOOTH SWITCH LÉTREHOZÓ ===
local function CreateToggle(name, position, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    ToggleFrame.Position = position
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = MainFrame

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = name
    TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextLabel.TextSize = 14
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = ToggleFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 45, 0, 22)
    Button.Position = UDim2.new(1, -45, 0.5, -11)
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.Text = ""
    Button.Parent = ToggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0)
    BtnCorner.Parent = Button

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 3, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Circle.Parent = Button

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle

    local Enabled = false
    Button.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        callback(Enabled)
        if Enabled then
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 150, 50)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        end
    end)
end

-- === LOGIKÁK (FLY, NOCLIP, ESP) ===
local function ManageFly(state)
    FlyEnabled = state
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local RootPart = Character.HumanoidRootPart

    if FlyEnabled then
        if Character:FindFirstChild("Animate") then Character.Animate.Disabled = true end
        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.P = 9e4
        BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BodyGyro.cframe = RootPart.CFrame
        BodyGyro.Parent = RootPart

        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
        BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        BodyVelocity.Parent = RootPart

        task.spawn(function()
            while FlyEnabled and Character and RootPart and BodyGyro and BodyVelocity do
                task.wait()
                local MoveVector = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveVector = MoveVector + CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveVector = MoveVector - CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveVector = MoveVector - CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveVector = MoveVector + CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveVector = MoveVector + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then MoveVector = MoveVector - Vector3.new(0, 1, 0) end

                BodyGyro.cframe = CurrentCamera.CFrame
                if MoveVector.Magnitude > 0 then
                    BodyVelocity.velocity = MoveVector.Unit * FlySpeed
                else
                    BodyVelocity.velocity = Vector3.new(0, 0, 0)
                end
            end
            if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
            if BodyVelocity then BodyVelocity:Destroy() BodyVelocity = nil end
            if Character and Character:FindFirstChild("Animate") then Character.Animate.Disabled = false end
end)
else
if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
if BodyVelocity then BodyVelocity:Destroy() BodyVelocity = nil end
if Character and Character:FindFirstChild("Animate") then Character.Animate.Disabled = false end
end
end
local function ManageNoclip(state)
NoclipEnabled = state
if NoclipEnabled then
NoclipConnection = RunService.Stepped:Connect(function()
local Character = LocalPlayer.Character
if Character and NoclipEnabled then
for _, child in pairs(Character:GetDescendants()) do
if child:IsA("BasePart") then child.CanCollide = false end
end
end
end)
else
if NoclipConnection then NoclipConnection:Disconnect() NoclipConnection = nil end
end
end
local function RemoveESP(player)
if ActiveEspObjects[player] then
if ActiveEspObjects[player].Billboard then ActiveEspObjects[player].Billboard:Destroy() end
if ActiveEspObjects[player].Highlight then ActiveEspObjects[player].Highlight:Destroy() end
if ActiveEspObjects[player].Connection then ActiveEspObjects[player].Connection:Disconnect() end
ActiveEspObjects[player] = nil
end
end
local function ApplyAdvancedESP(player)
if player == LocalPlayer then return end
RemoveESP(player)
local function CharacterSetup(character)
if not character then return end
local head = character:WaitForChild("Head", 5)
local humanoid = character:WaitForChild("Humanoid", 5)
if not head or not humanoid then return end
local Highlight = Instance.new("Highlight")
Highlight.FillColor = Color3.fromRGB(255, 255, 255)
Highlight.FillTransparency = 0.6
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
Highlight.Enabled = EspEnabled
Highlight.Parent = character
local Billboard = Instance.new("BillboardGui")
Billboard.Size = UDim2.new(0, 200, 0, 50)
Billboard.StudsOffset = Vector3.new(0, 2.5, 0)
Billboard.AlwaysOnTop = true
Billboard.Enabled = EspEnabled
Billboard.Adornee = head
Billboard.Parent = head
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextSize = 14
TextLabel.Parent = Billboard
local function UpdateText()
if humanoid and humanoid.Parent then
TextLabel.Text = string.format("%s\n[HP: %d/%d]", player.Name, math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
end
end
local connection = humanoid.HealthChanged:Connect(UpdateText)
UpdateText()
ActiveEspObjects[player] = {Billboard = Billboard, Highlight = Highlight, TextLabel = TextLabel, Connection = connection}
end
if player.Character then CharacterSetup(player.Character) end
player.CharacterAdded:Connect(CharacterSetup)
end
local function ManageESP(state)
EspEnabled = state
for player, objects in pairs(ActiveEspObjects) do
if objects.Billboard then objects.Billboard.Enabled = state end
if objects.Highlight then objects.Highlight.Enabled = state end
end
end
-- Gombok bekötése a fő UI-hoz
CreateToggle("Repülés (Fly)", UDim2.new(0, 10, 0, 55), ManageFly)
CreateToggle("Falon átjárás (Noclip)", UDim2.new(0, 10, 0, 105), ManageNoclip)
CreateToggle("Játékos ESP (Name+HP)", UDim2.new(0, 10, 0, 155), ManageESP)
-- === KULCS ELLENŐRZÉS LOGIKA ===
SubmitBtn.MouseButton1Click:Connect(function()
if TextBox.Text == CorrectKey then
KeyVerified = true
UiVisible = true
-- Siker animáció (Zöld villanás) és bezárás
TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 150, 50), Text = "SIKERES BELÉPÉS!"}):Play()
task.wait(0.5)
KeyGui:Destroy() -- Kulcs ablak törlése
MainFrame.Visible = true -- Főmenü megjelenítése
-- ESP Elindítása a többi játékosra
for _, player in pairs(Players:GetPlayers()) do ApplyAdvancedESP(player) end
Players.PlayerAdded:Connect(ApplyAdvancedESP)
Players.PlayerRemoving:Connect(RemoveESP)
print("Solara sikeresen feloldva!")
else
-- Hiba animáció (Piros villanás)
TextBox.Text = ""
TweenService:Create(BoxStroke, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {Color = Color3.fromRGB(200, 50, 50)}):Play()
SubmitBtn.Text = "HIBÁS KULCS!"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
task.wait(1)
SubmitBtn.Text = "Kulcs Ellenőrzése"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
end
end)

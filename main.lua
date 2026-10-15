local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService") -- Szükséges a nocliphez

-- Korábbi UI takarítása
if CoreGui:FindFirstChild("SolaraSmoothBlackUI") then
    CoreGui.SolaraSmoothBlackUI:Destroy()
end

-- === ÁLLAPOTOK ===
local FlyEnabled = false
local EspEnabled = false
local NoclipEnabled = false
local UiVisible = true
local FlySpeed = 50
local BodyGyro, BodyVelocity
local ActiveEspObjects = {}
local NoclipConnection

-- === UI LÉTREHOZÁSA (SMOOTH BLACK THEME) ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolaraSmoothBlackUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
-- Megnöveltem a magasságot 180-ról 220-ra, hogy kényelmesen elférjen a 3 gomb
MainFrame.Size = UDim2.new(0, 240, 0, 220)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
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
Title.Text = "  HunScripts Cheat Panel V2"
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

-- Menü elrejtése (Right Shift)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
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

-- === FLY LOGIKA ===
local function ManageFly(state)
    FlyEnabled = state
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local RootPart = Character.HumanoidRootPart

    if FlyEnabled then
        if Character:FindFirstChild("Animate") then
            Character.Animate.Disabled = true
        end

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

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    MoveVector = MoveVector + CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    MoveVector = MoveVector - CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    MoveVector = MoveVector - CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    MoveVector = MoveVector + CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    MoveVector = MoveVector + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    MoveVector = MoveVector - Vector3.new(0, 1, 0)
                end

                BodyGyro.cframe = CurrentCamera.CFrame
                if MoveVector.Magnitude > 0 then
                    BodyVelocity.velocity = MoveVector.Unit * FlySpeed
                else
                    BodyVelocity.velocity = Vector3.new(0, 0, 0)
                end
            end
            
            if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
            if BodyVelocity then BodyVelocity:Destroy() BodyVelocity = nil end
            if Character and Character:FindFirstChild("Animate") then
                Character.Animate.Disabled = false
            end
        end)
    else
        if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
        if BodyVelocity then BodyVelocity:Destroy() BodyVelocity = nil end
        if Character and Character:FindFirstChild("Animate") then
            Character.Animate.Disabled = false
        end
    end
end

-- === NOCLIP LOGIKA ===
local function ManageNoclip(state)
    NoclipEnabled = state
    
    if NoclipEnabled then
        -- Minden frame-ben lefut és kikapcsolja a CanCollide-ot
        NoclipConnection = RunService.Stepped:Connect(function()
            local Character = LocalPlayer.Character
            if Character and NoclipEnabled then
                for _, child in pairs(Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide then
                        child.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
    end
end

-- === ADVANCED ESP LOGIKA ===
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
        Highlight.Name = "SolaraESP_Core"
        Highlight.FillColor = Color3.fromRGB(255, 255, 255)
        Highlight.FillTransparency = 0.6
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        Highlight.OutlineTransparency = 0
        Highlight.Adornee = character
        Highlight.Enabled = EspEnabled
        Highlight.Parent = character

        local Billboard = Instance.new("BillboardGui")
        Billboard.Name = "SolaraESP_Text"
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
TextLabel.TextStrokeTransparency = 0
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
if state and objects.TextLabel and player.Character and player.Character:FindFirstChild("Humanoid") then
local hum = player.Character.Humanoid
objects.TextLabel.Text = string.format("%s\n[HP: %d/%d]", player.Name, math.floor(hum.Health), math.floor(hum.MaxHealth))
end
end
end
-- Kezelők minden játékosra
for _, player in pairs(Players:GetPlayers()) do
ApplyAdvancedESP(player)
end
Players.PlayerAdded:Connect(ApplyAdvancedESP)
Players.PlayerRemoving:Connect(RemoveESP)
-- Gombok bekötése az UI-hoz
CreateToggle("Repülés", UDim2.new(0, 10, 0, 55), ManageFly)
CreateToggle("Noclip", UDim2.new(0, 10, 0, 105), ManageNoclip)
CreateToggle("Player ESP (Name+HP)", UDim2.new(0, 10, 0, 155), ManageESP)
print("Smooth UI (Fly + Noclip + ESP) sikeresen betöltve!")

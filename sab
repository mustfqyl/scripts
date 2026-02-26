-- [[ BRAINROT V4.4 | Fixed Position Edition ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local trackingEnabled = false
local targetPlayer = nil
local guiVisible = true

-- UI KURULUMU (Sabitlenmiş)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GhostV4_Fixed"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 180, 0, 260)
mainFrame.Position = UDim2.new(1, -200, 0.4, 0) -- Ekranın sağ ortasında SABİT
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "GHOST V4.4"
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = mainFrame

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9, 0, 0, 140)
scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
scroll.BackgroundTransparency = 1
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 2
scroll.Parent = mainFrame

local listLayout = Instance.new("UIListLayout", scroll)
listLayout.Padding = UDim.new(0, 3)

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(0.4, 0, 0, 30)
startBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
startBtn.Text = "ON"
startBtn.TextColor3 = Color3.new(1, 1, 1)
startBtn.Font = Enum.Font.GothamBold
startBtn.Parent = mainFrame
Instance.new("UICorner", startBtn)

local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(0.4, 0, 0, 30)
stopBtn.Position = UDim2.new(0.55, 0, 0.75, 0)
stopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopBtn.Text = "OFF"
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.Parent = mainFrame
Instance.new("UICorner", stopBtn)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 20)
status.Position = UDim2.new(0, 0, 0.9, 0)
status.Text = "IDLE"
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.BackgroundTransparency = 1
status.Parent = mainFrame

-- OYUNCU LİSTESİ
local function updateList()
    for _, v in pairs(scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 25)
            b.Text = p.DisplayName
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.TextColor3 = Color3.new(1, 1, 1)
            b.Parent = scroll
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() 
                targetPlayer = p 
                status.Text = "HEDEF: " .. p.Name:sub(1,10)
            end)
        end
    end
end
Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)
updateList()

-- TAKİP VE SALDIRI MANTIĞI
RunService.Heartbeat:Connect(function()
    if trackingEnabled and targetPlayer and targetPlayer.Character then
        local char = player.Character
        local tChar = targetPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if root and tRoot and hum and hum.Health > 0 then
            local dist = (root.Position - tRoot.Position).Magnitude
            
            hum.AutoRotate = true

            -- ENGEL ALGILAMA (Raycast)
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {char}
            local rayResult = workspace:Raycast(root.Position, root.CFrame.LookVector * 3.5, rayParams)
            if rayResult and rayResult.Instance.CanCollide then
                hum.Jump = true
            end

            -- HAREKET
            if dist > 3.8 then
                hum:MoveTo(tRoot.Position)
            else
                hum:MoveTo(root.Position) -- Çok yakındaysa itişmeyi kes
            end

            -- GÜÇLÜ VURUŞ (Yerde)
            if dist < 10 then
                local tool = player.Backpack:FindFirstChildOfClass("Tool") or char:FindFirstChildOfClass("Tool")
                if tool then
                    if tool.Parent ~= char then hum:EquipTool(tool) end
                    tool:Activate()
                end
            end
        end
    end
end)

-- BUTONLAR VE GİZLEME
startBtn.MouseButton1Click:Connect(function() if targetPlayer then trackingEnabled = true status.Text = "AKTİF" status.TextColor3 = Color3.new(0,1,0) end end)
stopBtn.MouseButton1Click:Connect(function() trackingEnabled = false status.Text = "DURDU" status.TextColor3 = Color3.new(1,0,0) end)
UserInputService.InputBegan:Connect(function(i) if i.KeyCode == Enum.KeyCode.O or i.KeyCode == Enum.KeyCode.LeftAlt then mainFrame.Visible = not mainFrame.Visible end end) 

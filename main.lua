-- ================================================
--   GODMODE GUI - Dark Theme
-- ================================================

getgenv().TDI_LOADED = true

local plr        = game.Players.LocalPlayer
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ── HP Lock ───────────────────────────────────────
local godConn    = nil
local godEnabled = true

local function stopGod()
    if godConn then godConn:Disconnect(); godConn = nil end
end

local function startGod(char)
    stopGod()
    local hum = char:WaitForChild("Humanoid")
    hum.Health = hum.MaxHealth
    godConn = RunService.Heartbeat:Connect(function()
        if hum and hum.Parent then
            if hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        else stopGod() end
    end)
end

if plr.Character then startGod(plr.Character) end

plr.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if godEnabled then startGod(char) end
    warn('[GodmodeGUI] Auto-reloaded.')
end)

warn('[GodmodeGUI] Ready.')

-- ── GUI ───────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "GodmodeGUI"
ScreenGui.ResetOnSpawn    = false
ScreenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset  = true
ScreenGui.Parent          = plr:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size             = UDim2.new(0, 280, 0, 140)
MainFrame.Position         = UDim2.new(0.5, -140, 0.5, -70)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MainFrame.BorderSizePixel  = 0
MainFrame.Active           = true
MainFrame.Draggable        = true
MainFrame.Parent           = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size             = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
Header.BorderSizePixel  = 0
Header.ZIndex           = 2
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

-- Thin separator line under header (subtle, no glow)
local Sep = Instance.new("Frame", MainFrame)
Sep.Size             = UDim2.new(1, 0, 0, 1)
Sep.Position         = UDim2.new(0, 0, 0, 40)
Sep.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
Sep.BorderSizePixel  = 0
Sep.ZIndex           = 2

local Title = Instance.new("TextLabel", Header)
Title.Text                   = "⚡  GODMODE"
Title.Font                   = Enum.Font.GothamBold
Title.TextSize               = 14
Title.TextColor3             = Color3.fromRGB(220, 230, 255)
Title.BackgroundTransparency = 1
Title.Size                   = UDim2.new(1, -80, 1, 0)
Title.Position               = UDim2.new(0, 16, 0, 0)
Title.TextXAlignment         = Enum.TextXAlignment.Left
Title.ZIndex                 = 3

-- ✕ Close
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Text             = "✕"
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.TextSize         = 11
CloseBtn.TextColor3       = Color3.fromRGB(255, 70, 70)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 10, 10)
CloseBtn.Size             = UDim2.new(0, 28, 0, 22)
CloseBtn.Position         = UDim2.new(1, -34, 0.5, -11)
CloseBtn.BorderSizePixel  = 0
CloseBtn.ZIndex           = 4
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- − Minimize
local MinBtn = Instance.new("TextButton", Header)
MinBtn.Text             = "－"
MinBtn.Font             = Enum.Font.GothamBold
MinBtn.TextSize         = 13
MinBtn.TextColor3       = Color3.fromRGB(160, 170, 200)
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MinBtn.Size             = UDim2.new(0, 28, 0, 22)
MinBtn.Position         = UDim2.new(1, -66, 0.5, -11)
MinBtn.BorderSizePixel  = 0
MinBtn.ZIndex           = 4
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

-- ── HP Lock Row ───────────────────────────────────
local state = true

local Row = Instance.new("TextButton", MainFrame)
Row.Text             = ""
Row.Size             = UDim2.new(1, -24, 0, 50)
Row.Position         = UDim2.new(0, 12, 0, 52)
Row.BackgroundColor3 = Color3.fromRGB(14, 22, 18)
Row.BorderSizePixel  = 0
Row.ZIndex           = 3
Row.AutoButtonColor  = false
Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)

local SideBar = Instance.new("Frame", Row)
SideBar.Size            = UDim2.new(0, 3, 1, -10)
SideBar.Position        = UDim2.new(0, 5, 0, 5)
SideBar.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
SideBar.BorderSizePixel = 0
SideBar.ZIndex          = 4
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(1, 0)

local IconLbl = Instance.new("TextLabel", Row)
IconLbl.Text                   = "🛡"
IconLbl.Font                   = Enum.Font.Gotham
IconLbl.TextSize               = 20
IconLbl.BackgroundTransparency = 1
IconLbl.Size                   = UDim2.new(0, 32, 1, 0)
IconLbl.Position               = UDim2.new(0, 16, 0, 0)
IconLbl.ZIndex                 = 4

local Lbl = Instance.new("TextLabel", Row)
Lbl.Text                   = "HP Lock"
Lbl.Font                   = Enum.Font.GothamBold
Lbl.TextSize               = 12
Lbl.TextColor3             = Color3.fromRGB(210, 225, 245)
Lbl.BackgroundTransparency = 1
Lbl.Size                   = UDim2.new(1, -120, 0, 18)
Lbl.Position               = UDim2.new(0, 52, 0, 8)
Lbl.TextXAlignment         = Enum.TextXAlignment.Left
Lbl.ZIndex                 = 4

local DescLbl = Instance.new("TextLabel", Row)
DescLbl.Text                   = "Health locked at max."
DescLbl.Font                   = Enum.Font.Gotham
DescLbl.TextSize               = 9
DescLbl.TextColor3             = Color3.fromRGB(100, 130, 160)
DescLbl.BackgroundTransparency = 1
DescLbl.Size                   = UDim2.new(1, -120, 0, 14)
DescLbl.Position               = UDim2.new(0, 52, 0, 28)
DescLbl.TextXAlignment         = Enum.TextXAlignment.Left
DescLbl.ZIndex                 = 4

local PillBg = Instance.new("Frame", Row)
PillBg.Size            = UDim2.new(0, 52, 0, 24)
PillBg.Position        = UDim2.new(1, -62, 0.5, -12)
PillBg.BorderSizePixel = 0
PillBg.ZIndex          = 4
Instance.new("UICorner", PillBg).CornerRadius = UDim.new(1, 0)

local PillText = Instance.new("TextLabel", PillBg)
PillText.Font                   = Enum.Font.GothamBold
PillText.TextSize               = 10
PillText.BackgroundTransparency = 1
PillText.Size                   = UDim2.new(1, 0, 1, 0)
PillText.ZIndex                 = 5

local PillDot = Instance.new("Frame", PillBg)
PillDot.Size            = UDim2.new(0, 16, 0, 16)
PillDot.BorderSizePixel = 0
PillDot.ZIndex          = 5
Instance.new("UICorner", PillDot).CornerRadius = UDim.new(1, 0)

local function refresh()
    if state then
        PillBg.BackgroundColor3  = Color3.fromRGB(0, 60, 40)
        PillText.Text            = ""
        PillText.TextColor3      = Color3.fromRGB(0, 255, 140)
        PillDot.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
        PillDot.Position         = UDim2.new(1, -20, 0.5, -8)
        SideBar.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
        Row.BackgroundColor3     = Color3.fromRGB(14, 22, 18)
    else
        PillBg.BackgroundColor3  = Color3.fromRGB(50, 15, 15)
        PillText.Text            = ""
        PillText.TextColor3      = Color3.fromRGB(200, 60, 60)
        PillDot.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        PillDot.Position         = UDim2.new(0, 4, 0.5, -8)
        SideBar.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        Row.BackgroundColor3     = Color3.fromRGB(20, 14, 14)
    end
end

Row.MouseButton1Click:Connect(function()
    state = not state
    refresh()
    godEnabled = state
    if state then
        if plr.Character then startGod(plr.Character) end
        warn('[GodmodeGUI] HP Lock ON')
    else
        stopGod()
        warn('[GodmodeGUI] HP Lock OFF')
    end
end)
Row.MouseEnter:Connect(function()
    Row.BackgroundColor3 = state and Color3.fromRGB(18, 28, 22) or Color3.fromRGB(26, 16, 16)
end)
Row.MouseLeave:Connect(function()
    Row.BackgroundColor3 = state and Color3.fromRGB(14, 22, 18) or Color3.fromRGB(20, 14, 14)
end)

refresh()

-- Footer
local Hint = Instance.new("TextLabel", MainFrame)
Hint.Text                   = "[ RightAlt ] toggle GUI  ·  Click row: ON / OFF"
Hint.Font                   = Enum.Font.Gotham
Hint.TextSize               = 8
Hint.TextColor3             = Color3.fromRGB(50, 60, 80)
Hint.BackgroundTransparency = 1
Hint.Size                   = UDim2.new(1, 0, 0, 14)
Hint.Position               = UDim2.new(0, 0, 1, -18)
Hint.TextXAlignment         = Enum.TextXAlignment.Center
Hint.ZIndex                 = 3

-- ── Button Logic ──────────────────────────────────
CloseBtn.MouseButton1Click:Connect(function()
    stopGod()
    ScreenGui:Destroy()
end)
CloseBtn.MouseEnter:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(70,10,10) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(35,10,10) end)

local guiVisible = true
MinBtn.MouseButton1Click:Connect(function()
    guiVisible = false
    MainFrame.Visible = false
end)
MinBtn.MouseEnter:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(28,28,42) end)
MinBtn.MouseLeave:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,30) end)

-- RightAlt polling toggle
local wasDown = false
RunService.Heartbeat:Connect(function()
    local ok, isDown = pcall(function()
        return UIS:IsKeyDown(Enum.KeyCode.RightAlt)
    end)
    if not ok then return end
    if isDown and not wasDown then
        guiVisible = not guiVisible
        MainFrame.Visible = guiVisible
    end
    wasDown = isDown
end)

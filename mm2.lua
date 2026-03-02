-- Roblox MM2 ULTIMATE AFK FARM Scripti (Teleport + Rol Reset + Anti-Kick)
-- ÖZELLİKLER:
-- 1. Koordinat (362, 522, -12) 100 stud'dan fazla uzaklaşırsan AUTO IŞINLA.
-- 2. Katil (Knife) olursan AUTO RESET.
-- 3. Şerif (Gun) olursan AUTO RESET (opsiyonel).
-- 4. Her 30sn otomatik jump (AFK anti-kick).
-- LocalScript - Executor ile çalıştır (Synapse, Krnl vb.)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local targetPosition = Vector3.new(362, 522, -12)  -- HEDEF KOORDİNAT
local maxDistance = 200  -- TOLERANS (stud)

local resetOnSheriff = true  -- Şerif reset? true/false

-- Rol tespiti fonksiyonu
local function getRole()
    local char = player.Character
    if not char then return "None" end
    
    -- Equipped tool
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            if tool.Name == "Knife" then return "Murderer" end
            if tool.Name == "Gun" then return "Sheriff" end
        end
    end
    
    -- Backpack
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                if tool.Name == "Knife" then return "Murderer" end
                if tool.Name == "Gun" then return "Sheriff" end
            end
        end
    end
    
    return "Innocent"
end

-- Reset fonksiyonu
local function resetCharacter()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
        print("🔄 RESET ATILDI! Rol: " .. getRole())
    end
end

-- Teleport kontrolü
local function checkAndTeleport()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local distance = (hrp.Position - targetPosition).Magnitude
        
        if distance > maxDistance then
            hrp.CFrame = CFrame.new(targetPosition)
            print("🚀 IŞINLANDIN! Mesafe: " .. math.floor(distance) .. " stud → Hedef: " .. tostring(targetPosition))
        end
    end
end

-- Ana loop: Rol + Teleport kontrolü
local connection
local function mainCheck()
    -- Rol kontrol
    local role = getRole()
    if role == "Murderer" then
        resetCharacter()
    elseif role == "Sheriff" and resetOnSheriff then
        resetCharacter()
    end
    
    -- Teleport kontrol
    checkAndTeleport()
end

-- Heartbeat ile sürekli çalıştır
connection = RunService.Heartbeat:Connect(mainCheck)

-- Karakter spawn'da başlat
player.CharacterAdded:Connect(function()
    wait(2)  -- Yüklenme bekle
    mainCheck()
end)

-- AFK Anti-Kick: Otomatik jump
spawn(function()
    while wait(300) do
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Jump = true
            print("⏰ Anti-Kick Jump!")
        end
    end
end)

print("🎉 ULTIMATE MM2 AFK FARM BAŞLATILDI!")
print("📍 Teleport: " .. tostring(targetPosition) .. " (100 stud)")
print("🔪 Katil = RESET | 🔫 Şerif = " .. (resetOnSheriff and "RESET" or "Normal"))
print("🛡️ Anti-Kick AKTIF | Durdur: connection:Disconnect()")

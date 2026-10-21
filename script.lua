-- ============================================================
-- YUSUF BABAPİRO | YUVARLAK SİYAH BUTONLU ÖZEL PANEL
-- by: Yusuf
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Varolan Eski Paneli Temizle
if game:GetService("CoreGui"):FindFirstChild("YusufBabapiroGui") then
    game:GetService("CoreGui").YusufBabapiroGui:Destroy()
end

-- ============================================================
-- GUI OLUŞTURMA (Siyah Yuvarlak Butonlu Arayüz)
-- ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YusufBabapiroGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- 🔴 YUVARLAK SİYAH MENÜ BUTONU (Kapanıp Açmayı Sağlayan Kutucuk)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Siyah
ToggleBtn.Position = UDim2.new(0, 15, 0.2, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50) -- Tam Yuvarlak
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "Y"
ToggleBtn.TextColor3 = Color3.fromRGB(220, 20, 60) -- Kırmızı Y
ToggleBtn.TextSize = 22
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0) -- Tam Yuvarlak Yapma
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(220, 20, 60) -- Kırmızı Çerçeve
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Ana Çerçeve (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15
    

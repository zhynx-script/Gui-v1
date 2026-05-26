local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Bersihkan GUI lama agar tidak menumpuk saat di-execute ulang
if CoreGui:FindFirstChild("CustomExecutorGUI") then
    CoreGui.CustomExecutorGUI:Destroy()
end

-- Base ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomExecutorGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Ambil Aset Gambar Publik lewat sistem rbxthumb
local GAMBAR_BARU = "rbxthumb://type=Asset&id=123643587034959&w=420&h=420" -- ID Baru pilihanmu
local GAMBAR_2 = "rbxthumb://type=Asset&id=72722998279413&w=150&h=150"      -- Logo Mewtwo (Minimize)

----------------------------------------------------------------
-- 1. MAIN WINDOW (UKURAN DIPERKECIL & SKIN BIRU)
----------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 280) -- Ukuran diperkecil sedikit agar lebih pas
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true -- Memotong semua aset di dalam agar ikut membulat otomatis
MainFrame.Parent = ScreenGui

-- UPDATE WARNA: Efek Aura/Glow diganti menjadi BIRU NEON
local AuraGlow = Instance.new("UIStroke")
AuraGlow.Color = Color3.fromRGB(0, 191, 255) -- Deep Sky Blue
AuraGlow.Thickness = 3
AuraGlow.Transparency = 0.15
AuraGlow.Parent = MainFrame

-- Kelengkungan Sudut Bulat Sempurna
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- [BACKGROUND GAMBAR BARU]
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImage"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = GAMBAR_BARU -- Menggunakan ID baru
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ImageTransparency = 0.25 
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = MainFrame

-- Memastikan Ujung Gambar Mengikuti Lengkungan Frame Utama
local ImageCorner = Instance.new("UICorner")
ImageCorner.CornerRadius = UDim.new(0, 20)
ImageCorner.Parent = BackgroundImage

-- JUDUL: ANIME HUB
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 250, 0, 30)
TitleLabel.Position = UDim2.new(0, 20, 0, 15)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ANIME HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = MainFrame

----------------------------------------------------------------
-- 2. ANIMASI BOLA-BOLA API BIRU (BACKGROUND PARTIKEL BIRU)
----------------------------------------------------------------
local ParticleContainer = Instance.new("Frame")
ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
ParticleContainer.BackgroundTransparency = 1
ParticleContainer.ClipsDescendants = true
ParticleContainer.ZIndex = 2
ParticleContainer.Parent = MainFrame

local function BuatBolaBiru()
    local Bola = Instance.new("Frame")
    local Size = math.random(4, 9)
    Bola.Size = UDim2.new(0, Size, 0, Size)
    Bola.Position = UDim2.new(math.random(), 0, 1, 10)
    
    -- UPDATE WARNA: Efek partikel api melayang diubah menjadi BIRU CERAH
    Bola.BackgroundColor3 = Color3.fromRGB(0, 225, 255) 
    Bola.BackgroundTransparency = math.random(2, 6) / 10
    Bola.BorderSizePixel = 0
    Bola.ZIndex = 2
    Bola.Parent = ParticleContainer
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(1, 0)
    BCorner.Parent = Bola
    
    local TargetY = math.random(0, 35) / 100
    local TargetX = Bola.Position.X.Scale + (math.random(-12, 12) / 100)
    local Waktu = math.random(3, 5)
    
    local Tween = TweenService:Create(Bola, TweenInfo.new(Waktu, Enum.EasingStyle.Linear), {
        Position = UDim2.new(TargetX, 0, TargetY, -20),
        BackgroundTransparency = 1
    })
    
    Tween:Play()
    Tween.Completed:Connect(function()
        Bola:Destroy()
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        if MainFrame.Visible then
            BuatBolaBiru()
        end
    end
end)

----------------------------------------------------------------
-- 3. MINIMIZED WINDOW (KOTAK KECIL MEWTWO TEMA BIRU)
----------------------------------------------------------------
local MinimizedFrame = Instance.new("ImageButton")
MinimizedFrame.Name = "MinimizedFrame"
MinimizedFrame.Size = UDim2.new(0, 55, 0, 55)
MinimizedFrame.Position = UDim2.new(0.5, -27, 0.1, 0)
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
MinimizedFrame.Image = GAMBAR_2
MinimizedFrame.ScaleType = Enum.ScaleType.Crop
MinimizedFrame.Visible = false
MinimizedFrame.Parent = ScreenGui

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 14)
MinCorner.Parent = MinimizedFrame

-- Aura Biru untuk Kotak Minimize
local MinAura = Instance.new("UIStroke")
MinAura.Color = Color3.fromRGB(0, 191, 255)
MinAura.Thickness = 2
MinAura.Parent = MinimizedFrame

----------------------------------------------------------------
-- 4. TOMBOL MINIMIZE ( - ) DI POJOK KANAN ATAS
----------------------------------------------------------------
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -45, 0, 12)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "-"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 25
CloseBtn.Font = Enum.Font.SourceSans
CloseBtn.ZIndex = 4
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2, true, function()
        MainFrame.Visible = false
        MinimizedFrame.Visible = true
        MinimizedFrame:TweenSize(UDim2.new(0, 55, 0, 55), "Out", "Bounce", 0.25, true)
    end)
end)

MinimizedFrame.MouseButton1Click:Connect(function()
    MinimizedFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.15, true, function()
        MinimizedFrame.Visible = false
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 450, 0, 280), "Out", "Quad", 0.2, true)
    end)
end)

----------------------------------------------------------------
-- 5. FUNGSI DRAGGING (Bisa Digeser)
----------------------------------------------------------------
local function DaftarkanDrag(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

DaftarkanDrag(MainFrame)
DaftarkanDrag(MinimizedFrame)

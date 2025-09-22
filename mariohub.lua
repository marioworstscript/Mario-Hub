-- Crear un ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Crear un Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 200) -- Tamaño cuadrado de 200x200
frame.Position = UDim2.new(0.5, -100, 0.5, -100) -- Posición inicial en el centro
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Color de fondo negro
frame.BorderSizePixel = 0 -- Sin borde
frame.Parent = screenGui

-- Añadir un UICorner para bordes redondos
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 20) -- Radio de las esquinas
uiCorner.Parent = frame

-- Crear un TextLabel para el título dentro del Frame
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Mario Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true
titleLabel.Parent = frame

titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Crear botones
local button1 = Instance.new("TextButton")
button1.Size = UDim2.new(1, 0, 0, 50)
button1.Position = UDim2.new(0, 0, 0.25, 0)
button1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button1.Text = "Booster"
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.TextSize = 20
button1.Font = Enum.Font.SourceSans
button1.Parent = frame

local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(1, 0, 0, 50)
button2.Position = UDim2.new(0, 0, 0.5, 0)
button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button2.Text = "Spy Player"
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.TextSize = 20
button2.Font = Enum.Font.SourceSans
button2.Parent = frame

local button3 = Instance.new("TextButton")
button3.Size = UDim2.new(1, 0, 0, 50)
button3.Position = UDim2.new(0, 0, 0.75, 0)
button3.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button3.Text = "Spy Base"
button3.TextColor3 = Color3.fromRGB(255, 255, 255)
button3.TextSize = 20
button3.Font = Enum.Font.SourceSans
button3.Parent = frame

button1.TextXAlignment = Enum.TextXAlignment.Center
button1.TextYAlignment = Enum.TextYAlignment.Center

button2.TextXAlignment = Enum.TextXAlignment.Center
button2.TextYAlignment = Enum.TextYAlignment.Center

button3.TextXAlignment = Enum.TextXAlignment.Center
button3.TextYAlignment = Enum.TextYAlignment.Center

-- Añadir bordes redondos a botones
local uiCornerButton1 = Instance.new("UICorner")
uiCornerButton1.CornerRadius = UDim.new(0, 20)
uiCornerButton1.Parent = button1

local uiCornerButton2 = Instance.new("UICorner")
uiCornerButton2.CornerRadius = UDim.new(0, 20)
uiCornerButton2.Parent = button2

local uiCornerButton3 = Instance.new("UICorner")
uiCornerButton3.CornerRadius = UDim.new(0, 20)
uiCornerButton3.Parent = button3

-- Drag del frame
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Función para revelar jugadores
local function revealPlayers()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineTransparency = 0.5
            highlight.Adornee = player.Character
            highlight.Parent = game:GetService("CoreGui")

            local box = Instance.new("BoxHandleAdornment")
            box.Size = Vector3.new(5, 5, 5)
            box.AlwaysOnTop = true
            box.ZIndex = 1
            box.Adornee = player.Character
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Transparency = 0.5
            box.Parent = game:GetService("CoreGui")

            player.CharacterAdded:Connect(function(newCharacter)
                highlight.Adornee = newCharacter
                box.Adornee = newCharacter
            end)

            player.CharacterRemoving:Connect(function()
                highlight:Destroy()
                box:Destroy()
            end)
        end
    end
end

-- Botón Spy Player
local spyPlayerActive = false
button2.MouseButton1Click:Connect(function()
    spyPlayerActive = not spyPlayerActive
    if spyPlayerActive then
        revealPlayers()
        button2.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    else
        for _, obj in ipairs(game:GetService("CoreGui"):GetChildren()) do
            if obj:IsA("Highlight") or obj:IsA("BoxHandleAdornment") then
                obj:Destroy()
            end
        end
        button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- Botón Spy Base
local spyBaseActive = false
button3.MouseButton1Click:Connect(function()
    spyBaseActive = not spyBaseActive
    if spyBaseActive then
        button3.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    else
        button3.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- Botón Booster
local boosterActive = false
local originalSpeed
button1.MouseButton1Click:Connect(function()
    boosterActive = not boosterActive
    if boosterActive then
        button1.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        originalSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed * 10
    else
        button1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed
    end
end)

-- Detección de "Brainrot"
local function onBrainrotTouched(part, player)
    if player == game.Players.LocalPlayer and boosterActive then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed * 10
    end
end

for _, brainrot in ipairs(workspace:GetChildren()) do
    if brainrot.Name == "Brainrot" then
        brainrot.Touched:Connect(function(part)
            onBrainrotTouched(part, part.Parent)
        end)
    end
end

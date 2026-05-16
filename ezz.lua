local Btn1488 = createGrayButton("1488")
Btn1488.MouseButton1Click:Connect(function()
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
 
    local Tool = Instance.new("Tool")
    Tool.Name = "1488"
    Tool.RequiresHandle = true
    Tool.ToolTip = ""
 
    local Handle = Instance.new("Part")
    Handle.Name = "Handle"
    Handle.Size = Vector3.new(0.1, 0.1, 0.1)
    Handle.Transparency = 1
    Handle.CanCollide = false
    Handle.Anchored = false
    Handle.Parent = Tool
 
    local backpack = Player:WaitForChild("Backpack")
    local existingTool = backpack:FindFirstChild("1488")
    if existingTool then existingTool:Destroy() end
 
    Tool.Parent = backpack
 
    local anchoredPart = nil
    local originalAnchored = false
    local originalCFrame = nil
 
    function findNearestUnanchoredPart(position, radius)
        local closest = nil
        local minDist = radius
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj.Anchored and obj.CanCollide then
                local humanoidParent = obj.Parent:FindFirstChildOfClass("Humanoid")
                if not humanoidParent and obj.Parent ~= Player.Character then
                    local dist = (obj.Position - position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = obj
                    end
                end
            end
        end
        return closest
    end
 
    function freezePart(part)
        if not part then return end
        
        anchoredPart = part
        originalAnchored = part.Anchored
        originalCFrame = part.CFrame
        
        part.Anchored = true
    end
 
    function unfreezePart()
        if anchoredPart then
            anchoredPart.Anchored = originalAnchored
            anchoredPart = nil
            originalCFrame = nil
        end
    end
 
    Tool.Equipped:Connect(function()
        task.wait(0.05)
        
        local char = Player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        unfreezePart()
        
        local target = findNearestUnanchoredPart(root.Position, 10)
        if target then
            freezePart(target)
        end
    end)
 
    Tool.Unequipped:Connect(function()
        unfreezePart()
    end)
 
    Player.CharacterAdded:Connect(function()
        unfreezePart()
    end)
 
    print("Инструмент '1488' активирован.")
end)

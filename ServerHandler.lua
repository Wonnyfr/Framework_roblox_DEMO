local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerRemote = ReplicatedStorage.Remotes.Server

local Inputs = require(script.Input)
local Functions = require(script.Functions)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAppearanceLoaded:Connect(function(character)
		character:SetAttribute("Attacking", false)
	end)
end)

ServerRemote.OnServerInvoke = function(player, Action, Input, Params)
	if Action == "InputBegan" then
		print("Pressed")
		Inputs.InputTable[player][Input] = true
	elseif Action == "InputEnded" then
		print("Stopped")
		Inputs.InputTable[player][Input] = nil
	elseif Action == "Skill" then
		if player.Character:GetAttribute("Attacking") == false then
			local Move = Functions.FireMove(player, Params)
			return Move
		end 
	end
end

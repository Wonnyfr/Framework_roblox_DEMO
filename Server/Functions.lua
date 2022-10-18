local Functions = {
	["FireMove"] = function(player, ...)
		local Data, MoveName, Moveset = unpack(...)
		
		local Skill
		local Success, Fail = pcall(function()
			Skill = require(script.Parent.Moves[Moveset])[MoveName](player, Data)
		end)
		if not Success then warn(Fail) end
		return Skill
	end,
	
	["FireClientWithDistance"] = function(Args, ...)
		for i, P in pairs(game.Players:GetChildren()) do
			local CharModel = P.Character
			
			if (Args.Orgin - CharModel.HumanoidRootPart.Position).Magnitude <= Args.Distance then
				Args.Remote:FireClient(game.Players:GetPlayerFromCharacter(CharModel), ...)
			end
		end
	end,
}

return Functions

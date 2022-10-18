local Functions = require(script.Parent.Parent.Functions)

local Combat = {
	["M1"] = function(player, ...)
		local Data = (...)
		print("Reached Server")
		local character = player.Character
		
		Functions.FireClientWithDistance(
			{
				Orgin = character.HumanoidRootPart.Position,
				Distance = 125,
				Remote = game.ReplicatedStorage.Remotes.Effects},
				{"M1", {Params = nil},
			}
		)
	end,
}

return Combat

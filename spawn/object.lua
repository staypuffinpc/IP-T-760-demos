--PURPOSE: Basic template for creating objects
Object = {}

function Object:new()
	local newInstance = {}
	setmetatable(newInstance, self)
	self.__index = self
	
	return newInstance
end
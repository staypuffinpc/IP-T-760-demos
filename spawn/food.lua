--PURPOSE: create a food object, to be used externally
require ("object")

Food = Object:new()

function Food:init(kind, value)
	self.kind = kind or "Oreo"
	self.value = value or 1
	return self
end

function Food()
	print("This is a(n) "..self.kind.." cookie.")
end
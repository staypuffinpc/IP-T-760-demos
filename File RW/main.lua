-- main.lua
-- PURPOSE: Test for pattern matching (so that I can eventually replace what occurs between two HTML tags)
-----------------------------------------------------------------------------------------
_H = display.contentHeight
_W = display.contentWidth
 

 --Check if a file exists in a target directory.  If not, copy it from a base directory to the target Directory
local function checkForFile (file) 
	local checkPath = system.pathForFile(file,system.DocumentsDirectory)
	local isFileThere = io.open(checkPath,"r")
	if isFileThere == nil then
	--file doesn't exist, so copy file from base directory to target Directory)
		local existingPath = system.pathForFile(file,system.ResourceDirectory)
		print (existingPath)
		if existingPath == nil then
			print ("ERROR: There is no "..file.." in the Resource Directory")
		else -- file exists, so copy it from the Resource Directory to the Documents directory
			local readFile = io.open(existingPath,"r")
			fileContents = readFile:read("*a")
			io.close(readFile)
			readFile = nil
			path = nil
			--now copy to new directory
			local newPath = system.pathForFile(file,system.DocumentsDirectory)
			local newFile = io.open(newPath,"w")
			newFile:write(fileContents)
			io.close(newFile)
			newFile = nil
			path2 = nil
			print (file.." copied successfully")
		end
	else --file already exists
		print(file.." already exists in the Documents Directory")
	end
end
 
checkForFile("template.txt")
checkForFile("content.txt")

--read in the text from a file
local path1 = system.pathForFile("template.txt", system.DocumentsDirectory)
local file = io.open(path1,"r")
local oldText = file:read("*a")
io.close(file)
 
--now get the data you'll use to replace this text
local path2 = system.pathForFile("content.txt",system.DocumentsDirectory)
local file2 = io.open(path2,"r")
local newText = file2:read("*a")
io.close(file2)
file2 = nil
 
--now try replacing everything between those two indexes
local changedText = string.gsub(oldText, "<body>([%c%w%s%p%d]+)</body>", "<body>"..newText.."</body>")
--now write the data to a new file 
local path3 = system.pathForFile("newFile.html",system.DocumentsDirectory)
file = io.open(path3,"w")
file:write(changedText)
io.close(file)
file = nil
 
--now let's load this file into a web popup (can't use native.webView b/c it only works on iOS devices currently, but look to do it when they come to Android)
local options = {hasBackground = false, baseUrl = system.DocumentsDirectory}
local text = native.showWebPopup(50, 50, _W*.8,_H*.9,"newFile.html", options)
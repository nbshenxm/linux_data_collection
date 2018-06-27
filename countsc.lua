-- Chisel description
description = "counts how many times the specified system call has been called"
short_description = "syscall count"
category = "misc"

-- Chisel argument list
args = {}

-- Initialization callback
function on_init()
	-- Request the fileds that we need
	ftype = chisel.request_field("evt.type")
	fdir = chisel.request_field("evt.dir")
	
	return true
end

-- Setup socket connection
local socket = require("socket")
host = "127.0.1.1"
port = 8080
print("Attempting connection to host '" ..host.. "' and port " ..port.. "...")
c = assert(socket.connect(host, port))
print("Connected!")

count = 0

-- Event parsing callback
function on_event()
	count = count + 1
	print(count)
	assert(c:send(evt.field(ftype) .. "\n"))
	return true
end


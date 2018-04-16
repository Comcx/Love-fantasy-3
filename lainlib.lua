
local lain = {}



--print table(dict)--
lain.printDict = function(dict)

	for key, value in pairs(dict) do

		print(key..":\t"..value)

	end

end


lain.iter_array = function(t_array)

	local next = function(t_array, i)

		i = i + 1
		local v = t_array[i]
		if v then
			return i, v
		end
	end

	return next, t_array, 0
end


lain.os = {}

lain.os.call = function(order)

	local t = io.popen('lua -h')
	local a = t:read("*all")

	return a
end


















return lain

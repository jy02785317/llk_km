Node = {
	name = 'node',
	parent = nil,
	child = nil,
	childNum = 0,
	visible = true,
	x = 0,
	y = 0,
	img = 0,
	scaleX = 1,
	scaleY = 1,
	alpha = 0,
	color = 0x0,
	blendMode = 0,
}
local meta = {
	__index = Node
}
function Node:new(o)
	o = o or {}
	setmetatable(o, meta)
	return o
end
function Node:addChild(pos, n)
	log('addChild', pos, n)
	if pos == nil then
		return
	elseif n == nil then
		n = pos
		pos = nil
	end
	log('self name', self.name, 'child name', n.name)
	if self.child == nil then
		self.child = {}
	end
	if pos == nil then
		table.insert(self.child, n)
	else
		table.insert(self.child, pos, n)
	end
	n.parent = self
	self.childNum = #self.child
	log('parent', self, 'child', n, 'count', self.childNum)
end
function Node:getChild(cond)
	local s = type(cond)
	local idx = 0
	if s == 'string' then
		for i, v in ipairs(self.child) do
			log(cond, s, v)
			if v.name == cond then
				idx = i
				break
			end
		end
	elseif s == 'table' then
		for i, v in ipairs(self.child) do
			if v == cond then
				idx = i
				break
			end
		end
	elseif s == 'number' then
		idx = cond
	end
	if idx > 0 and idx <= self.childNum then
		return self.child[idx], idx
	end
	return nil, idx
end
function Node:removeChild(cond)
	local n, idx = self:getChild(cond)
	if idx > 0 then
		n.parent = nil
		table.remove(self.child, idx)
		self.childNum = #self.child
	end
end
function Node:removeSelf()
	if self.parent then
		self.parent:removeChild(self)
	end
end
function Node:clone()
	local o = self.new()
	if n == nil then
		return o
	end
	for k, v in piars(self) do
		local s = type(v)
		if s == 'number' or s == 'string' then
			o[k] = v
		end
	end
	for i = 1, self.childNum do
		o.insert(self.child[i]:clone())
	end
	return o
end
function Node:redraw()
	if not self.visible then
		return
	end
	-- log('redraw', self.name)
	local parent = self.parent
	if self.parent then
		self._x = parent._x + self.x
		self._y = parent._y + self.y
	else
		self._x = self.x
		self._y = self.y
	end
	if self.img > 0 then
		lib.PicLoadCache(4, self.img * 2, self._x, self._y)
	end
	for i = 1, self.childNum do
		self.child[i]:redraw()
	end
end
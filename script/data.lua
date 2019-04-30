KM = {
    role = {},
}
trim = function(str, kind)
    kind = kind or 0
    -- 0 both, 1 st only, 2 ed only
    local len = #str
    local st = 1
    local ed = len
    if kind ~= 2 then
        st = string.find(str, '%S')
    end
    if kind ~= 1 then
        ed = string.find(str, '%s*$') - 1
    end
    -- print(str, st, ed)
    if st > 1 or ed < len then
        return string.sub(str, st, ed)
    else
        return str
    end
end
loadTXT = function(t, file)
    local typedef = {}
    local fp = io.open(file, 'r')
    for w in string.gmatch(fp:read(), '[^\t]*[\t$]') do
        local kind, name
        local str = trim(w)
        if #str > 0 then
            local idx = string.find(str, '_')
            if idx then
                kind = string.sub(str, 1, idx - 1)
                name = string.sub(str, idx + 1)
                if #kind == 0 then
                    kind = 'auto'
                end
                if #name == 0 then
                    name = nil
                end
            else
                kind = 'auto'
                name = str
            end
        end
        table.insert(typedef, {
            kind = kind,
            name = name,
        })
    end
    while true do
        local line = fp:read()
        if line == nil then
            break
        end
        local idx = 1
        local maxIdx = #typedef
        local doc = {}
        for w in string.gmatch(line, '[^\t]*[\t$]') do
            if idx > maxIdx then
                break
            end
            local str = trim(w)
            local kind = typedef[idx].kind
            local name = typedef[idx].name
            if name ~= nil then
                local v
                if kind == 'int' then
                    v = math.floor(tonumber(str) or 0)
                elseif kind == 'float' then
                    v = tonumber(str) or 0
                elseif kind == 'string' then
                    v = str
                else
                    v = tonumber(str) or str
                end
                doc[name] = v
            end
            idx = idx + 1
        end
        local docId = doc['编号'] or doc.id or (#t + 1)
        -- print(docId, doc)
        t[docId] = doc
    end
    -- string.gsub(fp:read('l'), )
end

loadTXT(KM.role, '../data/role.txt')
print('-->')
for k, v in pairs(KM.role) do
    print(k, v)
    -- for kk, vv in pairs(v) do
    --     print(kk, vv)
    -- end
end
print('<--')
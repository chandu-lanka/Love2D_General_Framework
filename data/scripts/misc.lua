
function elementIndex(table,element) -- returns an id of an element in a table, if its not in the table, returnes nil
    for id,E in pairs(table) do
        if E == element then return id end
    end

    return nil
end

function idInTable(table,id) return table[id] ~= nil end

-- Color 0-255 range functions (i just like it that way XD)

function clear(r,g,b,a) -- Clear but it uses 0-255
    a = a or 255
    local convert = 0.003921
    love.graphics.clear(r * convert, g * convert, b * convert, a * convert)
end

function setColor(r,g,b,a) -- setColor but it uses 0-255
    a = a or 255
    local convert = 0.003921
    love.graphics.setColor(r * convert, g * convert, b * convert, a * convert)
end
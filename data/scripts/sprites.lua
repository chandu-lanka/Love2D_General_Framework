
SPRSCL = 3

-- New spritesheet

function loadSpritesheet(filename,w,h)
    local sheet = love.graphics.newImage(filename)
    local x = sheet:getWidth()/w; local y = sheet:getHeight()/h

    local images = {}

    for X=0,0,x do for Y=0,0,y do

    end end
end

function drawSprite(tex,x,y,sx,sy,r)
    local sx = sx or SPRSCL; local sy = sy or SPRSCL; local r = r or 0
    love.graphics.draw(tex,x,y,r,sx,sy,tex:getWidth()*0.5,tex:getHeight()*0.5)
end
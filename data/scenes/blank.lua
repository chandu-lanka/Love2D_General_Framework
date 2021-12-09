
function blankReload()
    postPro = {"GRAYSCALE"}
end

function blankDie()
end

function blank()
    -- Reset
    sceneAt = "blank"
    
    setColor(255, 255, 255)
    clear(255, 20, 255)
    setColor(0,0,0)
    love.graphics.circle("fill",xM,yM,20)
    SHADERS.GRAYSCALE:send("intensity",xM/800)

    -- Return scene
    return sceneAt
end
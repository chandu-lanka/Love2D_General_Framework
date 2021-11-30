
function blankReload()
    postPro = SHADERS.LIGHT
    SHADERS.LIGHT:send("xRatio",WS[1]/WS[2])
    SHADERS.LIGHT:send("screen", {800,600})
end

function blankDie()
end

function blank()
    -- Reset
    sceneAt = "blank"
    
    setColor(255, 255, 255)
    clear(100, 100, 100)

    setColor(255,0,0)
    love.graphics.circle("fill",300,300,64)

    shine(100,100,{0,0,1},48)
    shine(100,100,{1,0,0},48)

    processLights()
    -- Return scene
    return sceneAt
end
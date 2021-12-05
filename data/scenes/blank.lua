
function blankReload()
end

function blankDie()
end

function blank()
    -- Reset
    sceneAt = "blank"
    
    setColor(255, 255, 255)
    clear(100, 100, 100)

    -- Return scene
    return sceneAt
end
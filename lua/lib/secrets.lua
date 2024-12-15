local op = require("op.api")

return {
    -- Get a secret from 1password CLI (op)
    get = function(url)
        local stdout, stderr = op.read({ url })
        if #stderr > 0 then
            Snacks.notify.error(stderr)
        else
            return stdout[0]
        end
    end,
}

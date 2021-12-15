require "extensionhooks"

function post()
    if session:isLogged() then
        http:redirect("/")
        return
    end

    local account = db:singleQuery("SELECT name, secret, email FROM accounts WHERE name = ? AND password = ?", http.postValues["account-name"], crypto:sha1(http.postValues.password))

    if account == nil then
        session:setFlash("validationError", "Wrong account name or password")
        http:redirect("/subtopic/login")
        return
    end

    if account.secret ~= nil then
        if not validator:validQRToken(http.postValues.token, account.secret) then
            session:setFlash("validationError", "Invalid two-factor token. Please try again")
            http:redirect()
            return
        end
    end

    session:set("logged", true)
    session:set("loggedAccount", account.name)
    session:set("admin", session:isAdmin())

    -- Extension hook
    local status = {continue = true}
    executeHook("onLogin", session:loggedAccount(), status)
    -- Allow extensions to take over
    if not status.continue then
        return
    end

    http:redirect("/subtopic/account/dashboard")
end
function get()
    -- Block access for anyone who is not admin
    if not session:isLogged() or not session:isAdmin() then
        http:redirect("/")
        return
    end

    if not app.Plugin.Enabled then
        http:redirect("/")
        return
    end

    local page = 0

    if http.getValues.page ~= nil then
        page = math.floor(tonumber(http.getValues.page) + 0.5)
    end

    if page < 0 then
        http:redirect("/subtopic/index")
        return
    end

    local data = {}

    data.origin = app.Plugin.Origin

    try(
        function()
            data.list = json:unmarshal(http:get(data.origin .. "/rest/list?p=" .. page))
        end,
        function()
            data.error = "Unable to retrieve extension list"
        end
    )

    http:render("extensions.html", data)
end
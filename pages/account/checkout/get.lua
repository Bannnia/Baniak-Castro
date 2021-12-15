require "paginator"

function get()
    if not app.Shop.Enabled then
        http:redirect("/")
        return
    end

    if not session:isLogged() then
        http:redirect("/subtopic/login")
        return
    end

    local page = 0

    if http.getValues.page ~= nil then
        page = math.floor(tonumber(http.getValues.page) + 0.5)
    end

    if page < 0 then
        http:redirect("/subtopic/account/checkout")
        return
    end

    local account = session:loggedAccount()
    
    local count = db:singleQuery([[
        SELECT COUNT(*) as total 
        FROM castro_shop_checkout a, players b, accounts c 
        WHERE a.player = b.name AND b.account_id = c.id AND c.id = ?
        ]], account.ID)

    local pg = paginator(page, 15, tonumber(count.total))
    local data = {}

    data.list = db:query([[
        SELECT a.name, b.given, b.amount 
        FROM castro_shop_offers a, castro_shop_checkout b, accounts c, players d 
        WHERE a.id = b.offer AND b.player = d.name AND d.account_id = c.id AND c.id = ?
        ORDER BY b.id 
        DESC LIMIT ?, ?
        ]], 
        account.ID, 
        pg.offset, 
        pg.limit
    )
    data.paginator = pg

    http:render("checkouthistory.html", data)
end
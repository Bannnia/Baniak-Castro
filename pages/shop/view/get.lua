require "bbcode"

function get()
    if not app.Shop.Enabled then
        http:redirect("/")
        return
    end

    local data = {}

    data.categories = db:query("SELECT id, name, description FROM castro_shop_categories ORDER BY id")

    if data.categories == nil then 
        data.error = 'There are no shop categories on the shop'
        http:render("shopview.html", data)
        return
    end

    for _, category in ipairs(data.categories) do
        category.offers = db:query("SELECT id, image, name, description, price FROM castro_shop_offers WHERE category_id = ?", category.id)
    end

    data.success = session:getFlash("success")
    data.error = session:getFlash("error")

    if not session:isLogged() then
        http:render("shopview.html", data)
        return
    end

    data.players = db:query("SELECT name FROM players WHERE account_id = ?", session:loggedAccount().ID)

    local cart = session:get("shop-cart")

    if cart ~= nil then

        data.cart = {}

        for name, count in pairs(cart) do
            data.cart[name] = {}
            data.cart[name].offer = db:singleQuery("SELECT name, price FROM castro_shop_offers WHERE name = ?", name)
            data.cart[name].count = count
        end
    end

    http:render("shopview.html", data)
end
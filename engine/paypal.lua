function paypalPackage(name, price, points)
    local pkg = {}

    pkg.name = name
    pkg.price = price
    pkg.points = points
    pkg.currency = app.PayPal.Currency

    return pkg
end

-- PayPal package list
paypalList = {}

-- Package name, package price, package given points
paypalList["Test Package"] = paypalPackage("Test Package", 12, 20)
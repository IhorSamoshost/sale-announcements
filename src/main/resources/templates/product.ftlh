<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sales Announcements</title>
</head>
<body>
<h1>${product.title}</h1>
<hr>
<h3>Detailed product info:</h3>
<#list images as image>
    <img src="/images/${image.id}" height="68px" alt=""/><br/>
</#list>
<p>Product description: ${product.description}</p>
<p>Price: <b>$${product.price}</b></p>
<p>City: ${product.city}</p>
<p>Seller: <a href="/users/${seller.id}">${seller.name}</a></p>
<p>Phone number: ${seller.phoneNumber}</p>
<hr>
<form action="delete/${product.id}" method="post">
    <input type="submit" value="Delete product">
    <input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
</body>
</html>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sales Announcements</title>
</head>
<body>
<h1>Detailed user information:</h1>
<h2>Username: ${user.name}</h2>
<hr>
Email: ${user.email}<br/>
Phone number: ${user.phoneNumber}
<hr>
<h1>User's goods for sale:</h1>
<#list user.products as product>
    <div>
        <b>${product.title}</b> $${product.price} | <a href="/products/${product.id}">Details</a><br/>
    </div>
<#else><h3>No products</h3>
</#list>
</body>
</html>
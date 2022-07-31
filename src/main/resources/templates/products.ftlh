<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sales Announcements</title>
</head>
<body>
<h1>Goods for sale</h1>
<hr>
<#if user.email??>
    <h3>User name: <b><i>${user.name}</i></b></h3>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit">Logout</button>
    </form>
<#else>
    <a href="/login">Log in</a>
</#if>
<hr>
<form action="/products" method="get">
    <p>Search by product title: <input type="text" name="title"/></p>
    <input type="submit" value="Search products">
</form>
<h2>Products information:</h2>
<#list products as product>
    <div>
        <b>${product.title}</b> $${product.price} | <a href="products/${product.id}">Details</a><br/>
    </div>
<#else><h3>No products</h3>
</#list>
<#if user.email??>
    <hr/>
    <h3>Create new product</h3>
    <form action="/products" method="post" enctype="multipart/form-data">
        <p>Product title: <input type="text" name="title"/></p>
        <p>Product description: <textarea rows="2" name="description"></textarea></p>
        <p>Product price: <input type="number" step="0.01" name="price"/></p>
        <p>Announcement from city: <input type="text" name="city"/></p>
        <p>Photo 1: <input type="file" name="file1" accept="image/*"/></p>
        <p>Photo 2: <input type="file" name="file2" accept="image/*"/></p>
        <p>Photo 3: <input type="file" name="file3" accept="image/*"/></p>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Save product">
    </form>
</#if>
</body>
</html>

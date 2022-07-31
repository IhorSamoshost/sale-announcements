<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sales Announcements</title>
</head>
<body>
<h1>Registration form</h1>
<hr>
<form action="/registration" method="post">
    Username: <input type="text" name="name"><br/><br/>
    Email: <input type="email" name="email"><br/><br/>
    Phone number: <input type="text" name="phoneNumber"><br/><br/>
    Password: <input type="password" name="password"><br/><br/>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <button type="submit">Sign up</button>
</form>
<#if errorMessage??>
    <br/><br/>
    <h2 style="color: red">${errorMessage}</h2>
</#if>
</body>
</html>

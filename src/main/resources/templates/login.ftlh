<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sales Announcements</title>
</head>
<body>
<h1>Login form</h1>
<hr>
<form action="/login" method="post">
    Email: <input type="email" name="username"><br/><br/>
    Password: <input type="password" name="password"><br/><br/>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <button type="submit">Log in</button>
</form>
<hr>
<h2>No account? <a href="/registration">Sign up!</a></h2>
</body>
</html>

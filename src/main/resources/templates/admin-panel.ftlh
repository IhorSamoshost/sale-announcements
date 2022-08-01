<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sales Announcements</title>
</head>
<body>
<h1>Administration panel</h1>
<table border="1">
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Phone number</th>
        <th>Roles</th>
        <th>Active status</th>
        <th>Change active status</th>
        <th>Edit user</th>
        <th>Details</th>
    </tr>
    <#list users as user>
        <tr>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.phoneNumber}</td>
            <td><#list user.roles as role>${role}<#sep>, </#list></td>
            <td><#if user.active> true <#else> false </#if></td>
            <td>
                <form action="/admin/users/ban/${user.id}" method="post">
                    <input type="submit" value="Ban/unban">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                </form>
            </td>
            <td><a href="/admin/users/edit/${user.id}">Edit</a></td>
            <td><a href="/users/${user.id}">Details...</a></td>
        </tr>
    <#else> There no users
    </#list>
</table>
</body>
</html>

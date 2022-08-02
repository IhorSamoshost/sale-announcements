<#import "blocks/layout.ftlh" as l>
<@l.template user>
    `<h1 style="text-align: center">Administration panel</h1>
    <hr>
    <table class="table table-hover table-bordered table-dark">
        <tr class="text-center">
            <th>Name</th>
            <th>Email</th>
            <th>Phone number</th>
            <th>Roles</th>
            <th>Active status</th>
            <th>Change active status</th>
            <th>Edit user's roles</th>
            <th>Details</th>
        </tr>
        <#list users as user>
            <tr>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.phoneNumber}</td>
                <td><#list user.roles as role>${role}<#sep><br> </#list></td>
                <td><#if user.active>true<#else>false</#if></td>
                <td>
                    <form action="/admin/users/ban/${user.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" class="btn btn-light" value="Ban/unban">
                    </form>
                </td>
                <td><a href="/admin/users/edit/${user.id}">Edit</a></td>
                <td><a href="/users/${user.id}">Details...</a></td>
            </tr>
        <#else>
            <h3>There no users</h3>
        </#list>
    </table>
</@l.template>

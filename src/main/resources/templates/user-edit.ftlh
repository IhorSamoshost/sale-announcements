<#import "blocks/layout.ftlh" as l>
<@l.template currentUser>
    <h1 style="text-align: center">Editing user ${user.name} roles</h1>
    <hr>
    <form action="/admin/users/edit" method="post">
        <#list roles as role>
            <div>
                <label><input type="checkbox"
                              name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
            </div>
        </#list>
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit" class="btn btn-dark">Save</button>
    </form>
</@l.template>

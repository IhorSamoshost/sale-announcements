<#import "blocks/layout.ftlh" as l>
<#import "blocks/product-cards.ftlh" as pc>
<@l.template currentUser>
    <h1 style="text-align: center">Detailed user information</h1>
    <hr>
    <div style="text-align: center">
        <img src="/static/images/avatar.png"
             style="border:2px solid black; border-radius: 20px" height="120" alt="">
        <br>
        <br>
        <h2>${user.name}</h2>
        <br>
        Phone number: <b>${user.phoneNumber}</b>
    </div>
    <br>
    <hr>
    <h1 style="text-align: center">User's stuff for sale</h1>
    <br>
    <@pc.cards products></@pc.cards>
</@l.template>

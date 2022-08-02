<#macro delete product>
    <div class="card-top">
        <form action="/products/delete/${product.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-danger">
                Delete
            </button>
        </form>
    </div>
</#macro>

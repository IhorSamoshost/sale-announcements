<#macro cards products>
    <#import "delete-button.ftlh" as del>
    <div class="card-columns">
        <#list products as product>
            <a href="/products/${product.id}" class="product-link">
                <div class="card text-center text-white bg-dark my-3 product">
                    <#if product.previewImageId??>
                        <img src="/images/${product.previewImageId}" class="card-img-top card-img" alt="">
                    <#else><div style="height: 150px" class="py-auto">No photos</div>
                    </#if>
                    <div class="card-body" style="max-height: 156px">
                        <h5 class="card-title">${product.title}</h5>
                        <div class="card-text">
                            <p>$ ${product.price}</p>
                            <p>${product.city}</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <#if springMacroRequestContext.requestUri?contains("/my-products")>
                            <@del.delete product></@del.delete>
                        </#if>
                    </div>
                </div>
            </a>
        <#else>
            <h1 style="text-align: center">No products</h1>
        </#list>
    </div>
</#macro>

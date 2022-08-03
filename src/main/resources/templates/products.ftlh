<#import "blocks/layout.ftlh" as l>
<#import "blocks/product-cards.ftlh" as pc>
<@l.template user>
    <h2 style="text-align: center">Search for products:</h2>
    <hr>
    <form method="get" action="/products">
        <div class="form-row">
            <div class="form-group col-md-2">
                <label for="searchCity">City</label>
                <select id="searchCity" name="searchCity" class="form-control">
                    <option value="">Everywhere</option>
                    <#list cities as city>
                        <option <#if searchedCity?? && searchedCity == city>selected</#if>
                                value=${city}>${city}</option>
                    </#list>
                </select>
            </div>
            <div class="form-group col-md-10">
                <label for="searchWord">Search products by title:</label>
                <input type="text" name="searchWord" <#if searchedWord??>value="${searchedWord}"</#if>
                       class="form-control"
                       id="searchWord">
            </div>
            <button style="width: 100%" type="submit" class="btn btn-dark">Search</button>
        </div>
    </form>
    <h2 style="text-align: center">Stuff for sale:</h2>
    <hr>
    <@pc.cards products></@pc.cards>
</@l.template>

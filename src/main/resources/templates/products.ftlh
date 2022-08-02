<#import "blocks/layout.ftlh" as l>
<#import "blocks/product-cards.ftlh" as pc>
<@l.template user>
    <h2 style="text-align: center">Search for products:</h2><hr>
    <form method="get" action="/products">
        <div class="form-row">
            <div class="form-group col-md-2">
                <label for="searchCity">City</label>
                <select id="searchCity" class="form-control">
                    <option value="">Everywhere</option>
                    <option value="London">London</option>
                    <option value="New York">New York</option>
                    <option value="Dnipro">Dnipro</option>
                    <option value="Lviv">Lviv</option>
                </select>
            </div>
            <div class="form-group col-md-10">
                <label for="searchWord">Search products by title:</label>
                <input type="text" name="searchWord" <#if searchWord??>value="${searchWord}"</#if> class="form-control"
                       id="searchWord">
            </div>
            <button style="width: 100%" type="submit" class="btn btn-dark">Search</button>
        </div>
    </form>
    <h2 style="text-align: center">Stuff for sale:</h2><hr>
    <@pc.cards products></@pc.cards>
</@l.template>

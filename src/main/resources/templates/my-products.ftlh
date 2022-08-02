<#import "blocks/layout.ftlh" as l>
<#import "blocks/product-cards.ftlh" as pc>
<@l.template user>
    <h2 style="text-align: center">My stuff for sale</h2>
    <hr>
    <a class="btn btn-dark mt-3 mb-3" style="text-align: center; width: 100%"
       data-toggle="collapse" href="#collapsableDiv" role="button"
       aria-expanded="true" aria-controls="collapseExample">
        Add new product
    </a>
    <div class="collapse mb-3" id="collapsableDiv" style="">
        <form action="/products" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Product title</label>
                <input type="text" required class="form-control" id="productName" name="title">
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <div class="input-group mb-3">
                    <div class="input-group-append">
                        <span class="input-group-text">$ </span>
                    </div>
                    <input type="number" step="0.01" required class="form-control" id="price" name="price">
                </div>
            </div>
            <div class="form-group">
                <label for="searchCity">City</label>
                <select id="searchCity" name="city" class="form-control">
                    <option value="">Everywhere</option>
                    <option value="London">London</option>
                    <option value="New York">New York</option>
                    <option value="Dnipro">Dnipro</option>
                    <option value="Lviv">Lviv</option>
                </select>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea required class="form-control" id="description" name="description"></textarea>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input required type="file" name="file1" id="file1">
                    <label class="custom-file-label" for="file1">Photo 1</label>
                </div>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file2" id="file2">
                    <label class="custom-file-label" for="file2">Photo 2</label>
                </div>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file3" id="file3">
                    <label class="custom-file-label" for="file3">Photo 3</label>
                </div>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" style="width: 100%" class="btn btn-dark">Save</button>
        </form>
    </div>
    <@pc.cards products></@pc.cards>
</@l.template>

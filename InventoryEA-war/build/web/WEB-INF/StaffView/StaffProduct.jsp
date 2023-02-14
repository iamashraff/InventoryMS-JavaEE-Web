<%@page import="model.Product"%>
<%@page import="dao.CategoryDAOImpl"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="model.Category"%>
<%@page import="dao.ProductDAOImpl"%>
<%@page import="dao.ProductDAO"%>
<jsp:include page="staffincludes/upperpart.jsp" />
<%@ page import="javax.ejb.*" %>
<jsp:include page="staffincludes/cardbg.jsp" />

<%
    if (request.getParameter("action") != null) {
        if (request.getParameter("action").equals("restock")) {

%>
<jsp:include page="staffincludes/modalRestockProduct.jsp" />  
<%              }//END IF

    }//END IF

    if (request.getParameter("code") != null) {

        if (request.getParameter("code").equals("restockSuccess")) {
%>
<jsp:include page="staffincludes/modalRestockSuccess.jsp" />
<%
        }

    }


%>


<!-- Section: Content -->
<section class="animate__animated animate__fadeIn">

    <h2>Product</h2>
    <hr>


    <%    ProductDAO pdao = new ProductDAOImpl();
        Category category = new Category();
        CategoryDAO cdao = new CategoryDAOImpl();

        int noStock = 0;
        int lowStock = 0;
        int inStock = 0;
        for (Product product : pdao.selectAllProduct()) {
            int prodQty = Integer.parseInt(product.getProdQty());

            if (prodQty > 0 && prodQty < 30) {
                lowStock += 1;
            }

            if (prodQty == 0) {
                noStock += 1;
            }

            if (prodQty >= 30) {
                inStock += 1;
            }

        }//END FOR

    %>

    <div class="row text-light">
        <div class="col">
            <div class="card border text-center bg-c-green">
                <div class="card-body">

                    <div class="d-flex justify-content-between px-md-1">
                        <div class="align-self-center">
                            <i class="fas fa-boxes fa-3x"></i>
                        </div>
                        <div class="text-end">
                            <label style="font-size:25px;"><% out.print(inStock);%></label> 
                            <p class="mb-0">In Stock</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="col">
            <div class="card border text-center bg-c-yellow">
                <div class="card-body">

                    <div class="d-flex justify-content-between px-md-1">
                        <div class="align-self-center">
                            <i class="fas fa-box fa-3x"></i>
                        </div>
                        <div class="text-end">
                            <label style="font-size:25px;"><% out.print(lowStock);%></label> 
                            <p class="mb-0">Low Stock</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="col">
            <div class="card border text-center bg-c-pink">
                <div class="card-body">

                    <div class="d-flex justify-content-between px-md-1">
                        <div class="align-self-center">
                            <i class="fas fa-box-open fa-3x"></i>
                        </div>
                        <div class="text-end">
                            <label style="font-size:25px;" class=""><% out.print(noStock);%></label> 
                            <p class="mb-0">No Stock</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>                   

    </div>

                            <br>

    <input type="search" placeholder="Search Product..." class="form-control search-input border border-dark" data-table="table-list"/>
    <br>
                            
    <div class="table-responsive">
        <table class="table table-sm table-striped table-hover text-center table-list" style="font-size:15px;">
            <thead class="text-light bg-info">
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price/unit</th>
                    <th>Category</th>
                    <th>Action</th>
                </tr>
            </thead>
            <%
                for (Product product : pdao.selectAllProduct()) {
                    int prodId = Integer.parseInt(product.getProdCategory());
                    category = cdao.selectCategory(prodId);

                    double price = Double.parseDouble(product.getProdPrice());
                    out.println("<tr>");
                    out.println("<td>" + product.getProdId() + "</td>");
                    out.println("<td>" + product.getProdName() + "</td>");
                    out.println("<td>" + product.getProdQty() + "</td>");
                    out.println("<td>RM" + String.format("%.2f", price) + "/" + product.getProdUnit() + "</td>");
                    out.println("<td>" + category.getCatName() + "</td>");
                    out.println("<td>"); %>
            <a class="btn text-white btn-sm btn-primary btn-floating" href="StaffProduct?id=<% out.println(product.getProdId());%>&action=restock" role="button">
                <i class="fas fa-plus"></i></a>


            <%
                    out.println("</td>");
                    out.println("</tr>");
                }


            %>


        </table>
    </div>



</section>
            <br><br><br><br><br><br>
<!-- Section: Content -->    
<jsp:include page="staffincludes/lowerpart.jsp" />  
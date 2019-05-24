<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All</title>


    <script type="text/javascript" src="${pageContext.request.contextPath}/static/three.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/dat.gui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/OrbitControls.js"></script>


    <style>
        .margin {
            margin-top: 5%;
        }


        table tbody tr td:first-child::before {
            min-width: 1em;
            margin-right: 0.5em;
        }

        .text{
            margin-left: 50px;
            font-size: 14pt;
            line-height: 40px;
            font-family: "Fira Code Retina", sans-serif;
            border-color: black;
            background-color: rgba(0, 0,0, 0.2);
            border-radius: 50px;
            padding: 30px;
            height: 550px;

        }




    </style>
</head>
<jsp:include page="/header_nlogout.jsp"/>
<body>

<div class="container">
    <form method="post" action="${pageContext.request.contextPath}/app/graphic">
        <div class="row margin">
            <h3>Please, write real numbers!</h3>
            <h3>Enter data to build your own isotropic surface</h3>
            <div style="margin-left: 30px;" class="container">
                <table style="width: 100%;" class="table table-hover">
                    <thead>
                    <tr>
                        <th>Real part</th>
                        <th>Imaginary part</th>
                    </tr>
                    </thead>
                    <tbody>

                    <tr>
                        <td>
                            <label for="a0"></label><input name="a0" id="a0" type="text" required value="2">
                        </td>
                        <td>
                            <label for="a0im"></label><input name="a0im" id="a0im" type="text" required value="2">
                        </td>

                    </tr>
                    <tr>

                        <td>
                            <label for="a1"></label><input name="a1" id="a1" type="text" required value="2">
                        </td>
                        <td>
                            <label for="a1im"></label><input name="a1im" id="a1im" type="text" required value="2">
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="a2"></label><input name="a2" id="a2" type="text" required value="2">
                        </td>
                        <td>
                            <label for="a2im"></label><input name="a2im" id="a2im" type="text" required value="2">
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="a3"></label><input name="a3" id="a3" type="text" required value="2">
                        </td>
                        <td>
                            <label for="a3im"></label><input name="a3im" id="a3im" type="text" required value="2">
                        </td>
                    </tr>
                    <tr>
                        <td>k</td>
                        <td><label for="k"></label><input name="k" id="k" type="text" value="2" required></td>
                    </tr>
                    <tr>
                        <td><input type="submit" class=" btn btn-primary btn-submit" name="ok" id="surface" value="Create your surface"></td>

                        <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal"> I need help</button></td>
                    </tr>
                    </tbody>

                </table>
                <td><input type="submit" class=" btn btn-primary btn-submit" name="ok"  value="Create e"></td>
                <%--<div class="text">
                    </div>--%>
            </div>

        </div>
    </form>
    </form>


    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Useful information</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    You enter data in form a + b where for the complex number a + bi, a is called the real part, and b is called the imaginary part.
                    Then we use Bezier curves to build an isotropic surfaces but instead of an usual conformal replacement we use quasiconformal to get a minimal surface.
                    <ol>
                        <li style="line-height: 40px">You need to enter real numbers</li>
                        <li style="line-height: 40px">When you fill up all text fields wait a minute and the window with you surface will arrive</li>
                        <li style="line-height: 40px">Rotate     : Left click and drag mouse</li>
                        <li style="line-height: 40px">Scale      : Roll mouse wheel</li>
                        <li style="line-height: 40px">Z Shift    : Right click and drag mouse</li>
                        <li style="line-height: 40px">Animate    : Double left click</li>
                        <li style="line-height: 40px">Screenshot : Press 's'</li>

                    </ol>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-transition.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-alert.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-modal.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-dropdown.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-scrollspy.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-tab.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-tooltip.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-popover.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-button.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-collapse.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-carousel.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap-typeahead.js"></script>

</body>
</html>
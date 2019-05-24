<%--
  Created by IntelliJ IDEA.
  User: dasha
  Date: 2019-04-09
  Time: 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Your Repairs</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->

    <style type="text/css">

        /* Carousel base class */
        .carousel {
            margin-bottom: 60px;
        }

        .carousel .container {
            position: absolute;
            right: 0;
            bottom: 0;
            left: 0;
            align-content: center;
        }

        .carousel-control {
            background-color: transparent;
            border: 0;
            font-size: 120px;
            margin-top: 0;
            text-shadow: 0 1px 1px rgba(0,0,0,.4);
        }

        .carousel .item {
            height: 500px;
        }
        .carousel img {
            min-width: 100%;
            height: 110%;
        }

        .carousel-caption {
            background-color: transparent;
            position: static;
            max-width: 550px;
            padding: 0 20px;
            margin-bottom: 30px;
        }
        .carousel-caption h1,
        .carousel-caption .lead {
            margin: 0;
            line-height: 1.25;
            color: #000;
            text-shadow: 0 1px 1px rgba(0,0,0,.4);
        }
        .carousel-caption .btn {
            margin-top: 10px;
        }

    </style>

    <!-- Fav and touch icons -->

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/ico/favicon.png">
</head>
<jsp:include page="/header_nlogout.jsp"/>
<body>
<div class="container">


    <div id="myCarousel" class="carousel slide">
        <div class="carousel-inner">
            <div class="item active">
                <img src="${pageContext.request.contextPath}/static/img/bezier0011.png" alt="">
                <div class="container">
                    <div style="background-color:rgba(218, 218, 218, 0.0)" class="carousel-caption">
                    </div>
                </div>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/static/img/BezierCurve.png" alt="">
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/static/img/Bezier.png" alt="">
                <div class="container">

                    <div style="background-color:rgba(218, 218, 218, 0.0); padding-bottom: 10px;" class="carousel-caption">

                        <a class="btn btn-large btn-success" href="${pageContext.request.contextPath}/app/modeling">Modeling your surface</a>

                    </div>
                </div>
            </div>
        </div>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
    </div><!-- /.carousel -->
    <!-- Example row of columns -->
    <div class="row">
        <div class="span4">
            <h2>Heading</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
            <p><a class="btn" href="#">View details &raquo;</a></p>
        </div>
        <div class="span4">
            <h2>Heading</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
            <p><a class="btn" href="#">View details &raquo;</a></p>
        </div>
        <div class="span4">
            <h2>Heading</h2>
            <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
            <p><a class="btn" href="#">View details &raquo;</a></p>
        </div>
    </div>

    <hr>

    <footer>
        <p>&copy; Company 2019</p>
    </footer>

</div><!-- /container -->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
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


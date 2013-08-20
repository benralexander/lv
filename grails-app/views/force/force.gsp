<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>BARD</title>
    <link rel="stylesheet/less" type="text/css" href="../less/variables.less">

    <link href="../css/bootstrap3.css" rel="stylesheet" media="screen">
    %{--<script src="../less/less-1.4.2.js"></script>--}%
        %{--<link href="../css/bootstrap-responsive.css" rel="stylesheet" media="screen">--}%


    <script src="../js/crossfilter.js"></script>
    <script src="../js/d3.js"></script>
    <script src="../js/dc.js"></script>
    %{--<link rel="stylesheet/css" type="text/css" href="../less/force.css">--}%
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'less', file: 'force.css')}" />

    <style>
    </style>
</head>

<body>
<script src="../js/jquery-2.0.3.min.js"></script>
<script src="../js/bootstrap3.js"></script>

<script>
//    The following code exists to provide compatibility for IE 10/Windows Phone 8, as per
//  the note found in bootstrap 3 documentation at URL =   http://getbootstrap.com/getting-started/
    if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
        var msViewportStyle = document.createElement("style")
        msViewportStyle.appendChild(
                document.createTextNode(
                        "@-ms-viewport{width:auto!important}"
                )
        )
        document.getElementsByTagName("head")[0].appendChild(msViewportStyle)
    }
</script>

<div class="container">
    <header class="row" id="bard_header">
        <div class="col-lg-5">
            <img src="../images/bard_logo_small.png" class="img-responsive" alt="Search and analyze your own way">
        </div>

        <div class="col-lg-7 img0">
            <nav id="navbar-example" class="navbar navbar-default navbar-static" role="navigation">
               <div class="collapse navbar-collapse bs-js-navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">About us <b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Details about Bard</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a id="drop2" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">How to <b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop2">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">How to search</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Work with results</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Submit data</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Use securely</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Create and use plug-ins</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" id="drop3" role="button" class="dropdown-toggle" data-toggle="dropdown">Support<b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Community</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Report a bug</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Contact us</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Separated link</a></li>
                            </ul>
                        </li>

                        <li class="dropdown">
                            <a href="#" id="drop4" role="button" class="dropdown-toggle" data-toggle="dropdown">Submissions<b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop4">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Details about Submissions</a></li>
                            </ul>

                        </li>

                    </ul>
                 </div><!-- /.nav-collapse -->
            </nav>

        </div>
    </header>

    <section class="row" >
        <div class="col-lg-12">
            <div  class="img-responsive" id="img0_big">
                   <img src="../images/imag0_01.jpg"  class="img-responsive" />
            </div>
        </div>
    </section>
    %{--<section class="row">--}%
        %{--<div class="col-lg-12  img-responsive">--}%
            %{--<div  class="img-responsive"   id="img0_small">--}%

            %{--</div>--}%

            %{--<div   class="row">--}%
                %{--<div class="col-lg-8">--}%
                    %{--<span  class="img0_text_shared img0_text">--}%
                        %{--Enhanced data and advanced tools--}%
                        %{--<div   class="subtext_shared subtext">--}%
                            %{--<span class=" hidden-phone">Introducing BARD, the powerful new bioassay database from the NIH Molecular Libraries Program.</span>--}%
                        %{--</div>--}%
                    %{--</span>--}%

                %{--</div>--}%
                %{--<div class="col-lg-4">--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%

    %{--</section>--}%

    <article class="row searchBar" id="searchBar">
        <div class="col-lg-12" >
            <form role="form">
                <div class="form-group">
                    <label for="searchInput">Search</label>
                    <input type="text" class="form-control" id="searchInput" placeholder="Search input">
                </div>
            </form>
        </div>
    </article>

    <section class="row" id="news">
        <div class="col-lg-12">
            Here is the news

        </div>
    </section>







    <aside class="row" id="bard_carousel">

        <div id="carousel-example-generic" class="carousel slide hidden-phone" data-interval="false">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                <li data-target="#f" data-slide-to="1"></li>
                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="item active">
                    <img src="../images/Slide01_01.jpg" class="img-responsive" alt="Public bioassay data">

                    <div class="carousel-caption">
                        Public bioassay data
                    </div>
                </div>

                <div class="item" id="#f">
                    <img src="../images/Slide02_01.jpg" class="img-responsive" alt="The power of a common language">

                    <div class="carousel-caption">
                        The power of a common language -- hurrah
                    </div>
                </div>

                <div class="item">
                    <img src="../images/Slide03_01.jpg" class="img-responsive" alt="Search and analyze your own way">

                    <div class="carousel-caption">
                        Search and analyze your own way-hurrah
                    </div>
                </div>

            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                <span class="icon-prev"></span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                <span class="icon-next"></span>
            </a>
        </div>
    </aside>


    <article class="row" id="bardIsGrowing">
        <div class="col-lg-12">
        </div>
    </article>



    <nav class="row" id="bardLinks">
        <div class="col-lg-12">
        </div>
    </nav>


    <footer class="row" id="bardFooter">
        <div class="col-lg-12">
        </div>
    </footer>



</div>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>BARD</title>
    <link rel="stylesheet/less" type="text/css" href="../less/variables.less">
    <script src="../less/less-1.4.1.min.js "></script>
    <link href="../css/bootstrap3.css" rel="stylesheet" media="screen">
    %{--<link href="../css/bootstrap-responsive.css" rel="stylesheet" media="screen">--}%


    <script src="../js/crossfilter.js"></script>
    <script src="../js/d3.js"></script>
    <script src="../js/dc.js"></script>
    <style>
    /*#img0{*/
        /*position: relative;*/
        /*font-family: Arial;*/
        /*top: 50px;*/
    /*}*/
    .img0_text_shared
    {
        position: absolute;
        width: 66%;
        top: 50px;
    }
    .img0_text .subtext_shared
    {
        padding-left: 5%;
        text-align: left;
    }
    .img0_text
    {
    font-size: 20pt;
    max-width: 800px;
    }
    .img0_text .subtext
    {
    margin-top: 50px;
    font-size: 14pt;
    }
    /*The following code exists to provide compatibility for IE 10/Windows Phone 8, as per*/
    /*the note found in bootstrap 3 documentation at URL =   http://getbootstrap.com/getting-started/*/
    @-webkit-viewport   { width: device-width; }
    @-moz-viewport      { width: device-width; }
    @-ms-viewport       { width: device-width; }
    @-o-viewport        { width: device-width; }
    @viewport           { width: device-width; }

    #img0_small{
        position: relative;
        background-image:url('../images/top_image3.jpg');
        font-family: Arial;
        /*height: 100%;*/
        background-size: 100% auto;
        background-repeat: no-repeat;
        /*height: 200px;*/
        /*max-width: 100%;*/
        /*height: auto;*/
    }
    #img0_big{
        background-image:url('../images/imag0_01.jpg');
        background-color:#cccccc;
        background-size: 100% auto;
        background-repeat: no-repeat;
        /*height: 200px;*/
        /*max-width: 100%;*/
        /*height: auto;*/
    }



        /*The following code shows how the CSS for multiple devices should be handled for bootstrap 3 */
        /* Small devices (tablets, 768px and up) */
    /*@media only screen and  (min-width: @screen-tablet) {*/
        @media only screen and  (min-width: 768px) {
        #img0{
            position: relative;
            font-family: Arial;
            top: 50px;
        }
    }

        /* Medium devices (desktops, 992px and up) */
        /*@media  only screen and (min-width: @screen-desktop) {*/
        @media  only screen and (min-width: 992px) {
            #img0{
                position: relative;
                font-family: Arial;
                top: 50px;
            }
        }


        /* Large devices (large desktops, 1200px and up) */
    /*@media only screen and  (min-width: @screen-large-desktop) {*/
        @media only screen and  (min-width: 1200px) {
        #img0{
            position: relative;
            font-family: Arial;
            top: 50px;
        }

    }
    .searchBar
    {
        height: 150px;
        width: 100%;
        background: rgb(4,84,119); /* Old browsers */
        background: -moz-linear-gradient(-45deg,  rgba(4,84,119,1) 0%, rgba(6,42,59,1) 36%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, right bottom, color-stop(0%,rgba(4,84,119,1)), color-stop(36%,rgba(6,42,59,1))); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(-45deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(-45deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* Opera 11.10+ */
        background: -ms-linear-gradient(-45deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* IE10+ */
        background: linear-gradient(135deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#045477', endColorstr='#062a3b',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */

    }
    %{--@media only screen and (min-width: 1100px) {--}%
        %{--.img0_text--}%
        %{--{--}%
            %{--font-size: 20pt;--}%
            %{--max-width: 800px;--}%
        %{--}--}%
        %{--.img0_text .subtext--}%
        %{--{--}%
            %{--margin-top: 50px;--}%
            %{--font-size: 14pt;--}%
        %{--}--}%

    %{--}--}%
    %{--@media only screen and (max-width: 1100px) {--}%
        %{--.img0_text--}%
        %{--{--}%
            %{--font-size: 18pt;--}%
            %{--max-width: 800px;--}%
        %{--}--}%
        %{--.img0_text .subtext--}%
        %{--{--}%
            %{--margin-top: 40px;--}%
            %{--font-size: 12pt;--}%
        %{--}--}%

    %{--}--}%
    %{--@media only screen and (max-width: 800px) {--}%
        %{--.img0_text--}%
        %{--{--}%
            %{--font-size: 16pt;--}%
            %{--max-width: 600px;--}%
            %{--top: 40px;--}%
        %{--}--}%
        %{--.img0_text .subtext--}%
        %{--{--}%
            %{--margin-top: 20px;--}%
            %{--font-size: 10pt;--}%
        %{--}--}%

    %{--}--}%

    %{--@media only screen and (max-width: 600px) {--}%
        %{--.img0_text--}%
        %{--{--}%
            %{--font-size: 12pt;--}%
            %{--max-width: 400px;--}%
            %{--top: 20px;--}%
        %{--}--}%
        %{--.img0_text .subtext--}%
        %{--{--}%
            %{--margin-top: 10px;--}%
            %{--font-size: 8pt;--}%
        %{--}--}%

    %{--}--}%
    %{--@media only screen and (max-width: 400px) {--}%
        %{--.img0_text--}%
        %{--{--}%
            %{--font-size: 10pt;--}%
            %{--max-width: 300px;--}%
            %{--top: 5px;--}%
        %{--}--}%
        %{--.img0_text .subtext--}%
        %{--{--}%
            %{--margin-top: 2px;--}%
            %{--font-size: 8pt;--}%
        %{--}--}%
    %{--}--}%
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

        <div class="col-lg-7">

        </div>
    </header>

    <section class="row" >
        <div class="col-lg-12">
            <div  class="img-responsive" id="img0_big">

            </div>
        </div>
    </section>
    <section class="row">
        <div class="col-lg-12  img-responsive">
            <div  class="img-responsive"   id="img0_small">

            </div>

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
        </div>

    </section>

    <article class="row searchBar" id="searchBar">
        <div class="col-lg-12">
            <form role="form">
                <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
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

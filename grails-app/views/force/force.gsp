<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>BARD</title>
    <link href="../css/bootstrap3.css" rel="stylesheet" media="screen">
    %{--<link href="../css/bootstrap-responsive.css" rel="stylesheet" media="screen">--}%


    <script src="../js/crossfilter.js"></script>
    <script src="../js/d3.js"></script>
    <script src="../js/dc.js"></script>
    <style>
    #img0{
        position: relative;
        font-family: Arial;
        top: 50px;
    }
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

<div class="container">
    <header class="row" id="bard_header">
        <div class="col-lg-5">
            <img src="../images/bard_logo_small.png" class="img-responsive" alt="Search and analyze your own way">
        </div>

        <div class="col-lg-7">

        </div>
    </header>

    <section class="row" id="img0">
        <div class="col-lg-12">
            <img src="../images/imag0_01.jpg" class="img-responsive" alt="Search and analyze your own way">
            <div   class="row">
                <div class="col-lg-8">
                    <span  class="img0_text_shared img0_text">
                        Enhanced data and advanced tools <span class="hidden-phone">to accelerate drug discovery</span>
                        <div   class="subtext_shared subtext">
                            <span class=" hidden-phone">Introducing BARD, the powerful new bioassay database from the NIH Molecular Libraries Program.
                            <span class="visible-desktop">Now with unprecedented  efficiency, scientists can develop and test hypotheses on the influence of
                            different chemical probes on biological functions</span></span>
                        </div>
                    </span>


                </div>
                <div class="col-lg-4">
                </div>
            </div>
        </div>

    </section>

    <article class="row" id="searchBar">
        <div class="col-lg-12">
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

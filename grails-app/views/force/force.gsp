<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>BARD</title>
    <link href="../css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="../css/bootstrap-responsive.css" rel="stylesheet" media="screen">


    <script src="../js/crossfilter.js"></script>
    <script src="../js/d3.js"></script>
    <script src="../js/dc.js"></script>
    <style>
    #img0{
        position: relative;
    }
    @media            (device-width: 320px)
    {
        .img0_text
        {
            font-family: Arial;
            font-size: 20pt;
            position: absolute;
            max-width: 800px;
            width: 66%;
            text-align: center;
            top: 50px;
            margin-bottom: 10%;
        }
    }
    @media  (device-width : 1204px)
    {
        .img0_text
        {
            font-family: Arial;
            font-size: 10pt;
            position: absolute;
            max-width: 800px;
            width: 66%;
            text-align: center;
            top: 50px;
            margin-bottom: 10%;
        }
         /*.img0_text*/
         /*{*/
             /*font-family: Arial;*/
             /*font-size: 62%;*/
             /*position: absolute;*/
             /*max-width: 800px;*/
             /*width: 66%;*/
             /*text-align: center;*/
             /*top: 50px;*/
             /*margin-bottom: 10%;*/
         /*}*/

    }
    .img0_text .subtext
    {
        margin-top: 50px;
        padding-left: 5%;
        font-size: 14pt;
        text-align: left;
    }
    </style>
</head>

<body>
<script src="../js/jquery-2.0.3.min.js"></script>
<script src="../js/bootstrap.js"></script>

<div class="container-fluid">
    <header class="row-fluid" id="bard_header">
        <div class="span5">
            <img src="../images/bard_logo_small.png" class="img-responsive" alt="Search and analyze your own way">
        </div>

        <div class="span7">

        </div>
    </header>

    <section class="row-fluid" id="img0">
        <div class="span12">
            <img src="../images/top_image3.jpg" class="img-responsive" alt="Search and analyze your own way">
            <div   class="row-fluid">
                <div class="span8">
                    <span  class="img0_text">
                        Enhanced data and advanced tools to accelerate drug discovery
                        <div   class="subtext">
                            Introducing BARD, the powerful new bioassay database from the NIH Molecular Libraries Program.
                            Now with unprecedented  efficiency, scientists can develop and test hypotheses on the influence of
                            different chemical probes on biological functions
                        </div>
                    </span>


                </div>
                <div class="span4">
                </div>
            </div>
        </div>

    </section>

    <article class="row-fluid" id="searchBar">
        <div class="span12">
        </div>
    </article>

    <section class="row-fluid" id="news">
        <div class="span12">
            Here is the news

        </div>
    </section>







    <aside class="row-fluid" id="bard_carousel">

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
                    <img src="../images/carosel1_0006_Slide%20Show%2001.jpg" class="img-responsive" alt="Public bioassay data">

                    <div class="carousel-caption">
                        Public bioassay data
                    </div>
                </div>

                <div class="item" id="#f">
                    <img src="../images/carosel2_0007_Slide%20Show%2002.jpg" class="img-responsive" alt="The power of a common language">

                    <div class="carousel-caption">
                        The power of a common language -- hurrah
                    </div>
                </div>

                <div class="item">
                    <img src="../images/carosel3_0008_Slide%20Show%2003.jpg" class="img-responsive" alt="Search and analyze your own way">

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


    <article class="row-fluid" id="bardIsGrowing">
        <div class="span12">
        </div>
    </article>



    <nav class="row-fluid" id="bardLinks">
        <div class="span12">
        </div>
    </nav>


    <footer class="row-fluid" id="bardFooter">
        <div class="span12">
        </div>
    </footer>



</div>
</body>
</html>

<%--
  about Bard  development team
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BARD</title>
    <link href='http://fonts.googleapis.com/css?family=Lato:400,400italic,700,700italic,900,900italic,300,300italic'
          rel='stylesheet' type='text/css'>
    <link media="all" rel="stylesheet" href="../css/bootstrapHomepage/bootstrap.css">
    <link media="all" rel="stylesheet" href="../css/bootstrapHomepage/bootstrap-responsive.css">
    <link media="all" rel="stylesheet" href="../css/bootstrapHomepage/BardText.css">
    <script src="../js/bardHomepage/jquery-1.8.3.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-1.8.3.min.js"><\/script>')</script>
    <script src="../js/bardHomepage/bootstrap.js"></script>
    <script src="../js/bardHomepage/jquery.main.js"></script>
    <!--[if lt IE 9]><link rel="stylesheet" href="../css/bootstrapHomepage/ieBardHomepage.css" media="screen" /><![endif]-->
    <!--[if IE]><script src="../js/bardHomepage/ie.js"></script><![endif]-->
</head>

<body>
<div id="wrapper">

    %{--The control area at the top of the page is all contained within this header--}%
    <header class="navbar navbar-static-top" id="header">
        <div class="container-fluid">
            <strong class="logo"><a href="../scaledDownHomePage/index">BARD BioAssay Research Database</a></strong>
            <ul class="social-networks">
                <li><a href="#" title="Share">Share</a></li>
                <li><a href="#" title="Google" class="google">Google</a></li>
            </ul>
            <nav class="nav-panel">
            </nav>
        </div>
    </header>


    %{--Block to hold the main search textblock--}%
    <div class="search-panel">
        <div class="container-fluid">
            <div class="row-fluid">
                <aside class="span2"></aside>
                <article class="span8 head-holder"><h2>Development team:</h2></article>
                <aside class="span2"></aside>
            </div>

        </div>
    </div>


    %{--Enhanced data and advanced tools block--}%
    <article class="hero-block">
        <div class="container-fluid">
            <div class="hero-area">
                <div class="row-fluid">
                    <aside class="span2"></aside>
                    <article class="span8">

                        <h3>
                            A Collaboration Between NIH and Key Academic Centers
                        </h3>

                        <p>
                            Launched in March of 2012, BARD is an initiative of the Molecular Libraries Program, a NIH Common Fund Program. After an iterative process that amalgamated multiple proposals, responsibility for various system components were awarded to these institutional members of the MLP network:                        </p>
                            <ul>
                                <li>Broad Institute</li>
                                <li>NIH Chemical Genomics Center</li>
                                <li>Sanford-Burnham Medical Research Institute</li>
                                <li>The Scripps Research Institute</li>
                                <li>University of Miami</li>
                                <li>University of New Mexico</li>
                                <li>Vanderbilt University</li>
                            </ul>
                         </p>

                    </article>
                    <aside class="span2"></aside>
                </div>
            </div>
        </div>
    </article>


    %{--This is the main carousel, with three big pictures and associated buttons--}%
    <div>
    </div>
    %{--The BARD is  growing line sits on its own above the blocks--}%

    %{--Now we have a footer section containing a bunch of links--}%
    <footer id="footer">
        <div class="footer-columns">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span4">
                        <h3>About</h3>
                        <ul>
                            <li><a href="../scaledDownHomePage/bardtext_rdm">Research Data Mgt.</a></li>
                            <li><a href="../scaledDownHomePage/bardtext_history">History</a></li>
                            <li><a href="../scaledDownHomePage/bardtext_developmentTeam">Development Team</a></li>
                        </ul>
                    </div>


                    <div class="span4">
                        <h3>Technology</h3>
                        <ul>
                            <li><a href="#">Architecture &amp; Design</a></li>
                            <li><a href="#">REST API</a></li>
                            <li><a href="#"  style="text-decoration:line-through;">Source code on GitHub <img src="../images/bardHomepage/comingSoon2.png" alt="coming soon"></a></li>
                        </ul>
                    </div>

                    <div class="span4 by">
                        <strong class="logo-by"><a href="http://www.chemaxon.com/" title="Powered by ChemAxon">Powered by ChemAxon</a></strong>

                        <p>&copy; 2013 BARD</p>
                    </div>
                </div>
            </div>
        </div>

        %{--The bottom line of the whole page--}%
        <div class="footer-info">
            <div class="container-fluid">
                <ul>
                    <li><a href="http://www.nih.gov/">National Institutes of Health</a></li>
                    <li><a href="#">U.S. Department of Health and Human Services</a></li>
                    <li><a href="http://www.usa.gov/">USA.gov – Government Made Easy</a></li>
                </ul>
            </div>
        </div>
    </footer>
</div>
</body>
</html>
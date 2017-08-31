$loyout = <<HTML;
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
   
    <title>Articles</title>
    
    <link rel="stylesheet" href="webroot/css/style.css" />
    
    <!-- Bootstrap core CSS -->
    <link href="webroot/css/bootstrap.min.css" rel="stylesheet">

  </head>

  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
              <a class="navbar-brand" href="#">Perl</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="index.pl?route=articles/showAll">Articles</a></li>
            <li><a href="index.pl?route=user/registration">Registration</a></li>
            <li><a href="index.pl?route=security/isUser">Test</a></li>
          </ul>

          <form class="navbar-form navbar-right">
            <div class="form-group">
              <label for="login">Name</label>
              <input type="text" class="form-control" id="login" placeholder="" name="nickname">
            </div>
            <div class="form-group">
              <label for="pass">Email</label>
              <input type="password" class="form-control" id="pass" placeholder="" name="password">
            </div>
            <button type="submit" class="btn btn-default">Login</button>
          </form>
        </div><!--/.nav-collapse -->
      </div><!--/.container -->
    </nav>
      
    
     <div class="container content">
           $content
     </div>

    <footer>
        Copyright &copy; 2017
    </footer>
    
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <script src="webroot/js/jquery.js"></script>
    <script src="/webroot/js/script.js"></script>
    <script src="webroot/js/bootstrap.min.js"></script>
  </body>
</html>
HTML

return 1;

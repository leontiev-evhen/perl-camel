$regform=<<HTML;
<h2>Registration</h2>

<form method="post" role="form" action="index.pl?route=user/registration">
     <div class="form-group">
        <label class='control-label' for="login" >Login:</label>
        <input type="text" name="login" class="form-control" id="login" placeholder="Enter login" value=""/>
    </div>
 
    <div class="form-group">
         <label class='control-label' for="password" >Password:</label>
        <input name="password1" id="password" class="form-control" type="password" placeholder="Enter password" value=""/>    
    </div>
    <div class="form-group">
         <label class='control-label' for="password_v" >Password(verification):</label>
        <input name="password2" id="password-v" class="form-control" type="password" placeholder="Enter password" value=""/> 
    </div>
    <div class="form-group">
        <label class='control-label' for="email" >E-mail:</label>
        <input type="text" name="email" class="form-control" id="email" placeholder="Enter email" value=""/>   
    </div>
    
    <p class='error' id='error'></p>
    <input type="submit" class="btn btn-success" value ="Login"/>
</form>
HTML

return 1;
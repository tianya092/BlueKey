<%@ page language="java" import="com.bluekey.connDb,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
    if(session.getAttribute("email")!=null){
		response.sendRedirect("query.jsp");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Blue key login</title>

<!-- CSS -->

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<link href="css/bootstrapValidator.css" rel="stylesheet">
</head>
<body>

	<!-- Top content -->
	<div class="top-content">

		<div class="inner-bg">
			<div class="container">
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2 text"  style="text-align: center">
						<h1>
							<strong>Welcome to Blue key</strong>
						</h1>
						<div class="description">
							<p style="font-size: 18px;">
								<strong>please login in with your w3id</strong>
							</p>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3 form-box">
						<div class="form-top">
							<img src="img/u6.jpg"
								style="text-align: center; width: 90%; padding-left: 10%;">
						</div>
						<div class="form-bottom">
							<form role="form" action="doLogin1.jsp" method="post" class="login-form" name="login-form">
								<div class="form-group">
									<label class="sr-only" for="form-email">Email</label> 
									<input type="text" name="email" placeholder="Email" class="email form-control" id="form-email">
								</div>
								<div class="form-group">
									<label class="sr-only" for="form-password">Password</label> 
									<input type="password" name="password" placeholder="Password" class="form-password form-control" id="form-password">
								</div>
								<button type="submit" class="btn">Sign in</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>


	<!-- Javascript -->
	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrapValidator.js"></script>
	<script src="js/jquery.backstretch.min.js"></script>
	<script src="js/scripts.js"></script>

	<!--[if lt IE 10]>
    <script src="assets/js/placeholder.js"></script>
<![endif]-->

<script type="text/javascript">
$(document).ready(function() {
    $('.login-form').bootstrapValidator({
	            message: 'This value is not valid',
	            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields: {/*验证*/
	            	
	                'email': {
	                    validators: {
	                        notEmpty: {
	                            message: 'The email address is required and can\'t be empty'
	                        },
	                        emailAddress: {
	                            message: 'The input is not a valid email address'
	                        }
	                    }
	                },
	                password: {
	                    validators: {
	                        notEmpty: {
	                            message: 'The password is required and can\'t be empty'
	                        }
	                    }
	                },
	               
	            }
	        });
	});
	
</script>
</body>
</html>
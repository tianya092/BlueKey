<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.User,com.bluekey.Mail,java.util.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%  
	request.setCharacterEncoding("utf-8");
	String email = (String)session.getAttribute("email");
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
	User  user = connDb.getUser(email); //get access list
	if(user.getFunction()!=1000){
		out.println("<script>alert(\"You haven't permission  to vist the page!\");window.history.go(-1);</script>");
	}
	
	String access_id = request.getParameter("access_id");
	
	Access access = new Access(); 
	Mail mail = new Mail();
	if(access_id!=null&&!access_id.equals("")){ 
		access = connDb.getAccessByID(access_id); //get access list
		mail = connDb.getMailTemplate(access_id); //get send mail template
	}
	String  title = "";
	String  short_title = "";
	String  function = "";
	String  platform = "";
	String  url = "";
	String  other_url = "";
	String  apply_email = "";
	int  	lead_time = 0;
	String  apply_step = "";
	int 	parent_part=0;
	String  email_title = "";
	String  content = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.js"></script>

<link rel="shortcut icon" href="img/favico.ico"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrapValidator.css" rel="stylesheet"> 

<script>
	
</script>
</head>
<body style="overflow:scroll;overflow-x:hidden">
	<div class=" wrapper">
	<div class="page">
    <jsp:include page= "top.jsp" flush ="true"/>
    <%
    	if(access_id!=null&&!access_id.equals("")){ 
    		title = access.getTitle();
    	    short_title = access.getShortTitle();
    		function = access.getFunction();
    		platform = access.getPlatform();
    		url = access.getUrl();
    		other_url = access.getOtherUrl();
    		apply_email = access.getApplyEmail();
    		lead_time = access.getLeadTime();
    		apply_step = access.getApplyStep().trim();
    		parent_part = access.getParentPart();
    		
    		if(mail.getTempId()!=0){ 
	    		email_title = mail.getSubjectTitle();
	    		content =mail.getContent();
    		}
    	}
    	
    %>
	<div class="container"  >
		<div class="row breadcrumb-nav" >
			<div class="col-xs-12 col-sm-12 col-sm-push-0">
				<ol class="breadcrumb">
					<li><a href="query.jsp">Home</a></li>
					<li><a href="#">Setting</a></li>
					<li class="active">Edit access</li>

				</ol>
			</div>
		</div>
		<legend>Edit access</legend>
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="tabbable" id="tabs-368872">
					<ul class="nav nav-tabs" >
						<li class="active">
							 <a href="#panel-detail" data-toggle="tab"> Detail information</a>
						</li>
						<li>
							 <a href="#panel-mail-template" data-toggle="tab" >Mail template</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane fade in active" id="panel-detail">
							<div class="row clearfix">
								<div class="col-md-12 column">
									<form class="form-horizontal" id="detail_form" method="post" role="form" action="doEditAccess.jsp">
										<div class="form-group">
											 <label for="inputParent_part" class="col-sm-2 control-label"><span style="color:red">*</span>Parent part</label>
											<div class="col-sm-4">
												<select class="form-control " name="parent_part">
													<option value="1" <%if(parent_part==1) {out.print("selected");}%>>general access</option>
													<option value="2" <% if(parent_part==2) {out.print("selected");}%>>function access</option>
												</select>
											</div>
										</div>
										
										<div class="form-group">
											 <label for="inputTitle" class="col-sm-2 control-label"><span style="color:red">*</span>Access title</label>
											<div class="col-sm-8">
												<input type="text" class="form-control input" name="title"   value="<%=title%>"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputShortTitle" class="col-sm-2 control-label"><span style="color:red">*</span>Short title</label>
											<div class="col-sm-8">
												<input type="text" class="form-control input" name="short_title" value="<%=short_title%>"/>
											</div>
										</div>
										
										<div class="form-group">
											 <label for="inputFunction" class="col-sm-2 control-label"><span style="color:red">*</span>Description</label>
											<div class="col-sm-8">
												<textarea class="form-control  input" name="function" rows="6"><%=function%></textarea>
												<%-- <input type="text" class="form-control input" name="function" value="<%=function%>"/> --%>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputPlatform" class="col-sm-2 control-label"><span style="color:red">*</span>Platform</label>
											<div class="col-sm-8">
												 <input type="radio" name="platform" value="1" <%if(platform.equals("1")) out.print("checked"); %>>lotus notes &nbsp;&nbsp;&nbsp;
									             <input type="radio" name="platform" value="2" <%if(platform.equals("2")) out.print("checked"); %>>web
											</div>
										</div>				
										<div class="form-group">
											 <label for="inputURL" class="col-sm-2 control-label">URL</label>
											<div class="col-sm-8">
												<input type="url" class="form-control input" name="url" value="<%=url%>" placeholder="http://"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputURL" class="col-sm-2 control-label">URL 2</label>
											<div class="col-sm-8">
												<input type="url" class="form-control input" name="other_url" value="<%=other_url%>" placeholder="http://"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputURL" class="col-sm-2 control-label">Access email</label>
											<div class="col-sm-8">
												<input type="email" class="form-control input" name="apply_email" value="<%=apply_email%>" placeholder="XXXXX@cn.ibm.com"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputURL" class="col-sm-2 control-label">Lead time</label>
											<div class="col-sm-2">
												<input type="number" class="form-control input" name="lead_time"  value="<%=lead_time%>"/>
											</div>
											<div class="col-sm-1"><p class="form-control-static">days</p></div>
										</div>
										
										<div class="form-group">
											 <label for="inputApply_step" class="col-sm-2 control-label"><span style="color:red">*</span>Apply step</label>
											<div class="col-sm-8">
												<textarea class="form-control  input" name="apply_step" rows="12"><%=apply_step%></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												 <input type="hidden"name="access_id" value="<%if(access_id!=null){out.print(access_id);}%>">
												 <button type="submit" class="btn btn-primary">submit</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="tab-pane fade " id="panel-mail-template">
							
							<div class="row clearfix">
								<div class="col-md-13 column">
									<form  id="email_template" class="form-horizontal" method="post" role="form" action="doEditEmail.jsp">
										
										<div class="form-group">
											 <label for="inputTitle" class="col-sm-2 control-label"><span style="color:red">*</span>Mail Title</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" name="email_title"   value="<%=email_title%>"/>
											</div>
										</div>
										
										<div class="form-group">
											 <label for="inputContent" class="col-sm-2 control-label"><span style="color:red">*</span>Content</label>
											<div class="col-sm-8">
												<textarea class="form-control" name="content" rows="18"><%=content%></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												 <input type="hidden"name="access_id" value="<%if(access_id!=null){out.print(access_id);}%>">
												 <input type="hidden"name="temp_id" value="<%if(access_id!=null&&!access_id.equals("")){ 
													 	out.print(mail.getTempId());
													 }%>">
												 <button type="submit" class="btn btn-primary">submit</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<div class="guide">
		<div class="guide-wrap">
			<a href="feedback.jsp" class="report" title="Feedback"><span>Feedback</span></a>
			<a href="#" class="top" title="To top"><span>To top</span></a>
		</div>
	</div>
	</div>
	<jsp:include page= "bottom.jsp" flush ="true"/>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".top").on("click", function() { 
	            $("body").stop().animate({  
	                scrollTop: 0  
	            });  
	        })  
		});
		$(document).ready(function() {
		    $('#detail_form').bootstrapValidator({
		            message: 'This value is not valid',
		            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
		            fields: {/*验证*/
		            	parent_part: {
		            		
		                    validators: {
		                        notEmpty: {
		                            message: 'The parent part is required'
		                        }
		                    }
		                },
		            	title: {
		                    validators: {
		                        notEmpty: {
		                            message: 'The Access title is required and cannot be empty'
		                        },
		                        stringLength: {
		                            min: 1,
		                            max: 100,
		                            message: 'The Access title must be more than 1 and less than 100 characters long'
		                        },
		                    }
		                },
		                short_title: {
		                    validators: {
		                        notEmpty: {
		                            message: 'The Short Title is required and cannot be empty'
		                        },
		                        stringLength: {
		                            min: 1,
		                            max: 100,
		                            message: 'The Short title must be more than 1 and less than 100 characters long'
		                        },
		                    }
		                },
		                'function': {
		                    validators: {
		                        notEmpty: {
		                            message: 'The Description is required and cannot be empty'
		                        },
		                        stringLength: {
		                            min: 6,
		                            message: 'The Description must be more than 6 characters long'
		                        },
		                    }
		                },
		                url: {
		                	validators: {
		                        uri: {
		                            message: 'The input is not a valid URL'
		                        }
		                    }
		                },
		                other_url: {
		                	validators: {
		                        uri: {
		                            message: 'The input is not a valid URL'
		                        }
		                    }
		                },
		            	platform : {
		                    feedbackIcons: false,
		                    validators: {
		                        notEmpty: {
		                            message: 'The platform is required'
		                        }
		                    }
		                },
		                email: {
		                    validators: {
		                        notEmpty: {
		                            message: 'The email address is required and can\'t be empty'
		                        },
		                        emailAddress: {
		                            message: 'The input is not a valid email address'
		                        }
		                    }
		                },
		                lead_time: {
		                    validators: {
		                        digits: {
		                            message: 'The value can contain only digits'
		                        }
		                    }
		                },
		                apply_step: {
		                    validators: {
		                        notEmpty: {
		                            message: 'The Apply step is required and cannot be empty'
		                        },
		                        stringLength: {
		                            min: 10,
		                            message: 'The Apply step must be more than 10 characters long'
		                        },
		                    }
		                },
		               
		            }
		        });
		    $('#email_template').bootstrapValidator({
	            message: 'This value is not valid',
	            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields: {/*验证*/
	            	
	            	email_title: {
	                    validators: {
	                        notEmpty: {
	                            message: 'The Email Title is required and cannot be empty'
	                        },
	                        stringLength: {
	                            min: 6,
	                            max: 100,
	                            message: 'The Email title must be more than 6 and less than 100 characters long'
	                        },
	                    }
	                },
	             
	                content: {
	                    validators: {
	                        notEmpty: {
	                            message: 'The content  is required and cannot be empty'
	                        },
	                        stringLength: {
	                            min: 10,
	                            message: 'The content  must be more than 10 characters long'
	                        },
	                    }
	                },
	               
	            }
	        });
		});
		
		</script>
</body>
</html>

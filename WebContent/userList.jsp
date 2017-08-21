<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.User,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String email = (String) session.getAttribute("email");
	if (email == null || email.equals("")) {
		response.sendRedirect("login.jsp");
	}
	User loginUser = connDb.getUser(email); //get access list
	if (loginUser.getFunction() != 1000) {
		out.println(
				"<script>alert(\"You haven't permission  to vist the page!\");window.location.href=\"query.jsp\";</script>");
	}

	Map<String, String> detail = null;

	ArrayList<User> userList = connDb.getUserList(); //get access list
	String[] functionArr = new String[]{"", "PP", "PI", "Finance", "DSA", "COSSM", "Eng"};
	String[] teamArr = new String[]{"", "Ellen Xu", "Vivian Chen", "Shirly Xie", "Simon Lv", "Hugo cai",
			"kenny Kong", "Anne lei", "Li Ping", "Mike Huang", "Jessica Wei", "Logan Huang", "Ziv Zhao",
			"Jason Guo", "Mary Ma"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.js"></script>
<script src="js/language/zh_CN.js"></script>
<script src="js/jquery.cxselect.js"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrapValidator.css" rel="stylesheet">

</head>
<body data-spy="scroll" data-target="#myScrollspy">
	<div class="wrapper">
		<jsp:include page="top.jsp" flush="true" />
		<div class="container">
			<div class="row breadcrumb-nav" >
				<div class="col-xs-12 col-sm-12 col-sm-push-0">
					<ol class="breadcrumb">
						<li><a href="query.jsp">Home</a></li>
						<li><a href="#">Setting</a></li>
						<li class="active">Authority manage</li>

					</ol>
				</div>
			</div>

			<legend>User List</legend>
			<div class="page-header">
				<a class="btn btn-info btn" data-target="#edit-right-modal"
					data-toggle="modal"> <span class="glyphicon glyphicon-plus"></span>
					add an user
				</a>
			</div>
			<div class="table-responsive">
				<table class="table  table-hover">
					<thead>
						<tr class="active">
							<th>No</th>
							<th>Email</th>
							<th>Authorization role</th>
							<th>Update time</th>
							<th>Update operator</th>
							<th>Operate</th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 1;
							String authRolo;
							for (User user : userList) {
								if (user.getFunction() == 1000) {
									authRolo = "Super Admin";
								} else {
									authRolo = functionArr[user.getFunction()] + "&nbsp/&nbsp" + teamArr[user.getTeam()];
								}
								out.print("<tr><td>" + i + "</td><td>" + user.getEmail() + "</td><td>" + authRolo + "</td><td>"
										+ user.getUpdateTime() + "</td><td>" + user.getUpdateOperator()
										+ "</td><td><a id= \"modal-174354\" href=\"editUserRight.jsp?user_id=" + user.getUserId()
										+ " \"><span class=\"glyphicon glyphicon-pencil\"></span></a>&nbsp;&nbsp;&nbsp;&nbsp <a href=\"deleteUserRight.jsp?user_id="
										+ user.getUserId() + "\"><span class=\"glyphicon glyphicon-trash\"></span></a></td></tr>");
								i++;
							}
						%>
					</tbody>
				</table>

				<div class="col-md-12 column">

					<div class="modal fade" id="edit-right-modal" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">×</button>
									<h4 class="modal-title" id="myModalLabel">Edit user right</h4>
								</div>
								<form class="form-horizontal" role="form"
									action="doUserRight.jsp" action="post" id="user_right_form">
									<div class="modal-body" style="height: 200px">
										<div id="select_role">
											<div class="form-group">
												<label for="inputEmailTitle" class="col-sm-3 control-label"><span
													style="color: red">*</span>User email</label>
												<div class="col-sm-6 ">
													<input type="text" name="user_email" class="form-control"
														placeholder="Input user's Email" />
												</div>
											</div>
											<div class="form-group">
												<label for="inputParent_part" class="col-sm-3 control-label"><span
													style="color: red">*</span>Function:</label>
												<div class="col-sm-8">
													<select class="function form-control" name="function"></select>
												</div>
											</div>
											<div class="form-group">
												<label for="inputParent_part" class="col-sm-3 control-label">Team:</label>
												<div class="col-sm-8">
													<select class="team form-control" name="team"
														data-required="false" data-first-title="Select team"></select>
												</div>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
										<button type="submit" class="btn btn-primary">Save</button>
									</div>
								</form>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
	<script>
		(function() {
			var urlSelectData = [ {
				'v' : '1',
				'n' : 'PP',
				's' : [ {
					'v' : '1',
					'n' : 'Ellen Xu',
					's' : [ {
						'v' : '1',
						'n' : 'GCM',
						's' : [ {
							'v' : '1',
							'n' : 'Platform'
						}, {
							'v' : '2',
							'n' : 'Ecat'
						}, {
							'v' : '3',
							'n' : 'PCB'
						}, ]
					} ]
				}, {
					'v' : '2',
					'n' : 'Vivian Chen',
					's' : [ {
						'v' : '2',
						'n' : 'BC'
					}, {
						'v' : '3',
						'n' : 'Admin'
					}, {
						'v' : '4',
						'n' : 'Government relationship'
					}, {
						'v' : '5',
						'n' : 'HR'
					}, {
						'v' : '6',
						'n' : 'Assistant of Excutive'
					}, {
						'v' : '7',
						'n' : 'Communication'
					}, {
						'v' : '8',
						'n' : 'Reception'
					} ]
				}, {
					'v' : '3',
					'n' : 'Shirly Xie',
					's' : [ {
						'v' : '9',
						'n' : 'Consult'
					} ]
				}, {
					'v' : '4',
					'n' : 'Simon Lv',
					's' : [ {
						'v' : '10',
						'n' : 'PCE'
					}, {
						'v' : '11',
						'n' : 'GCM'
					} ]
				} ]
			}, {
				'v' : '2',
				'n' : 'PI',
				's' : [ {
					'v' : '5',
					'n' : 'Hugo cai',
					's' : [ {
						'v' : '12',
						'n' : 'DSW NPM'
					}, {
						'v' : '13',
						'n' : 'DSW BNPM'
					}, {
						'v' : '14',
						'n' : 'BPE'
					}, {
						'v' : '15',
						'n' : 'ESW NPM'
					}, {
						'v' : '16',
						'n' : 'ESW BNPM'
					}, {
						'v' : '17',
						'n' : 'Code Mangerment'
					}, {
						'v' : '18',
						'n' : 'SAP'
					}, {
						'v' : '19',
						'n' : 'Pring'
					}, {
						'v' : '20',
						'n' : 'CP'
					} ]
				}, {
					'v' : '6',
					'n' : 'kenny Kong',
					's' : [ {
						'v' : '12',
						'n' : 'DSW NPM'
					}, {
						'v' : '13',
						'n' : 'DSW BNPM'
					}, {
						'v' : '14',
						'n' : 'BPE'
					}, {
						'v' : '15',
						'n' : 'ESW NPM'
					}, {
						'v' : '16',
						'n' : 'ESW BNPM'
					}, {
						'v' : '17',
						'n' : 'Code Mangerment'
					}, {
						'v' : '18',
						'n' : 'SAP'
					}, {
						'v' : '19',
						'n' : 'Pring'
					}, {
						'v' : '20',
						'n' : 'CP'
					} ]
				}, {
					'v' : '7',
					'n' : 'Anne lei',
					's' : [ {
						'v' : '12',
						'n' : 'DSW NPM'
					}, {
						'v' : '13',
						'n' : 'DSW BNPM'
					}, {
						'v' : '14',
						'n' : 'BPE'
					}, {
						'v' : '15',
						'n' : 'ESW NPM'
					}, {
						'v' : '16',
						'n' : 'ESW BNPM'
					}, {
						'v' : '17',
						'n' : 'Code Mangerment'
					}, {
						'v' : '18',
						'n' : 'SAP'
					}, {
						'v' : '19',
						'n' : 'Pring'
					}, {
						'v' : '20',
						'n' : 'CP'
					} ]
				} ]
			}, {
				'v' : '3',
				'n' : 'Finance',
				's' : [ {
					'v' : '8',
					'n' : 'Li Ping',
					's' : [ {
						'v' : '21',
						'n' : 'CPC FIN Control'
					}, {
						'v' : '22',
						'n' : 'Staff Financial Analyst'
					} ]
				} ]
			}, {
				'v' : '4',
				'n' : 'DSA',
				's' : [ {
					'v' : '9',
					'n' : 'Mike Huang',
					's' : [ {
						'v' : '23',
						'n' : 'Demand planning'
					}, {
						'v' : '24',
						'n' : 'Inventory '
					}, {
						'v' : '25',
						'n' : 'Supply Assurance'
					}, {
						'v' : '26',
						'n' : 'GCSA '
					}, ]
				} ]
			}, {
				'v' : '5',
				'n' : 'COSSM',
				's' : [ {
					'v' : '10',
					'n' : 'Jessica Wei',
					's' : [ {
						'v' : '27',
						'n' : 'Hardware Order to Delivery management'
					} ]
				} ]
			}, {
				'v' : '6',
				'n' : 'Eng',
				's' : [ {
					'v' : '11',
					'n' : 'Logan Huang',
					's' : [ {
						'v' : '28',
						'n' : 'QE'
					}, {
						'v' : '29',
						'n' : 'TE'
					}, {
						'v' : '30',
						'n' : 'OPE'
					} ]
				}, {
					'v' : '12',
					'n' : 'Ziv Zhao',
					's' : [ {
						'v' : '31',
						'n' : 'PQE'
					}, {
						'v' : '32',
						'n' : 'TQE'
					}, {
						'v' : '33',
						'n' : 'Test'
					} ]
				}, {
					'v' : '13',
					'n' : 'Jason Guo',
					's' : [ {
						'v' : '34',
						'n' : 'ENG'
					} ]
				}, {
					'v' : '14',
					'n' : 'Mary Ma',
					's' : [ {
						'v' : '35',
						'n' : 'PQE'
					} ]
				} ]
			}, {
				'v' : '1000',
				'n' : 'Super Admin'
			} ];
			$('#select_role').cxSelect({
				selects : [ 'function', 'team', 'job_role', 'commodity' ],
				required : true,
				jsonValue : 'v',
				url : urlSelectData
			});
		})();
		$(document)
				.ready(
						function() {
							$('#user_right_form')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {/*输入框不同状态，显示图片的样式*/
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {/*验证*/
													user_email : {
														validators : {
															notEmpty : {
																message : 'The email is required and can\'t be empty'
															},
															emailAddress : {
																message : 'The input is not a valid email address'
															}
														}
													},
													'function' : {
														validators : {
															notEmpty : {
																message : 'The Access Title is required and cannot be empty'
															}
														}
													},
												}
											});
						})
	</script>
</body>
</html>

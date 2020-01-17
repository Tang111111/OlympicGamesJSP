<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Olympic Games-Contact us</title>
	<link rel="stylesheet" type="text/css" href="css/contactpage.css"/>
	<script src="js/jquery.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
	</script>

</head>
<body>
<!-- header -->
<div id="page-head"></div>

<!-- //header -->

<!-- contact us -->
<div class="contact">
	<div class="map" >
		<iframe src="https://www.google.com/maps/embed/v1/place?q=northeastern%20university%2Cchina&key=AIzaSyDo6mOAMLHNLrBtjjJVFAfYjkUPW7fbdRc" frameborder="0" style="border: 0; allowfullscreen"></iframe>
	</div>
	<div class="container" >
		<div class="map-grids">
			<div class="col-md-3 contact-left">
				<h3>Address</h3>
				<div class="line minus"> </div>
				<p>NEU, Hunnan District
					<span>Shenyang, Liaoning, China</span></p>
				<ul>
					<li>Telephone :+86 1234567</li>
					<li>Weibo :@example</li>
					<li>Twitter :@example</li>
					<li>Facebook :@example</li>
					<li><a href="mailto:yangpeiyineu@163.com">info@example.com</a></li>
				</ul>
			</div>
			<div class="col-md-9 contact-left">
				<h3>Contact Form</h3>
				<div class="line minus1"></div>
				<form>
					<input required="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Name';}" type="text" value="Name">
					<input required="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Email';}" type="email" value="Email">
					<input required="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Telephone';}" type="text" value="Telephone">
					<textarea required="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Message...';}" type="text">Message...</textarea>
					<input type="submit" value="Submit">
				</form>
			</div>
			<div class="clearfix"> </div>
		</div>
	</div>
</div>
</div>
<!-- //contact us -->

<!-- footer-->

<div id="page-footer">

</div>

</body>
</html>

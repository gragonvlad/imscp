
		<div class="clearfix">
			<div id="loginBox">
				<form name="loginFrm" action="index.php" method="post">
					<label for="uname"><div>{TR_USERNAME}</div><input type="text" name="uname" id="uname" tabindex="1"/></label>
					<label for="upass"><div>{TR_PASSWORD}</div><input type="password" name="upass" id="upass" tabindex="2"/></label>
					<div class="button">
						<!-- BDP: lostpwd_button -->
						<button name="lostpwd" type="button" tabindex="4" onclick="location.href='lostpassword.php'">{TR_LOSTPW}</button>
						<!-- EDP: lostpwd_button -->
						<button  name="login" type="submit" tabindex="3">{TR_LOGIN}</button>
					</div>
					<!-- BDP: ssl_support -->
					<a style="float:none;" class="icon {SSL_IMAGE_CLASS}" href="{SSL_LINK}" title="{TR_SSL_DESCRIPTION}">{TR_SSL}</a>
					<!-- EDP: ssl_support -->
				</form>
			</div>
		</div>
		<div id="toolbox">
			<ul>
				<li><a class="icon_big pma" href="{TR_PMA_LINK}" target="blank" title="Login into PhpMyAdmin">{TR_PHPMYADMIN}</a></li>
				<li><a class="icon_big filemanager" href="{TR_FTP_LINK}" target="blank" title="Login into the File manager">FileManager</a></li>
				<li><a class="icon_big webmail" href="{TR_WEBMAIL_LINK}" target="blank" title="Login into the Webmail">{TR_WEBMAIL}</a></li>
			</ul>
		</div>

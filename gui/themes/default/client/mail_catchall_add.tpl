
<body>
	<script type="text/javascript">
	/* <![CDATA[ */
		function changeType(what) {
			if (what == "normal") {
				document.forms[0].mail_id.disabled = false;
				document.forms[0].forward_list.disabled = true;
			} else {
				document.forms[0].mail_id.disabled = true;
				document.forms[0].forward_list.disabled = false;
			}
		}

		$(window).load(function() {changeType('{DEFAULT}');});
	/* ]]> */
	</script>
	<div class="body">
		<h2 class="email"><span>{TR_CREATE_CATCHALL_MAIL_ACCOUNT}</span></h2>

		<div id="fwd_help" class="tooltip">{TR_FWD_HELP}</div>

		<!-- BDP: page_message -->
		<div class="{MESSAGE_CLS}">{MESSAGE}</div>
		<!-- EDP: page_message -->

		<form name="create_catchall_frm" method="post" action="mail_catchall_add.php">
			<table>
				<tr>
					<td>
						<input type="radio" name="mail_type" id="mail_type1" value="normal" {NORMAL_MAIL} onclick="changeType('normal');"/>
						<label for="mail_type1">{TR_MAIL_LIST}</label>
					</td>
					<td>
						<select name="mail_id">
							<!-- BDP: mail_list -->
							<option value="{MAIL_ID};{MAIL_ACCOUNT_PUNNY};">{MAIL_ACCOUNT}</option>
							<!-- EDP: mail_list -->
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<input type="radio" name="mail_type" id="mail_type2" value="forward" {FORWARD_MAIL}
							   onclick="changeType('forward');"/>
						<label for="mail_type2">{TR_FORWARD_MAIL}</label>
						<span class="icon i_help" title="{TR_FWD_HELP}">{TR_HELP}</span>
					</td>
					<td><textarea name="forward_list" id="forward_list" cols="35" rows="5"></textarea></td>
				</tr>
			</table>

			<div class="buttons">
				<input type="hidden" name="uaction" value="create_catchall"/>
				<input type="hidden" name="id" value="{ID}"/>
				<input name="Submit" type="submit" value="{TR_CREATE_CATCHALL}"/>
			</div>
		</form>
	</div>

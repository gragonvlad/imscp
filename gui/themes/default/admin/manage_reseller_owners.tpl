
            <form action="manage_reseller_owners.php" method="post" name="admin_reseller_assignment" id="admin_reseller_assignment">
   
                <!-- BDP: reseller_list -->
                <table>
                    <tr>
                        <th>{TR_NUMBER}</th>
                        <th>{TR_MARK}</th>
                        <th>{TR_RESELLER_NAME}</th>
                        <th>{TR_OWNER}</th>
                    </tr>
                    <!-- BDP: reseller_item -->
                    <tr>
                        <td>{NUMBER}</td>
                        <td><input id="{CKB_NAME}" type="checkbox" name="{CKB_NAME}" /></td>
                        <td><label for="{CKB_NAME}">{RESELLER_NAME}</label></td>
                        <td>{OWNER}</td>
                    </tr>
                    <!-- EDP: reseller_item -->
                </table>
                <!-- EDP: reseller_list -->

                <!-- BDP: select_admin -->
                <div class="buttons">
                    {TR_TO_ADMIN}
                    <select name="dest_admin">
                    <!-- BDP: select_admin_option -->
                        <option {SELECTED} value="{VALUE}">{OPTION}</option>
                    <!-- EDP: select_admin_option -->
                    </select>
                    <input name="Submit" type="submit" value="{TR_MOVE}" />
                    <input type="hidden" name="uaction" value="reseller_owner" />
                </div>
                <!-- EDP: select_admin -->
            </form>

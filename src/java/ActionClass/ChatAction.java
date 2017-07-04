/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ActionClass;

import BeanClass.Chatformbean;
import JDBCConn.DatabaseConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.actions.DispatchAction;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author User
 */
public class ChatAction extends DispatchAction {

    public ActionForward loadChatHistory(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        System.out.println("track1");
        Chatformbean newchat = (Chatformbean) form;
        String user_from = newchat.getChat_user_id_from();
        String user_to = newchat.getChat_user_id_to();
        List<Map<String, String>> chatlist = new ArrayList<Map<String, String>>();
        System.out.println("Test track");
        String getusers_query = "SELECT from_user,to_user,chat_content,chat_status FROM `small_chat` WHERE to_user IN('" + user_from + "','" + user_to + "') and from_user IN('" + user_from + "','" + user_to + "') order by id;";
        PreparedStatement prest = null;
        Connection Chat = new DatabaseConnection().DataConn();
        prest = Chat.prepareStatement(getusers_query);
        ResultSet user = prest.executeQuery();
        String complete_chat = "";
        while (user.next()) {
            Map<String, String> data = new HashMap<>();
            if (user.getString("from_user").equals(user_from)) {
                //data.put("user", user.getString("to_user"));
                data.put("text", user.getString("chat_content"));
                data.put("alignment", "1");
                data.put("status", user.getString("chat_status"));
            } else {
                //data.put("user", user.getString("from_user"));
                data.put("text", user.getString("chat_content"));
                data.put("alignment", "0");
                //data.put("status",user.getString("chat_status"));
            }
            chatlist.add(data);
            System.out.println("Test track1");
        }

        String update_query = "Update `small_chat` SET chat_status = 'r' WHERE chat_status = 'u' and to_user = " + user_from;
        prest = Chat.prepareStatement(update_query);
        prest.executeUpdate();
        prest.close();
        Chat.close();

        try {
            System.out.println(chatlist.toString());
            ObjectMapper objMap = new ObjectMapper();
            objMap.writeValue(response.getWriter(), chatlist);
            return mapping.findForward("success");
        } catch (IOException ex) {
            System.out.println(ex.toString());
        }

        return null;
    }

    public ActionForward getNewChat(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        System.out.println("track1");
        Chatformbean newchat = (Chatformbean) form;
        String user_from = newchat.getChat_user_id_from();
        List<Map<String, String>> chatlist = new ArrayList<Map<String, String>>();
        System.out.println("Test track");
        String getusers_query = "SELECT from_user,to_user,chat_content FROM `small_chat` WHERE to_user = '" + user_from + "' and chat_status = 'u' order by id;";
        PreparedStatement prest = null;
        Connection Chat = new DatabaseConnection().DataConn();
        prest = Chat.prepareStatement(getusers_query);
        ResultSet user = prest.executeQuery();
        String complete_chat = "";
        while (user.next()) {
            Map<String, String> data = new HashMap<>();
            data.put("user", user.getString("from_user"));
            data.put("text", user.getString("chat_content"));
            chatlist.add(data);
            System.out.println("Test track1");
        }

        String update_query = "Update `small_chat` SET chat_status = 'r' WHERE chat_status = 'u' and to_user = " + user_from;
        prest = Chat.prepareStatement(update_query);
        prest.executeUpdate();
        prest.close();
        Chat.close();

        try {
            System.out.println(chatlist.toString());
            ObjectMapper objMap = new ObjectMapper();
            objMap.writeValue(response.getWriter(), chatlist);
            return mapping.findForward("success");
        } catch (IOException ex) {
            System.out.println(ex.toString());
        }
        return null;
    }

    public ActionForward sendChat(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        System.out.println("track");
        Chatformbean newchat = (Chatformbean) form;

        String user_from = newchat.getChat_user_id_from();
        String user_to = newchat.getChat_user_id_to();
        String chat_content = newchat.getChat_text();

        String storechat_query = "INSERT INTO `small_chat`(`from_user`,`to_user`,`chat_content`)VALUES('" + user_from + "','" + user_to + "','" + chat_content + "');";

        System.out.println("track " + user_from + ":" + user_to + ":" + chat_content);
        PreparedStatement prest = null;
        Connection storeChat = new DatabaseConnection().DataConn();
        prest = storeChat.prepareStatement(storechat_query);
        prest.executeUpdate();

        prest.close();
        storeChat.close();

        return null;
    }

    public ActionForward updateChatStatus(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        return null;
    }

    public ActionForward deliveryreport(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Chatformbean id = (Chatformbean) form;
        
        String online_check= "SELECT userid,status FROM test.user_chat WHERE userid="+id;
        PreparedStatement prest = null;
        Connection delivery_report= new DatabaseConnection().DataConn();
        prest = delivery_report.prepareStatement(online_check);
        ResultSet status_state= prest.executeQuery();
        
        while(status_state.next())
        {
            if(status_state.getString("status").equals("o"))
            {
                
            }
        }

        return null;
    }

    public ActionForward getOnlineStatus(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Map<String, String>> namelist = new ArrayList<Map<String, String>>();

        String getname_query = "SELECT userid,status FROM testdata.user_chat order by unsername;";
        PreparedStatement prest = null;
        Connection storeChat = new DatabaseConnection().DataConn();
        prest = storeChat.prepareStatement(getname_query);
        ResultSet name_list = prest.executeQuery();

        while (name_list.next()) {
            Map<String, String> data = new HashMap<>();
            data.put("user_id", name_list.getString("userid"));
            System.out.println(name_list.getString("userid"));

            data.put("user_status", name_list.getString("status"));
            System.out.println(name_list.getString("status"));
            System.out.println(data.toString());
            namelist.add(data);
            System.out.println(namelist.toString());

        }
        storeChat.close();
        prest.close();

        try {
            System.out.println(namelist.toString());
            ObjectMapper objMap = new ObjectMapper();
            objMap.writeValue(response.getWriter(), namelist);
            return mapping.findForward("success");
        } catch (IOException ex) {
            System.out.println(ex.toString());
        }

        return null;
    }

    public ActionForward getChatNameList(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Map<String, String>> namelist = new ArrayList<Map<String, String>>();

        String getname_query = "SELECT userid,unsername FROM testdata.user_chat order by unsername;";
        PreparedStatement prest = null;
        Connection storeChat = new DatabaseConnection().DataConn();
        prest = storeChat.prepareStatement(getname_query);
        ResultSet name_list = prest.executeQuery();
        while (name_list.next()) {
            Map<String, String> data = new HashMap<>();
            data.put("user_id", name_list.getString("userid"));
            System.out.println(name_list.getString("userid"));

            data.put("user_name", name_list.getString("unsername"));
            System.out.println(name_list.getString("unsername"));
            System.out.println(data.toString());
            namelist.add(data);
            System.out.println(namelist.toString());

        }
        storeChat.close();
        prest.close();
        try {
            System.out.println(namelist.toString());
            ObjectMapper objMap = new ObjectMapper();
            objMap.writeValue(response.getWriter(), namelist);
            return mapping.findForward("success");
        } catch (IOException ex) {
            System.out.println(ex.toString());
        }

        return null;
    }
}

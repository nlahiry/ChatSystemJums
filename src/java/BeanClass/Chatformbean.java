package BeanClass;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author User
 */
public class Chatformbean extends org.apache.struts.action.ActionForm {

    

    private String chat_session;
    private String chat_user_id_from;
    private String chat_user_id_to;
    private String chat_text;
    private String chat_type;

    public String getChat_session() {
        return chat_session;
    }

    public void setChat_session(String chat_session) {
        this.chat_session = chat_session;
    }

    public String getChat_user_id_from() {
        return chat_user_id_from;
    }

    public void setChat_user_id_from(String chat_user_id_from) {
        this.chat_user_id_from = chat_user_id_from;
    }

    public String getChat_user_id_to() {
        return chat_user_id_to;
    }

    public void setChat_user_id_to(String chat_user_id_to) {
        this.chat_user_id_to = chat_user_id_to;
    }

    public String getChat_text() {
        return chat_text;
    }

    public void setChat_text(String chat_text) {
        this.chat_text = chat_text;
    }

    public String getChat_type() {
        return chat_type;
    }

    public void setChat_type(String chat_type) {
        this.chat_type = chat_type;
    }

    /**
     *
     */
    public Chatformbean() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping The ActionMapping used to select this instance.
     * @param request The HTTP Request we are processing.
     * @return
     */
    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();
        if (getChat_type() == null || getChat_type().length() < 1) {
            errors.add("name", new ActionMessage("error.name.required"));
            // TODO: add 'error.name.required' key to your resources
        }
        return errors;
    }
}

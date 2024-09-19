/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import model.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import util.GoogleConstant;

/**
 *
 * @author HELLO
 */
public class GoogleLogin {

    public String getToken(String code) throws ClientProtocolException, IOException {
        //Validate google login with code
        String response = Request.Post(GoogleConstant.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", GoogleConstant.GOOGLE_CLIENT_ID)
                                .add("client_secret", GoogleConstant.GOOGLE_CLIENT_SECRET)
                                .add("redirect_uri", GoogleConstant.GOOGLE_REDIRECT_URI)
                                .add("code", code)
                                .add("grant_type", GoogleConstant.GOOGLE_GRANT_TYPE)
                                .build()
                )
                .execute().returnContent().asString();
        //Initiate Json object from data Google return(Gson)
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        //return accessToken for getting user profile through google API
        return accessToken;
    }

    //Get user data of that Google account (name, email, picture, etc)
    public User getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = GoogleConstant.GOOGLE_LINK_GET_USER_INFO + accessToken;
        try {
            String response = Request.Get(link).execute().returnContent().asString();
            JsonObject googleProfile = JsonParser.parseString(response).getAsJsonObject();
            return createUserFromGoogleData(googleProfile);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            throw new IOException("Failed to get user info from Google", e);
        }
    }

    private static User createUserFromGoogleData(JsonObject googleUserData) {
        User user = new User();
        if (googleUserData.has("given_name")) {
            user.setFirst_name(googleUserData.get("given_name").getAsString());
        }
        if (googleUserData.has("family_name")) {
            user.setLast_name(googleUserData.get("family_name").getAsString());
        }
        if (googleUserData.has("email")) {
            user.setEmail(googleUserData.get("email").getAsString());
        }
        user.setProfile_pic("default_avt.jpg");
        user.setPassword(null);
        return user;
    }
}

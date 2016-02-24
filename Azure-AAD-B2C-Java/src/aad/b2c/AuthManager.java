package aad.b2c;

import com.nimbusds.jwt.SignedJWT;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.Enumeration;

public class AuthManager {

    private static final String signinPolicy  = "B2C_1_signinjava2";
    private static final String signupPolicy  = "B2C_1_signupjava2";
    private static final String editprofilePolicy  = "B2C_1_editjava2";

    private final String aadUri;

    public AuthManager(String tenant, String clientId, String redirectUri){

        this.aadUri = "https://login.microsoftonline.com/"
                    + tenant
                    + ".onmicrosoft.com"
                    + "/oauth2/v2.0/authorize?"
                    + "client_id="
                    + clientId
                    + "&response_type=code+id_token"
                    + "&redirect_uri="
                    + URLEncoder.encode(redirectUri)
                    + "&response_mode=form_post"
                    + "&scope=openid%20offline_access"
                    + "&state=arbitrary_data_you_can_receive_in_the_response"
                    + "&nonce=12345"
                    + "&p=";
            }

    private String id_token = "";
    private String code = "";
    private SignedJWT Jwt;

    public void Load(HttpServletRequest request){
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            Enumeration paramNames = request.getParameterNames();

            while(paramNames.hasMoreElements()) {
                String paramName = (String)paramNames.nextElement();
                if(paramName.equalsIgnoreCase("id_token")){
                    id_token = request.getParameter(paramName);
                }else if(paramName.equalsIgnoreCase("code")){
                    code = request.getParameter(paramName);
                }
            }

            if(!id_token.isEmpty()) {
                try {
                    Jwt = SignedJWT.parse(id_token);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public Boolean IsSignedSin()
    {
        return id_token != null && !id_token.isEmpty();
    }

    public String getSignInUri()
    {
        return this.aadUri + signinPolicy;
    }
    public String getSignUpUri()
    {
        return this.aadUri + signupPolicy;
    }
    public String getEditProfileUri()
    {
        return this.aadUri + editprofilePolicy;
    }

    public String getJwtJson()
    {
        try {
            if(Jwt == null){
                return "";
            }

            return Jwt.getJWTClaimsSet().toJSONObject().toJSONString();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return "";
    }
}
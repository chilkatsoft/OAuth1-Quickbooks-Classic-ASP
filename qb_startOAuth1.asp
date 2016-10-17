<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Start Quickbooks OAuth1.0a</title>
</head>

<body>

<%
    ' IMPORTANT: This sample code requires the Chilkat ActiveX, version 9.5.0.62 or greater.
    ' At this time, Chilkat v9.5.0.62 is a pre-release and can be downloaded here:
	' 32-bit Download: http://chilkatdownload.com/prerelease/chilkatax-9.5.0-win32.zip
	' 64-bit Download: http://chilkatdownload.com/prerelease/chilkatax-9.5.0-x64.zip
	
	Session("consumerKey") = "QUICKBOOKS-CONSUMER-KEY"
	Session("consumerSecret") = "QUICKBOOKS-CONSUMER-SECRET"
	Session("oauthCallback") = "http://localhost/qb_finishOAuth1.asp"
	Session("chilkatUnlockCode") = "Anything for 30-day trial"
	
	set http = Server.CreateObject("Chilkat_9_5_0.Http")

	success = http.UnlockComponent(Session("chilkatUnlockCode"))
	If (success <> 1) Then
	    Response.Write "<pre>" & Server.HTMLEncode( http.LastErrorText) & "</pre>"
	End If


	http.OAuth1 = 1
	http.OAuthConsumerKey = Session("consumerKey")
	http.OAuthConsumerSecret = Session("consumerSecret")
	http.OAuthCallback = Session("oauthCallback")

	set req = Server.CreateObject("Chilkat_9_5_0.HttpRequest")
    set resp = http.PostUrlEncoded("https://oauth.intuit.com/oauth/v1/get_request_token", req)
	If (resp Is Nothing ) Then
	    Response.Write "<pre>" & Server.HTMLEncode( http.LastErrorText) & "</pre>"
	ElseIf (resp.StatusCode = 200) Then
		' Success
		set hashTab = Server.CreateObject("Chilkat_9_5_0.Hashtable")
		hashTab.AddQueryParams(resp.BodyStr)
		'Response.Write "BodyStr: [" & resp.BodyStr & "]<p>"
        Session("oauth_token") = hashTab.LookupStr("oauth_token")
        Session("oauth_token_secret") = hashTab.LookupStr("oauth_token_secret")
		'Response.Write "oauth_token: [" & Session("oauth_token") & "]<p>"
		'Response.Write "oauth_token_secret: [" & Session("oauth_token_secret") & "]<p>"

	    Response.Redirect "https://appcenter.intuit.com/Connect/Begin?oauth_token=" + Session("oauth_token")
	Else
	    Response.Write "<pre>" & Server.HTMLEncode( http.LastErrorText) & "</pre>"
	End If

%>


</body>
</html>

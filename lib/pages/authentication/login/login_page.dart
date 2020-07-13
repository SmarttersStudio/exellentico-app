import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/config/social_sign_in_config.dart';
import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_linkedin/linkedloginflutter.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/14/2020 3:42 AM
///


class LoginPage extends StatefulWidget {
    static final routeName = '/loginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final _formKey = GlobalKey<FormState>();
    FocusNode _mailIdFocusNode;
    bool _isVisible = false;
    String emailId = "",
        password = "";
    bool _isSocialMediaButtonDisabled = false;

    static final TwitterLogin twitterLogin = TwitterLogin(
        consumerKey: SignInWithTwitterConfig.consumerKey,
        consumerSecret: SignInWithTwitterConfig.consumerSecret,
    );
    static final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: SignInWithGithubConfig.clientId,
        clientSecret: SignInWithGithubConfig.clientSecret,
        redirectUrl: SignInWithGithubConfig.redirectUrl
    );

    final facebookLogin = FacebookLogin();
    static final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: SignInWithGoogleConfig.clientId,
        scopes: ['email'],
    );

    void _signInTwitter() {
        setState(() => _isSocialMediaButtonDisabled = true);
        AuthHelper.handleTwitterSignIn(twitterLogin, context)
            .then((value) =>
            setState(() => _isSocialMediaButtonDisabled = false))
            .catchError(
                (err) => setState(() => _isSocialMediaButtonDisabled = false));
    }

    void _signInGithub() {
        setState(() => _isSocialMediaButtonDisabled = true);
        AuthHelper.handleGithubSignIn(gitHubSignIn, context)
            .then((value) =>
            setState(() => _isSocialMediaButtonDisabled = false))
            .catchError(
                (err) => setState(() => _isSocialMediaButtonDisabled = false));
    }

    void _signInLinkedIn() {
        setState(() => _isSocialMediaButtonDisabled = true);
        AuthHelper.handleLinkedInSignIn(context)
            .then((value) =>
            setState(() => _isSocialMediaButtonDisabled = false))
            .catchError(
                (err) => setState(() => _isSocialMediaButtonDisabled = false));
    }

    @override
    void initState() {
        LinkedInLogin.initialize(context,
            clientId: SignInWithLinkedInConfig.clientId,
            clientSecret: SignInWithLinkedInConfig.clientSecret,
            redirectUri: SignInWithLinkedInConfig.redirectUrl
        );
        super.initState();
    }

    void _signInFaceBook() {
        setState(() => _isSocialMediaButtonDisabled = true);
        AuthHelper.handleFacebookSignIn(context: context)
            .then((value) =>
            setState(() => _isSocialMediaButtonDisabled = false))
            .catchError(
                (err) => setState(() => _isSocialMediaButtonDisabled = false));
    }

    void _signInGoogle() {
        try {
            setState(() => _isSocialMediaButtonDisabled = true);
            AuthHelper.handleGoogleSignIn(
                googleSignInClient: googleSignIn, context: context)
                .then((value) =>
                setState(() => _isSocialMediaButtonDisabled = false))
                .catchError(
                    (err) => setState(() => _isSocialMediaButtonDisabled = false));
        } catch (err) {
            setState(() => _isSocialMediaButtonDisabled = true);
        }
    }

    @override
    Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
            appBar: AppBar(title: Text(S.of(context).flutterDemoHomePage),),
            body: Form(
                key: _formKey,
                child: ListView(
                    children: [
                        SizedBox(height: 30,),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 16),
                            child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                focusNode: _mailIdFocusNode,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                    emailId = value.trim();
                                    return MyFormValidators.validateMail(
                                        value.trim());
                                },
                                decoration: MyDecorations.textFieldDecoration()
                                    .copyWith(hintText: S
                                    .of(context)
                                    .email),
                            ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 16),
                            child: TextFormField(
                                textInputAction: TextInputAction.done,
                                obscureText: _isVisible ? false : true,
                                validator: (value) {
                                    password = value.trim();
                                    return MyFormValidators.validatePassword(
                                        value.trim());
                                },
                                decoration: MyDecorations.textFieldDecoration()
                                    .copyWith(
                                    hintText: S
                                        .of(context)
                                        .password,
                                    suffixIcon: IconButton(
                                        icon: Icon(_isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                            setState(() {
                                                _isVisible = !_isVisible;
                                            });
                                        })
                                ),
                            ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                            child: RaisedButton(
                                child: Text(S
                                    .of(context)
                                    .loginButton),
                                onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                        print("Form is Validated");
                                        AuthHelper.handleSignInEmail(
                                            context: context,
                                            email: emailId,
                                            password: password);
                                    }
                                }
                            ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                RaisedButton(
                                    child: Text("English"),
                                    onPressed: () {
                                        setState(() {
                                            S.load(Locale('en_IN'));
                                        });
                                    }),
                                RaisedButton(
                                    child: Text("हिन्दी"),
                                    onPressed: () {
                                        setState(() {
                                            S.load(Locale('hi_IN'));
                                        });
                                    }),
                                RaisedButton(
                                    child: Text("ଓଡିଆ"),
                                    onPressed: () {
                                        setState(() {
                                            S.load(Locale('or_IN'));
                                        });
                                    }),

                            ],
                        ),
                        SizedBox(height: 10,),
                        Center(
                            child: RaisedButton(
                                child: Text("Google Login"),
                                onPressed: _isSocialMediaButtonDisabled
                                    ? null
                                    : _signInGoogle,
                            ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                            child: RaisedButton(
                                child: Text("Facebook Login"),
                                onPressed: _isSocialMediaButtonDisabled
                                    ? null
                                    : _signInFaceBook,
                            ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                            child: RaisedButton(
                                child: Text("Twitter login"),
                                onPressed: _isSocialMediaButtonDisabled
                                    ? null
                                    : _signInTwitter
                            ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                            child: RaisedButton(
                                child: Text("Github Login"),
                                onPressed: _isSocialMediaButtonDisabled
                                    ? null
                                    : _signInGithub,
                            ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                            child: RaisedButton(
                                child: Text("LinkedIn Login"),
                                onPressed: _isSocialMediaButtonDisabled
                                    ? null
                                    : _signInLinkedIn,
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}

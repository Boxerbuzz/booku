import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Insets.xl),
          child: Form(
            child: Column(
              children: [
                VSpace(context.heightPct(.05)),
                Text(R.S.singInWelcome, style: TextStyles.h5.bold),
                VSpace.md,
                Text(
                  R.S.loginMsg,
                  style: TextStyles.body1.textHeight(1.5).semiBold,
                  textAlign: TextAlign.center,
                ),
                VSpace(context.heightPct(.08)),
                Row(
                  children: [
                    Expanded(
                      child: EvIcBtn(
                        Row(
                          children: [
                            SvgPicture.asset('google'.imgSvg,
                                width: 24, height: 24),
                            HSpace.md,
                            Text(
                              'Google',
                              style: TextStyles.button.textColor(theme.txt),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        bgColor: theme.surface,
                        padding: EdgeInsets.all(Insets.m),
                      ),
                    ),
                    HSpace.lg,
                    Expanded(
                      child: EvIcBtn(
                        Row(
                          children: [
                            SvgPicture.asset('fb'.imgSvg,
                                width: 24, height: 24),
                            HSpace.md,
                            Text(
                              'Facebook',
                              style: TextStyles.button.textColor(theme.txt),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        bgColor: theme.surface,
                        padding: EdgeInsets.all(Insets.m),
                      ),
                    ),
                  ],
                ),
                VSpace(context.heightPct(.05)),
                EvTextField(
                  label: R.S.email,
                  type: InputType.email,
                  prefixIcon: EvSvgIc(R.I.email.svgT),
                ),
                EvTextField(
                  label: R.S.password,
                  type: InputType.txt,
                  prefixIcon: EvSvgIc(R.I.lock.svgT),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      R.S.forgetPwd,
                      style: TextStyles.body1.textColor(theme.primary),
                    ).rippleClick(() {}),
                    EvSvgIc(R.I.question.svgT, size: 15),
                  ],
                ),
                VSpace.lg,
                EvPriTextBtn(R.S.signIn,
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        RouteHelper.slide(() => const SetupPreferenceScreen()),
                        (route) => false)),
                VSpace.lg,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(R.S.noAccount, style: TextStyles.body1),
                    HSpace.sm,
                    Text(
                      R.S.signUp,
                      style: TextStyles.body1.textColor(theme.primary),
                    )
                  ],
                ).rippleClick(() {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

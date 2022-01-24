import 'package:flutter/material.dart';
import 'package:booku/exports.dart';

class SetupPreferenceScreen extends StatelessWidget {
  const SetupPreferenceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Insets.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace.lg,
              EvIcBtn(
                EvSvgIc(R.I.x.svgT, color: theme.surface),
                onPressed: () {},
                bgColor: theme.primary,
                shrinkWrap: true,
                radius: Corners.s10,
              ),
              VSpace.lg,
              Text(R.S.setupPrefs, style: TextStyles.h5.textColor(theme.txt)),
              VSpace.lg,
              EvTextField(
                label: R.S.firstName,
                prefixIcon: EvSvgIc(R.I.user.svgT),
              ),
              EvTextField(
                label: R.S.lastName,
                prefixIcon: EvSvgIc(R.I.profile.svgT),
              ),
              EvPopSelect(
                options: MocksConst.genres,
                label: 'Select Genre of Books you like',
                mode: EvPopSelectMode.container,
                onChanged: (value) {},
                prefix: EvSvgIc(R.I.clipboard.svgT),
              ),
              EvLocationPicker(
                label: 'Select your location',
                prefix: EvSvgIc(R.I.location.svgT),
              ),
              EvMultiSelect(
                options: const ['Female', 'Male', 'Others'],
                selected: 'Female',
                onChanged: (value) {},
                label: 'Select Gender',
                prefix: EvSvgIc(R.I.woman.svgT),
              ),
              VSpace.lg,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EvCheckbox(
                    value: null,
                    onChanged: (value) {},
                    size: 24,
                  ).padding(top: 4),
                  HSpace.md,
                  Expanded(
                    child: Text(
                      R.S.tc,
                      style: TextStyles.body1.textHeight(1.4),
                    ),
                  ),
                ],
              ),
              VSpace.xl,
              EvPriTextBtn(
                R.S.sContinue,
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    RouteHelper.sharedAxis(() => const HomeScreen()),
                    (route) => false),
              ).center(),
              VSpace.lg,
            ],
          ),
        ),
      ),
    );
  }
}

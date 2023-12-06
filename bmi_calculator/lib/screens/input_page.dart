// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../components/constants.dart';
import '../components/round_icon_button.dart';
import '../brain/bmi_brain.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 180, weight = 50, age = 19;
  // Color maleCardColor = inactiveCardColor, femaleCardColor = inactiveCardColor;
  //gender=1 for male and 2 for female
  // void updateColor(Gender gender) {
  //   if (gender == Gender.male) {
  //     maleCardColor = maleCardColor == activeCardColor
  //         ? inactiveCardColor
  //         : activeCardColor;
  //     femaleCardColor = inactiveCardColor;
  //   } else {
  //     femaleCardColor = femaleCardColor == activeCardColor
  //         ? inactiveCardColor
  //         : activeCardColor;
  //     maleCardColor = inactiveCardColor;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: const Text(
          'BMI CALCULATOR',
          style: kLargeButtonTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top -
              AppBar().preferredSize.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        colour: selectedGender == Gender.male
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.mars,
                          text: 'MALE',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                        colour: selectedGender == Gender.female
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.venus,
                          text: 'FEMALE',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kReusableCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HEIGHT',
                        style: kLableTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$height',
                            style: kNumberTextStyle,
                          ),
                          Text('cms', style: kLableTextStyle),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Color(0xFF8D8E98),
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 15.0,
                          ),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 30.0,
                          ),
                          overlayColor: Color(0x29EB1555),
                        ),
                        child: Slider(
                          value: height.toDouble(),
                          thumbColor: kBottomContainerColor,
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          },
                          min: 100.0,
                          max: 250.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: kReusableCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Weight',
                              style: kLableTextStyle,
                            ),
                            Text(
                              weight.toString(),
                              style: kNumberTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  onPress: () {
                                    setState(
                                      () {
                                        weight--;
                                        weight = weight < 0 ? 30 : weight;
                                      },
                                    );
                                  },
                                  icon: FontAwesomeIcons.minus,
                                ),
                                SizedBox(width: 15),
                                RoundIconButton(
                                  onPress: () {
                                    setState(
                                      () {
                                        weight++;
                                      },
                                    );
                                  },
                                  icon: FontAwesomeIcons.plus,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kReusableCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AGE',
                              style: kLableTextStyle,
                            ),
                            Text(
                              age.toString(),
                              style: kNumberTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  onPress: () {
                                    setState(
                                      () {
                                        age--;
                                        age = age < 0 ? 19 : age;
                                      },
                                    );
                                  },
                                  icon: FontAwesomeIcons.minus,
                                ),
                                SizedBox(width: 15),
                                RoundIconButton(
                                  onPress: () {
                                    setState(
                                      () {
                                        age++;
                                      },
                                    );
                                  },
                                  icon: FontAwesomeIcons.plus,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  CalculatorBrain calc =
                      CalculatorBrain(weight: weight, height: height);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ResultPage(
                          bmiResult: calc.calculateBmi(),
                          interPretation: calc.getInterpretation(),
                          resultText: calc.getResult(),
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(bottom: 20.0),
                  width: double.infinity,
                  height: kBottomContainerHeight,
                  color: kBottomContainerColor,
                  child: Center(
                    child: Text(
                      'CALCULATE',
                      style: kLargeButtonTextStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {},
      // ),
    );
  }
}

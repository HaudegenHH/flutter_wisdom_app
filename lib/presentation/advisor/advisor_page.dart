import 'package:advisor_app/application/bloc/advisor_bloc.dart';
import 'package:advisor_app/presentation/advisor/widgets/advice_field.dart';
import 'package:advisor_app/presentation/advisor/widgets/custom_button.dart';
import 'package:advisor_app/presentation/advisor/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvisorPage extends StatelessWidget {
  const AdvisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Advisor",
          style: themeData.textTheme.headlineLarge,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<AdvisorBloc, AdvisorState>(
                    bloc: BlocProvider.of<AdvisorBloc>(context),
                    // bei appstart bereits advice requesten:
                    //
                    //bloc: BlocProvider.of<AdvisorBloc>(context)
                    //  ..add(AdviceRequestedEvent()),

                    // wenn sich die ui nicht immer builden soll
                    // buildWhen: (prev, curr) => prev != curr,
                    // Auch einzelne Werte sind mögl. zb: prev.value != curr.value
                    builder: (context, adviceState) {
                      if (adviceState is AdviceInitial) {
                        return Text(
                          "Your advise is waiting for you",
                          style: themeData.textTheme.headlineLarge,
                        );
                      } else if (adviceState is AdviceLoading) {
                        return CircularProgressIndicator(
                            color: themeData.colorScheme.secondary);
                      } else if (adviceState is AdviceLoaded) {
                        return AdviceField(
                          advice: adviceState.advice,
                        );
                      } else if (adviceState is AdviceError) {
                        return ErrorMessage(
                          message: adviceState.message,
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(onTap: () {
                    BlocProvider.of<AdvisorBloc>(context)
                        .add(AdviceRequestedEvent());
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

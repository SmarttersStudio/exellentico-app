import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/episode_bloc/index.dart';
import 'package:ecommerceapp/pages/courses/episodes_page/components/episode_card.dart';
import 'package:ecommerceapp/pages/video_player/video_player_page.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 6:30 AM
///
class EpisodesPage extends StatefulWidget {
  final String chapterId;
  EpisodesPage(this.chapterId);
  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {

  final ScrollController _scrollController = ScrollController();
  Razorpay _razorPay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ExellenticoSnackBar.show('Success', 'Payment Successful');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ExellenticoSnackBar.show('Failure', response.message);
  }
  
  @override
  void initState() {
    super.initState();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    EpisodeBloc().add(LoadMyEpisodesEvent(widget.chapterId));
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200) {
        EpisodeBloc().add(LoadMoreEpisodesEvent(widget.chapterId));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Episodes"),),
      body: BlocBuilder<EpisodeBloc, BaseState>(
        bloc: EpisodeBloc(),
        builder: (context, BaseState state){
          if(state is LoadingBaseState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is ErrorBaseState){
            return Center(child: Text(state.errorMessage.toString()),);
          }
          if(state is EmptyBaseState){
            return Center(child: Text("No Episodes Available"),);
          }
          if(state is EpisodeLoadedState){
            return ListView.separated(
              controller: _scrollController,
                itemCount: EpisodeBloc().episodeShouldLoadMore
                    ? EpisodeBloc().episodes.length + 1
                    : EpisodeBloc().episodes.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) =>
                    index >= EpisodeBloc().episodes.length
                        ? EpisodeBloc().episodeShouldLoadMore
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container()
                        : InkWell(
                            onTap: () {
  
                              var options = {
                                'key': 'rzp_test_UMVDA6qJJFQECa',
                                'amount': '10000',
                                'name': 'Exellentico',
                                'prefill': {
                                  'contact': SharedPreferenceHelper.user.user.phone,
                                  'email':  SharedPreferenceHelper.user.user.email,
                                },
                              };
                              
                              _razorPay.open(options);
                              
                            },
                            child: EpisodesCard(
                              data: EpisodeBloc().episodes[index],
                            )));
          }
          return Center(child: Text("Some Error Occurred "),);
        },
      ),
    );
  }
}

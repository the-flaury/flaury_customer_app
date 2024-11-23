import 'package:flaury_mobile/app/shared/app_colors.dart';
import 'package:flaury_mobile/app/shared/app_spacing.dart';
import 'package:flaury_mobile/app/shared/app_text_style.dart';
import 'package:flaury_mobile/app/shared/shared_widgets/bottom_modal.dart';
import 'package:flaury_mobile/app/shared/shared_widgets/custom_button.dart';
import 'package:flaury_mobile/app/shared/shared_widgets/dialouges.dart';
import 'package:flaury_mobile/app/shared/util/images_icons_illustration.dart';
import 'package:flaury_mobile/app/shared/util/size_config.dart';
import 'package:flaury_mobile/app/src/bookings/providers/bookings_providers.dart';
import 'package:flaury_mobile/app/src/bookings/widgets/booking_status_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingCard extends ConsumerStatefulWidget {
  final bool isBookingCompleted;
  final int index;
  const BookingCard({
    required this.index,
    this.isBookingCompleted = false,
    super.key,
  });

  @override
  ConsumerState<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends ConsumerState<BookingCard> {
  @override
  Widget build(BuildContext context) {
    var bookingState = ref.watch(remindMeToggleProvider).toggleStates;
    final isSwitched = (bookingState.length > widget.index)
        ? bookingState[widget.index] // Get the toggle state for this index
        : false;
    var toggleNotifier = ref.read(remindMeToggleProvider.notifier);
    return Container(
      padding: EdgeInsets.all(SizeConfig.fromDesignHeight(context, 10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(color: AppColors.primary)),
      child: Column(
        children: [
          // date time remind me button
          Row(
            mainAxisAlignment: widget.isBookingCompleted
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              AppTextSemiBold(
                fontSize: 14,
                text: 'Jan 14, 2024-10:0 AM',
              ),
              if (!widget.isBookingCompleted)
                AppTextSemiBold(
                  fontSize: 14,
                  text: 'Remind me',
                ),
              if (!widget.isBookingCompleted)
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                      activeColor: AppColors.primary,
                      trackColor: const Color.fromRGBO(152, 163, 169, 1),
                      value: isSwitched,
                      onChanged: (bool value) {
                        toggleNotifier.toggleSwitch(widget.index, value);

                        if (value) {
                          // "remind me" logic
                          debugPrint('You have been reminded of your booking');
                        }
                      }),
                )
            ],
          ),

          const Divider(color: AppColors.grey),
          const AppSpacing(v: 12),
          Row(children: [
            //image
            Container(
              width: SizeConfig.fromDesignWidth(context, 150),
              height: SizeConfig.fromDesignHeight(context, 89),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: AssetImage(
                        img2,
                      ),
                      fit: BoxFit.cover)),
            ),
            const AppSpacing(
              h: 9,
            ),
            // salon name service type adderess
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextBold(text: 'Timeless salon', fontSize: 18),
                AppTextSemiBold(text: 'idan hills', fontSize: 14),
                AppTextSemiBold(
                  text: 'This is a placeholder',
                  fontSize: 12,
                )
              ],
            )
          ]),
          const AppSpacing(v: 12),

          const Divider(color: AppColors.grey),
          const AppSpacing(v: 10),

          widget.isBookingCompleted
              ?
              // button when booking is completed
              InkWell(
                  onTap: () {
                    //logic  view receipt
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: AppColors.white),
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.fromDesignHeight(context, 10),
                        horizontal: SizeConfig.fromDesignWidth(context, 100)),
                    child: AppTextSemiBold(
                      text: 'View receipt',
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                )
              :
              // this is the row of button that showup when
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BookingButton(
                      isWhiteButton: true,
                      label: 'Cancel booking',
                      ontap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) =>
                                CustomModal(size: 'ultra small', children: [
                                  const AppSpacing(v: 10),
                                  const ModalToggle(),
                                  const AppSpacing(v: 10),
                                  Center(
                                      child: AppTextBold(
                                    fontSize: 20,
                                    text: 'Cancel Booking',
                                    color: AppColors.primary,
                                  )),
                                  const AppSpacing(v: 39),
                                  Center(
                                      child: AppTextBold(
                                    text:
                                        'Are you sure you want to cancel your booking?',
                                    fontSize: 20,
                                    textAlign: TextAlign.center,
                                  )),
                                  const AppSpacing(v: 51),

                                  // cancel continue booking buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CancelBooking(
                                          isCancelButton: true,
                                          label: 'Cancel',
                                          ontap: () {
                                            // cancel booking logic
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    CustomAlertDialouge(
                                                        children: [
                                                          const SvgAssets(
                                                            svg: newPasswordPop,
                                                            height: 115,
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                .fromDesignHeight(
                                                                    context,
                                                                    24),
                                                          ), //ap
                                                          Center(
                                                            child: AppTextBold(
                                                              text:
                                                                  'Successful!',
                                                              fontSize: 18,
                                                              color: AppColors
                                                                  .primary,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                .fromDesignHeight(
                                                                    context,
                                                                    18),
                                                          ), //ap

                                                          AppTextRegular(
                                                              text:
                                                                  'You have successfully cancelled your order and we’d refund to your wallet soonest.',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontSize: 14)
                                                        ]));
                                          }),
                                      CancelBooking(
                                          label: 'Continue Booking',
                                          ontap: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  )
                                ]));
                      },
                    ),
                    BookingButton(
                        label: 'View receipt',
                        ontap: () {
                          // logic to view receipt
                        }),
                  ],
                ),

          const AppSpacing(v: 10),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/core/data/requests/send_answers_request.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/app_routes.dart';
import '/features/tokens/model/models/department_questions_model.dart';
import '/features/tokens/model/repository/tokens_repository.dart';
import '/features/tokens/model/repository/tokens_repository_impl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'tokens/token_button_widget.dart';
import 'tokens_dialog_header_widget.dart';

class TokenRatingDialog extends StatefulWidget {
  const TokenRatingDialog({
    super.key,
    required this.tokenNumber,
    required this.tokenId,
    required this.depId,
    required this.slotId,
  });
  final int tokenNumber;
  final int tokenId;
  final int depId;
  final int slotId;

  @override
  State<TokenRatingDialog> createState() => _TokenRatingDialogState();
}

class _TokenRatingDialogState extends State<TokenRatingDialog> {
  DepartmentQuestionsModel _questions = const DepartmentQuestionsModel(
    departmentQuestions: [],
  );
  double _rating = 0.0;
  final TokensRepository _questionsService = TokensRepositoryImpl();
  bool _submitLoading = false;
  bool _questionsLoading = false;

  @override
  void initState() {
    _getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: _questionsLoading || _submitLoading
          ? SizedBox(
              width: 100.w,
              height: 40.h,
              child: Container(
                width: 100.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : SizedBox(
              width: 100.w,
              height: 60.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TokensDialogHeaderWidget(
                    title: AppStrings.rateService.tr,
                  ),
                  const Divider(
                    color: kBorderColor,
                    thickness: 0.5,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: RatingBar.builder(
                            initialRating: 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: kPrimaryColor,
                            ),
                            onRatingUpdate: (rating) {
                              log(rating.toString());
                              _rating = rating;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        _buildQuestions(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 2.h,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TokenButtonWidget(
                            text: AppStrings.submit.tr,
                            onPressed: () {
                              _sendAnswers();
                            },
                            color: kPrimaryColor,
                            width: 15.w,
                          ),
                          SizedBox(width: 3.w),
                          TokenButtonWidget(
                            text: AppStrings.skip.tr,
                            onPressed: () {
                              Get.offAllNamed(AppRoutes.homeLayoutPath);
                            },
                            color: kWhiteColor,
                            width: 15.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _getQuestions() async {
    setState(() {
      _questionsLoading = true;
    });
    final result = await _questionsService.getDepartmentQuestions(
      depId: widget.depId.toString(),
    );

    result.fold(
      (l) {
        log(l.toString());
        AppSnackBars.showErrorSnackBar(
          message: l.message,
          title: AppStrings.error.tr,
        );
        setState(() {
          _questionsLoading = false;
        });
      },
      (r) {
        setState(() {
          _questionsLoading = false;
          _questions = r;
        });
      },
    );
  }

  _sendAnswers() async {
    setState(() {
      _submitLoading = true;
    });
    final result = await _questionsService.sendAnswers(
      answers: [
        for (var question in _questions.departmentQuestions)
          if (question.textEditingController.text.isNotEmpty)
            SendAnswersRequest(
              answerText: question.textEditingController.text,
              question: Question(
                id: question.id,
              ),
            )
      ],
    );

    result.fold(
      (l) {
        log(l.toString());
        AppSnackBars.showErrorSnackBar(
          message: l.message,
          title: AppStrings.error.tr,
        );
        setState(() {
          _submitLoading = false;
        });
      },
      (r) {
        if (r == 1) {
          _submitRate();
        } else {
          AppSnackBars.showErrorSnackBar(
            message: AppStrings.error.tr,
            title: AppStrings.error.tr,
          );
        }
      },
    );
  }

  _submitRate() async {
    final result = await _questionsService.rateService(
      tokenNumber: widget.tokenNumber,
      tokenId: widget.tokenId,
      depId: widget.depId,
      slotId: widget.slotId,
      rating: _rating.toInt(),
    );

    result.fold(
      (l) {
        log(l.toString());
        AppSnackBars.showErrorSnackBar(
          message: l.message,
          title: AppStrings.error.tr,
        );
        setState(() {
          _submitLoading = false;
        });
      },
      (r) {
        setState(() {
          _submitLoading = false;
        });
        if (r == 1) {
          Get.offAllNamed(AppRoutes.homeLayoutPath);
        } else {
          AppSnackBars.showErrorSnackBar(
            message: AppStrings.error.tr,
            title: AppStrings.error.tr,
          );
        }
      },
    );
  }

  _buildQuestions() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      itemCount: _questions.departmentQuestions.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _questions.departmentQuestions[index].questionText,
              style: context.textTheme.titleSmall,
            ),
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.w),
                color: kTextFieldFillColor,
              ),
              clipBehavior: Clip.antiAlias,
              child: TextFormField(
                controller:
                    _questions.departmentQuestions[index].textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.question_answer,
                    color: kIconLightColor,
                  ),
                  filled: true,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: AppStrings.answerToTheQuestion.tr,
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 2.h,
        );
      },
    );
  }
}

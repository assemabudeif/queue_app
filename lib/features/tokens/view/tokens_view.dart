import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/services/services_locator.dart';
import '/features/tokens/view_model/tokens_cubit.dart';

import 'widgets/tokens/tokens_list_widget.dart';

class TokensView extends StatefulWidget {
  const TokensView({super.key});

  @override
  State<TokensView> createState() => _TokensViewState();
}

class _TokensViewState extends State<TokensView> {
  final TokensCubit _vm = sl<TokensCubit>();

  @override
  void initState() {
    _vm.init();
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => _vm,
        child: RefreshIndicator(
          onRefresh: () async {
            _vm.refreshTokensView();
          },
          child: TokensListWidget(vm: _vm),
        ),
      ),
    );
  }
}

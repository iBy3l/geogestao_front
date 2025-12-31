import 'package:flutter/material.dart';

import '/core/core.dart';

class BaseBuilder<C extends BaseController<S>, S> extends StatefulWidget {
  const BaseBuilder({super.key, required this.controller, this.buildLoading, this.buildError, required this.build});

  final C controller;

  final Widget Function(BuildContext, LoadingBaseState)? buildLoading;

  final Widget Function(BuildContext, ErrorBaseState)? buildError;

  final Widget Function(BuildContext, S) build;

  @override
  BaseBuilderState<C, S> createState() => BaseBuilderState<C, S>();
}

class BaseBuilderState<C extends BaseController<S>, S> extends State<BaseBuilder<C, S>> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<S>(
      valueListenable: widget.controller,
      builder: (context, state, child) {
        if (state is LoadingBaseState) {
          if (widget.buildLoading != null) {
            return widget.build(context, state);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        } else if (state is ErrorBaseState) {
          if (widget.buildError != null) {
            final widgetDeErro = widget.buildError?.call(context, state);
            return widgetDeErro ?? widget.build(context, state);
          } else {
            widget.controller.errorMessage(context, state.message);
            return widget.build(context, state);
          }
        } else if (state is SuccessBaseState) {
          return widget.build(context, state);
        }
        return widget.build(context, state);
      },
    );
  }
}

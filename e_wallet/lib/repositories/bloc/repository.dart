import 'package:e_wallet/repositories/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api.dart';
import '../api/api_impl.dart';
import '../log/log.dart';

class Repository extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Api>(
      // create: (context) => ApiServerImpl(context.read<Log>()),
      create: (context) => ApiImpl(context.read<Log>()),
      child: Provider(),
    );
  }
}

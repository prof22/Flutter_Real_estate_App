// import 'package:flutter/material.dart';
// import 'package:real_estate_app/widget/app.dart';

// void main() => runApp(App());

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:flutter/material.dart';
// import 'package:real_estate_app/bloc/properties_bloc.dart';
// import 'package:real_estate_app/widget/app.dart';

// void main() => runApp(
//   BlocProvider(
//         blocs: [
//           Bloc((i) => FeaturedPropertiesBloc()),
//           Bloc((j) => AllPropertiesImageBloc()),
//           Bloc((k) => AllPropertiesBloc()),
//           Bloc((l) => AllPropertiesListBloc()),
//           Bloc((m) => PropertySliderBloc()),
//       ],
//     child: App(),

//   )
// );

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/widget/app.dart';
import './controller/properties_provider.dart';
import 'controller/agent_detail_provider.dart';


void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PropertiesProvider()),
      ChangeNotifierProvider(create: (_) => AgentDetailsProvider()),
    ],
    child: App())
    
  );

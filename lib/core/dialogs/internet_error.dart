import 'package:flutter/material.dart';

import 'generic_dialogue.dart';

Future<void> showInternetError(BuildContext context) async {
  return await showGenericDialog(
    context: context,
    title: "Pas de connexion internet",
    content:
        "Votre connexion internet n'est pas disponible actuellement, veuillez vérifier ou réessayer.",
    optionBuilder: () => {'Réessayer': 'NoInternet'},
  );
}

import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
getData() async {
  print(supabase.authUrl);
  print(supabase.schema);
  final data = await supabase.from('structure').select('*');

  print(data);
  final datas = await supabase.from('filiere').select('nom');
  print(datas);

  print(datas.toString());
}

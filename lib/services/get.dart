import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
getData() async {
  print(supabase.authUrl);
  print(supabase.schema);
  final data = await supabase.from('structure').select('*');
  print(data);
  print(data.toString());
}

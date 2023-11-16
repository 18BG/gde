import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  var _db = Supabase.instance.client;

  String fl = 'filiere';
  Future<dynamic> getFiliere() async {
    print("-----------");
    final data = await _db.from(fl).select('*');
    print(data);

    return data;
  }
}

//  final _stream = Supabase.instance.client
//       .from('structure')
//       .stream(primaryKey: ['structure_id']);

// lib/get_stream_io.dart
/// `stream_feed_unofficial` Introducing the unofficial library with clean code architecture
/// and supporting latest Flutter release
library stream_feed_unofficial;

// Models & Entities
export 'package:stream_feed_unofficial/src/data/activity/models/feed_id_model.dart';
export 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';
export 'package:stream_feed_unofficial/src/domain/activity/usecases/add_activity_usecase.dart';
export 'package:stream_feed_unofficial/src/domain/activity/usecases/fetch_activity_usecase.dart';
export 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
export 'package:stream_feed_unofficial/src/domain/core/usecases/auth_usecase.dart';
export 'package:stream_feed_unofficial/src/domain/follow/usecases/global_user_follows_current_user_usecase.dart';
export 'package:stream_feed_unofficial/src/domain/login/usecases/login_usecase.dart';
export 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';
export 'package:stream_feed_unofficial/src/domain/open_graph/usecases/open_graph_usecase.dart';
// Usecases
export 'package:stream_feed_unofficial/src/domain/signup/usecases/signup_usecase.dart';
export 'package:stream_feed_unofficial/src/presentation/activity/activity_list_screen.dart';

// Components
export 'package:stream_feed_unofficial/src/presentation/core/common_components/app_primary_button.dart';
// Screens
export 'package:stream_feed_unofficial/src/presentation/login/login_screen.dart';

// Main entry file that includes configuration and initialization methods
export 'src/stream_feed_unofficial.dart';

// Utils

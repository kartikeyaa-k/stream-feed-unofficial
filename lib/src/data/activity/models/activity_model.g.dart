// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      actor: json['actor'] as String?,
      verb: json['verb'] as String?,
      object: json['object'] as String?,
      id: json['id'] as String?,
      foreignId: json['foreignId'] as String?,
      target: json['target'] as String?,
      time: const DateTimeUTCConverter().fromJson(json['time'] as String?),
      to: FeedId.fromIds(json['to'] as List?),
      analytics: (json['analytics'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
      extraContext: (json['extraContext'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
      origin: json['origin'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      extraData: json['extra_data'] as Map<String, dynamic>?,
      message: json['message'] as String?,
      reactionCounts: (json['reaction_counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      latestReactions: (json['latest_reactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as List<dynamic>),
      ),
      latestReactionsExtra:
          json['latest_reactions_extra'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'actor': instance.actor,
    'verb': instance.verb,
    'object': instance.object,
    'foreignId': instance.foreignId,
    'target': instance.target,
    'time': const DateTimeUTCConverter().toJson(instance.time),
    'origin': instance.origin,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('to', FeedId.toIds(instance.to));
  val['score'] = instance.score;
  val['analytics'] = instance.analytics;
  val['extraContext'] = instance.extraContext;
  val['extra_data'] = instance.extraData;
  val['message'] = instance.message;
  val['reaction_counts'] = instance.reactionCounts;
  val['latest_reactions'] = instance.latestReactions;
  val['latest_reactions_extra'] = instance.latestReactionsExtra;
  return val;
}

import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int? id; // comment_id_type
  final int? post_id;
  final String category;
  final String parent_author; // account_name_type
  final String parent_permlink;
  final String author; // account_name_type
  final String permlink;
  final String title;
  final String body;
  final String json_metadata;
  final String last_update; // time_point_sec
  final String created; // time_point_sec
  final String? active; // time_point_sec
  final String last_payout; // time_point_sec
  final int depth; // uint8_t
  final int children; // uint32_t
  final dynamic net_rshares; // share_type
  final dynamic abs_rshares; // share_type
  final dynamic vote_rshares; // share_type
  final dynamic children_abs_rshares; // share_type
  final String cashout_time; // time_point_sec
  final String? max_cashout_time; // time_point_sec
  final int? total_vote_weight; // uint64_t
  final int? reward_weight; // uint16_t
  final String total_payout_value;
  final String curator_payout_value;
  final dynamic author_rewards; // share_type
  final int? net_votes; // int32_t
  final int? root_comment; // comment_id_type
  final String max_accepted_payout; // asset
  final int percent_steem_dollars; // uint16_t
  final bool? allow_replies;
  final bool? allow_votes;
  final bool? allow_curation_rewards;
  final List<BeneficiaryRoute> beneficiaries;

  Comment({
    this.id,
    this.post_id,
    required this.category,
    required this.parent_author,
    required this.parent_permlink,
    required this.author,
    required this.permlink,
    required this.title,
    required this.body,
    required this.json_metadata,
    required this.last_update,
    required this.created,
    this.active,
    required this.last_payout,
    required this.depth,
    required this.children,
    required this.net_rshares,
    required this.abs_rshares,
    required this.vote_rshares,
    required this.children_abs_rshares,
    required this.cashout_time,
    this.max_cashout_time,
    this.total_vote_weight,
    this.reward_weight,
    required this.total_payout_value,
    required this.curator_payout_value,
    this.author_rewards,
    this.net_votes,
    this.root_comment,
    required this.max_accepted_payout,
    required this.percent_steem_dollars,
    this.allow_replies,
    this.allow_votes,
    this.allow_curation_rewards,
    required this.beneficiaries,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class Discussion extends Comment {
  final String url; // /category/@rootauthor/root_permlink#author/permlink
  final String root_title;
  final String pending_payout_value;
  final String? total_pending_payout_value;
  final List<dynamic>? active_votes; // vote_state[]
  final List<String> replies;

  /// author/slug mapping
  final int author_reputation; // share_type
  final String promoted;
  final int body_length; // Bignum
  final List<dynamic>? reblogged_by; // account_name_type[]
  final dynamic first_reblogged_by; // account_name_type
  final dynamic first_reblogged_on; // time_point_sec

  Discussion({
    required this.url,
    required this.root_title,
    required this.pending_payout_value,
    this.total_pending_payout_value,
    required this.active_votes,
    required this.replies,
    required this.author_reputation,
    required this.promoted,
    required this.body_length,
    this.reblogged_by,
    this.first_reblogged_by,
    this.first_reblogged_on,
    id,
    post_id,
    category,
    parent_author,
    parent_permlink,
    author,
    permlink,
    title,
    body,
    json_metadata,
    last_update,
    created,
    active,
    last_payout,
    depth,
    children,
    net_rshares,
    abs_rshares,
    vote_rshares,
    children_abs_rshares,
    cashout_time,
    max_cashout_time,
    total_vote_weight,
    reward_weight,
    total_payout_value,
    curator_payout_value,
    author_rewards,
    net_votes,
    root_comment,
    max_accepted_payout,
    percent_steem_dollars,
    allow_replies,
    allow_votes,
    allow_curation_rewards,
    required List<BeneficiaryRoute> beneficiaries,
  }) : super(
          id: id,
          post_id: post_id,
          category: category,
          parent_author: parent_author,
          parent_permlink: parent_permlink,
          author: author,
          permlink: permlink,
          title: title,
          body: body,
          json_metadata: json_metadata,
          last_update: last_update,
          created: created,
          active: active,
          last_payout: last_payout,
          depth: depth,
          children: children,
          net_rshares: net_rshares,
          abs_rshares: abs_rshares,
          vote_rshares: vote_rshares,
          children_abs_rshares: children_abs_rshares,
          cashout_time: cashout_time,
          max_cashout_time: max_cashout_time,
          total_vote_weight: total_vote_weight,
          reward_weight: reward_weight,
          total_payout_value: total_payout_value,
          curator_payout_value: curator_payout_value,
          author_rewards: author_rewards,
          net_votes: net_votes,
          root_comment: root_comment,
          max_accepted_payout: max_accepted_payout,
          percent_steem_dollars: percent_steem_dollars,
          allow_replies: allow_replies,
          allow_votes: allow_votes,
          allow_curation_rewards: allow_curation_rewards,
          beneficiaries: beneficiaries,
        );

  factory Discussion.fromJson(Map<String, dynamic> json) =>
      _$DiscussionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DiscussionToJson(this);
}

@JsonSerializable()
class BeneficiaryRoute {
  final String account;
  final int weight;

  BeneficiaryRoute({
    required this.account,
    required this.weight,
  });

  factory BeneficiaryRoute.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryRouteFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryRouteToJson(this);
}

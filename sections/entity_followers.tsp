using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/subscriptions-api
// Section: Entity followers

/** Manage entity followers (subscriptions). */
@route("/api/v4/{entity_type}/{entity_id}/followers")
interface EntityFollowers {
  /** Get followers list. */
  @get
  list(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @query page?: int32,
    @query limit?: int32,
  ): EntityFollowerListResponse | Problem;

  /** Add followers. */
  @post
  add(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @body body: EntityFollowerCreateItem[],
  ): EntityFollowerCreateResponse | Problem;

  /** Remove followers. */
  @delete
  remove(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @body body: EntityFollowerDeleteItem[],
  ): EmptyResponse | Problem;
}

model EntityFollower {
  id?: int64;
  user_id?: int64;
  created_by?: int64;
  created_at?: int64;
}

model EntityFollowerListResponse {
  _total_items?: int32;
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    followers?: EntityFollower[];
  };
}

model EntityFollowerCreateItem {
  user_id: int64;
}

model EntityFollowerCreateResult {
  user_id?: int64;
}

model EntityFollowerCreateResponse {
  _total_items?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    followers?: EntityFollowerCreateResult[];
  };
}

model EntityFollowerDeleteItem {
  user_id: int64;
}

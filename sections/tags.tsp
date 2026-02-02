using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/tags-api
// Section: Tags

/** Methods for working with tags for entities. */
@route("/api/v4/{entity_type}/tags")
interface Tags {
  /** Get tags list. */
  @get
  list(
    @path entity_type: EntityLinkType,
    @query page?: int32,
    @query limit?: int32,
    @query query?: string,
    @query filter?: Record<unknown>,
  ): TagListResponse | Problem;

  /** Create tags. */
  @post
  create(
    @path entity_type: EntityLinkType,
    @body body: TagCreate[],
  ): TagCreateResponse | Problem;
}

model TagCreate {
  name: string;
  color?: string;
  request_id?: string;
}

model TagListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    tags?: Tag[];
  };
}

model TagCreateResult {
  id?: int64;
  name?: string;
  color?: string;
  request_id?: string;
}

model TagCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    tags?: TagCreateResult[];
  };
}

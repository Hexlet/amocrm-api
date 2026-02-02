using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/entity-links-api
// Section: Entity links

union EntityLinkType {
  "leads",
  "contacts",
  "companies",
  "customers",
}

model EntityLinkItem {
  entity_id?: int64;
  entity_type?: EntityLinkType | string;
  to_entity_id?: int64;
  to_entity_type?: EntityLinkType | string;
  metadata?: Record<unknown>;
}

model EntityLinksResponse {
  _links?: Record<unknown>;
  _embedded?: {
    links?: EntityLinkItem[];
  };
}

/** Methods for linking entities. */
@route("/api/v4/{entity_type}")
interface EntityLinks {
  /** Get list of linked entities (bulk). */
  @get
  @route("/links")
  list(
    @path entity_type: EntityLinkType,
    @query filter?: Record<unknown>,
  ): EntityLinksResponse | Problem;

  /** Get links for a specific entity. */
  @get
  @route("/{entity_id}/links")
  listByEntity(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
  ): EntityLinksResponse | Problem;

  /** Link entities (bulk). */
  @post
  @route("/link")
  link(
    @path entity_type: EntityLinkType,
    @body body: EntityLinkItem[],
  ): EmptyResponse | Problem;

  /** Unlink entities (bulk). */
  @post
  @route("/unlink")
  unlink(
    @path entity_type: EntityLinkType,
    @body body: EntityLinkItem[],
  ): EmptyResponse | Problem;

  /** Link entities for a specific entity. */
  @post
  @route("/{entity_id}/link")
  linkByEntity(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @body body: EntityLinkItem[],
  ): EmptyResponse | Problem;

  /** Unlink entities for a specific entity. */
  @post
  @route("/{entity_id}/unlink")
  unlinkByEntity(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @body body: EntityLinkItem[],
  ): EmptyResponse | Problem;
}

model EmptyResponse {
  _links?: Record<unknown>;
  _embedded?: Record<unknown>;
}

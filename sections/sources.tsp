using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/sources-api
// Section: Sources

/** Sources management. */
@route("/api/v4/sources")
interface Sources {
  /** Get sources list. */
  @get
  list(
    @query filter?: {
      external_id?: string | int64 | boolean | (string | int64 | boolean)[];
    },
  ): SourceListResponse | Problem;

  /** Get source by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
  ): Source | Problem;

  /** Create sources (batch). */
  @post
  create(
    @body body: SourceCreateItem[],
  ): SourceCreateResponse | Problem;

  /** Update sources (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: SourceUpdateItem[],
  ): SourceUpdateResponse | Problem;

  /** Update source by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: SourceUpdateById,
  ): SourceUpdateResponse | Problem;

  /** Delete sources (batch). */
  @delete
  delete(
    @body body: SourceDeleteItem[],
  ): EmptyResponse | Problem;

  /** Delete source by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path id: int64,
  ): EmptyResponse | Problem;
}

/** CRM Plugin (website buttons) management. */
@route("/api/v4/website_buttons")
interface WebsiteButtons {
  /** Get CRM Plugin list. */
  @get
  list(
    @query with?: string,
    @query page?: int32,
    @query limit?: int32,
  ): WebsiteButtonListResponse | Problem;

  /** Get CRM Plugin by source id. */
  @get
  @route("/{source_id}")
  getBySourceId(
    @path source_id: int64,
    @query with?: string,
  ): WebsiteButton | Problem;

  /** Create CRM Plugin. */
  @post
  create(
    @body body: WebsiteButtonCreateRequest,
  ): WebsiteButtonCreateResponse | Problem;

  /** Connect online chat to CRM Plugin. */
  @post
  @route("/{source_id}/online_chat")
  connectOnlineChat(
    @path source_id: int64,
  ): EmptyResponse | Problem;

  /** Update CRM Plugin trusted domains. */
  @patch(#{ implicitOptionality: false })
  @route("/{source_id}")
  update(
    @path source_id: int64,
    @body body: WebsiteButtonUpdateRequest,
  ): WebsiteButton | Problem;
}

model Source {
  id?: int64;
  name?: string;
  pipeline_id?: int64 | null;
  external_id?: string | int64 | boolean;
  default?: boolean;
  origin_code?: string | null;
  services?: Record<unknown>[] | string[];
  _links?: Record<unknown>;
}

model SourceListResponse {
  _total_items?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    sources?: Source[];
  };
}

model SourceCreateItem {
  name: string;
  pipeline_id?: int64 | null;
  external_id: string;
  default?: boolean;
  origin_code?: string | null;
  services?: Record<unknown>[] | string[];
  request_id?: string;
}

model SourceUpdateItem {
  id: int64;
  name?: string;
  pipeline_id?: int64 | null;
  external_id?: string;
  default?: boolean;
  origin_code?: string | null;
  services?: Record<unknown>[] | string[];
  request_id?: string;
}

model SourceUpdateById {
  name?: string;
  pipeline_id?: int64 | null;
  external_id?: string;
  default?: boolean;
  origin_code?: string | null;
  services?: Record<unknown>[] | string[];
  request_id?: string;
}

model SourceCreateResult extends Source {
  request_id?: string;
}

model SourceCreateResponse {
  _total_items?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    sources?: SourceCreateResult[];
  };
}

model SourceUpdateResult extends Source {
  request_id?: string;
}

model SourceUpdateResponse {
  _total_items?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    sources?: SourceUpdateResult[];
  };
}

model SourceDeleteItem {
  id: int64;
}

model WebsiteButton {
  account_id?: int64;
  source_id?: int64;
  button_id?: int64;
  is_duplication_control_enabled?: boolean;
  name?: string;
  creation_status?: string;
  pipeline_id?: int64 | null;
  script?: string | null;
}

model WebsiteButtonListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    website_buttons?: WebsiteButton[];
  };
}

model WebsiteButtonCreateRequest {
  pipeline_id: int64;
  trusted_websites?: string[];
  is_used_in_app?: boolean;
}

model WebsiteButtonCreateResponse {
  source_id?: int64;
  trusted_websites?: string[];
}

model WebsiteButtonUpdateRequest {
  trusted_websites: {
    add: string[];
  };
}

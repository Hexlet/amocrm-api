using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/leads_pipelines
// Section: Pipelines and statuses

/** Pipelines (lead pipelines) and their statuses. */
@route("/api/v4/leads/pipelines")
interface Pipelines {
  /** Get pipelines list. */
  @get
  list(): PipelineListResponse | Problem;

  /** Get pipeline by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
  ): Pipeline | Problem;

  /** Create pipelines. */
  @post
  create(
    @body body: PipelineCreateItem[],
  ): PipelineCreateResponse | Problem;

  /** Update pipelines (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: PipelineUpdateItem[],
  ): PipelineUpdateResponse | Problem;

  /** Update pipeline by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: PipelineUpdateById,
  ): PipelineUpdateResponse | Problem;

  /** Delete pipeline by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path id: int64,
  ): EmptyResponse | Problem;
}

/** Pipeline statuses. */
@route("/api/v4/leads/pipelines/{pipeline_id}/statuses")
interface PipelineStatuses {
  /** Get statuses for a pipeline. */
  @get
  list(
    @path pipeline_id: int64,
    /** Expand related entities; comma-separated values (e.g. descriptions). */
    @query with?: string,
  ): StatusListResponse | Problem;

  /** Get status by id. */
  @get
  @route("/{id}")
  getById(
    @path pipeline_id: int64,
    @path id: int64,
    /** Expand related entities; comma-separated values (e.g. descriptions). */
    @query with?: string,
  ): Status | Problem;

  /** Create statuses. */
  @post
  create(
    @path pipeline_id: int64,
    @body body: StatusCreateItem[],
  ): StatusCreateResponse | Problem;

  /** Update statuses (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @path pipeline_id: int64,
    @body body: StatusUpdateItem[],
  ): StatusUpdateResponse | Problem;

  /** Update status by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path pipeline_id: int64,
    @path id: int64,
    @body body: StatusUpdateById,
  ): StatusUpdateResponse | Problem;

  /** Delete status by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path pipeline_id: int64,
    @path id: int64,
  ): EmptyResponse | Problem;
}

model StatusDescription {
  id?: int64;
  account_id?: int64;
  created_at?: int64;
  updated_at?: int64;
  created_by?: int64;
  updated_by?: int64;
  pipeline_id?: int64;
  status_id?: int64;
  level?: string;
  description?: string;
}

model Status {
  id?: int64;
  name?: string;
  sort?: int32;
  account_id?: int64;
  is_editable?: boolean;
  color?: string;
  type?: int32;
  pipeline_id?: int64;
  descriptions?: StatusDescription[] | null;
}

model PipelineEmbedded {
  statuses?: Status[];
}

model Pipeline {
  id?: int64;
  name?: string;
  sort?: int32;
  account_id?: int64;
  is_main?: boolean;
  is_unsorted_on?: boolean;
  is_archive?: boolean;
  _links?: Record<unknown>;
  _embedded?: PipelineEmbedded;
}

model PipelineListResponse {
  _links?: Record<unknown>;
  _embedded?: {
    pipelines?: Pipeline[];
  };
}

model PipelineCreateEmbedded {
  statuses?: StatusCreateItem[];
}

model PipelineCreateItem {
  name: string;
  sort?: int32;
  is_main?: boolean;
  is_unsorted_on?: boolean;
  _embedded?: PipelineCreateEmbedded;
  request_id?: string;
}

model PipelineCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model PipelineCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    pipelines?: PipelineCreateResult[];
  };
}

model PipelineUpdateItem {
  id: int64;
  name?: string;
  sort?: int32;
  is_main?: boolean;
  is_unsorted_on?: boolean;
  is_archive?: boolean;
  request_id?: string;
}

model PipelineUpdateById {
  name?: string;
  sort?: int32;
  is_main?: boolean;
  is_unsorted_on?: boolean;
  is_archive?: boolean;
  request_id?: string;
}

model PipelineUpdatedResult {
  id?: int64;
  updated_at?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model PipelineUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    pipelines?: PipelineUpdatedResult[];
  };
}

model StatusDescriptionPayload {
  id?: int64;
  level?: string;
  description?: string;
}

model StatusCreateItem {
  name: string;
  sort?: int32;
  color?: string;
  descriptions?: StatusDescriptionPayload[];
  request_id?: string;
}

model StatusUpdateItem {
  id: int64;
  name?: string;
  sort?: int32;
  color?: string;
  descriptions?: StatusDescriptionPayload[];
  request_id?: string;
}

model StatusUpdateById {
  name?: string;
  sort?: int32;
  color?: string;
  descriptions?: StatusDescriptionPayload[];
  request_id?: string;
}

model StatusListResponse {
  _links?: Record<unknown>;
  _embedded?: {
    statuses?: Status[];
  };
}

model StatusCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model StatusCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    statuses?: StatusCreateResult[];
  };
}

model StatusUpdatedResult {
  id?: int64;
  updated_at?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model StatusUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    statuses?: StatusUpdatedResult[];
  };
}

using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/customers-statuses-api
// Section: Customer statuses and segments

/** Customer statuses. */
@route("/api/v4/customers/statuses")
interface CustomerStatuses {
  /** Get statuses list. */
  @get
  list(): CustomerStatusListResponse | Problem;

  /** Get status by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
  ): CustomerStatus | Problem;

  /** Create statuses. */
  @post
  create(
    @body body: CustomerStatusCreate[],
  ): CustomerStatusCreateResponse | Problem;

  /** Update a status by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: CustomerStatusUpdateById,
  ): Record<unknown> | Problem;

  /** Delete a status by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path id: int64,
  ): Record<unknown> | Problem;
}

/** Customer segments. */
@route("/api/v4/customers/segments")
interface CustomerSegments {
  /** Get segments list. */
  @get
  list(): CustomerSegmentListResponse | Problem;

  /** Get segment by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
  ): CustomerSegment | Problem;

  /** Create segments. */
  @post
  create(
    @body body: CustomerSegmentCreate[],
  ): CustomerSegmentCreateResponse | Problem;

  /** Update a segment by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: CustomerSegmentUpdateById,
  ): Record<unknown> | Problem;

  /** Delete a segment by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path id: int64,
  ): Record<unknown> | Problem;
}

model CustomerStatus {
  id?: int64;
  name?: string;
  sort?: int32;
  color?: string;
  type?: string;
}

model CustomerStatusCreate {
  request_id?: string;
  name: string;
  sort?: int32;
  color?: string;
}

model CustomerStatusUpdateById {
  name?: string;
  sort?: int32;
  color?: string;
}

model CustomerStatusListResponse {
  _links?: Record<unknown>;
  _embedded?: {
    statuses?: CustomerStatus[];
  };
}

model CustomerStatusCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model CustomerStatusCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    statuses?: CustomerStatusCreateResult[];
  };
}

model CustomerSegment {
  id?: int64;
  name?: string;
  color?: string;
  created_at?: int64;
  updated_at?: int64;
  customers_count?: int64;
  custom_fields_values?: CustomFieldValue[] | null;
}

model CustomerSegmentCreate {
  request_id?: string;
  name: string;
  color?: string;
  custom_fields_values?: CustomFieldValue[];
}

model CustomerSegmentUpdateById {
  name?: string;
  color?: string;
  custom_fields_values?: CustomFieldValue[];
}

model CustomerSegmentListResponse {
  _links?: Record<unknown>;
  _embedded?: {
    segments?: CustomerSegment[];
  };
}

model CustomerSegmentCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model CustomerSegmentCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    segments?: CustomerSegmentCreateResult[];
  };
}

using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/leads-api
// Section: Leads

/** Methods for working with leads (deals). */
@route("/api/v4/leads")
interface Leads {
  /** Get a list of leads (pagination, sorting, filtering). */
  @get
  list(
    /** Pagination page */
    @query page?: int32,
    /** Pagination limit */
    @query limit?: int32,
    /** Search by query string or id */
    @query query?: string | int64,
    /** Expand related entities; comma-separated values */
    @query with?: string,
    /** Sorting, e.g. order[updated_at]=asc */
    @query order?: Record<unknown>,
    /** Filtering parameters, see filters API */
    @query filter?: Record<unknown>,
  ): LeadListResponse | Problem;

  /** Get a lead by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
    /** Expand related entities; comma-separated values */
    @query with?: string,
  ): Lead | Problem;

  /** Create leads. */
  @post
  create(
    @body body: LeadCreate[],
  ): LeadCreateResponse | Problem;

  /** Create leads using the complex method (supports unsorted metadata). */
  @post
  @route("/complex")
  createComplex(
    @body body: LeadCreate[],
  ): LeadComplexCreateResponse | Problem;

  /** Update leads (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: LeadUpdateItem[],
  ): LeadUpdateResponse | Problem;

  /** Update a lead by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: LeadUpdateById,
  ): LeadUpdateResponse | Problem;
}

model LeadSourceRef {
  /** External id in your system */
  external_id?: string | int32 | boolean;
  /** Source type */
  type?: string;
}

model LossReason {
  id?: int64;
  name?: string;
}

model LeadContactRef {
  id?: int64;
  is_main?: boolean;
}

model LeadCompanyRef {
  id?: int64;
}

model CatalogElementRef {
  id?: int64;
  metadata?: Record<unknown>;
}

model LeadEmbedded {
  loss_reason?: LossReason;
  tags?: Tag[];
  contacts?: LeadContactRef[];
  companies?: LeadCompanyRef[];
  catalog_elements?: CatalogElementRef[];
  source?: LeadSourceRef;
}

model Lead {
  id?: int64;
  name?: string;
  price?: int32;
  responsible_user_id?: int64;
  group_id?: int64;
  status_id?: int64;
  pipeline_id?: int64;
  loss_reason_id?: int64;
  source_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  closed_at?: int64;
  created_at?: int64;
  updated_at?: int64;
  closest_task_at?: int64;
  is_deleted?: boolean;
  custom_fields_values?: CustomFieldValue[] | null;
  score?: int32 | null;
  account_id?: int64;
  labor_cost?: int64;
  is_price_modified_by_robot?: boolean;
  visitor_uid?: string;
  _links?: Record<unknown>;
  _embedded?: LeadEmbedded;
}

model LeadUnsortedMetadata {
  /** Unsorted category */
  category?: "sip" | "forms" | "chats" | "mail";
  /** IP address of the submitter */
  ip?: string;
  /** Form id in your system (string or numeric) */
  form_id?: string | int64;
  /** Unix timestamp (seconds) when the form was submitted */
  form_sent_at?: int64;
  /** Form name (shown in amoCRM) */
  form_name?: string;
  /** Page URL where form lives */
  form_page?: string;
  /** Referrer URL */
  referer?: string;
  /** Visitor uid from tracking, if you have it */
  visitor_uid?: string;
  /** Form type code from amoCRM, use only if you know it */
  form_type?: int32;
}

model LeadCreateEmbedded {
  tags?: Tag[];
  contacts?: ContactCreate[];
  companies?: CompanyCreate[];
  metadata?: LeadUnsortedMetadata;
  source?: LeadSourceRef;
}

model LeadCreate {
  /** Client-side request id */
  request_id?: string;
  name?: string;
  price?: int32;
  responsible_user_id?: int64;
  group_id?: int64;
  status_id?: int64;
  pipeline_id?: int64;
  loss_reason_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  closed_at?: int64;
  created_at?: int64;
  updated_at?: int64;
  /** Website visitor uid from tracking; links this lead to a site visit */
  visitor_uid?: string;
  /** Custom fields payload */
  custom_fields_values?: CustomFieldValue[];
  /** Tags to attach */
  tags_to_add?: Tag[];
  /** Embedded entities (lead/contact/company/source) */
  _embedded?: LeadCreateEmbedded;
}

model LeadUpdateItem {
  /** Lead id */
  id: int64;
  name?: string;
  price?: int32;
  responsible_user_id?: int64;
  group_id?: int64;
  status_id?: int64;
  pipeline_id?: int64;
  loss_reason_id?: int64;
  closed_at?: int64;
  updated_at?: int64;
  /** Custom fields payload */
  custom_fields_values?: CustomFieldValue[];
  /** Tags to attach */
  tags_to_add?: Tag[];
  /** Tags to delete */
  tags_to_delete?: Tag[];
  _embedded?: LeadCreateEmbedded;
}

model LeadUpdateById {
  name?: string;
  price?: int32;
  responsible_user_id?: int64;
  group_id?: int64;
  status_id?: int64;
  pipeline_id?: int64;
  loss_reason_id?: int64;
  closed_at?: int64;
  updated_at?: int64;
  /** Custom fields payload */
  custom_fields_values?: CustomFieldValue[];
  /** Tags to attach */
  tags_to_add?: Tag[];
  /** Tags to delete */
  tags_to_delete?: Tag[];
  _embedded?: LeadCreateEmbedded;
}

model LeadListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    leads?: Lead[];
  };
}

model LeadCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model LeadCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    leads?: LeadCreateResult[];
  };
}

model LeadComplexCreateResult {
  id?: int64;
  contact_id?: int64;
  company_id?: int64;
  merged?: boolean;
  request_id?: string;
}

model LeadComplexCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    leads?: LeadComplexCreateResult[];
  };
}

model LeadUpdatedResult {
  id?: int64;
  updated_at?: int64;
  _links?: Record<unknown>;
}

model LeadUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    leads?: LeadUpdatedResult[];
  };
}

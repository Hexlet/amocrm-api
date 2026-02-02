using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/companies-api
// Section: Companies

/** Methods for working with companies. */
@route("/api/v4/companies")
interface Companies {
  /** Get a list of companies (pagination, sorting, filtering). */
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
    /** Filtering parameters */
    @query filter?: Record<unknown>,
  ): CompanyListResponse | Problem;

  /** Get a company by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
    /** Expand related entities; comma-separated values */
    @query with?: string,
  ): Company | Problem;

  /** Create companies. */
  @post
  create(
    @body body: CompanyCreateItem[],
  ): CompanyCreateResponse | Problem;

  /** Update companies (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: CompanyUpdateItem[],
  ): CompanyUpdateResponse | Problem;

  /** Update a company by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: CompanyUpdateById,
  ): CompanyUpdateResponse | Problem;
}

model CompanyEmbedded {
  tags?: Tag[];
  contacts?: RefEntity[];
  leads?: RefEntity[];
  customers?: RefEntity[];
  catalog_elements?: RefEntity[];
}

model Company {
  id?: int64;
  name?: string;
  responsible_user_id?: int64;
  group_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  closest_task_at?: int64;
  custom_fields_values?: CustomFieldValue[] | null;
  account_id?: int64;
  _links?: Record<unknown>;
  _embedded?: CompanyEmbedded;
}

model CompanyCreateItem {
  /** Client-side request id */
  request_id?: string;
  name?: string;
  responsible_user_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  /** Custom fields payload */
  custom_fields_values?: CustomFieldValue[];
  /** Tags to attach */
  tags_to_add?: Tag[];
  /** Embedded entities */
  _embedded?: {
    tags?: Tag[];
  };
}

model CompanyUpdateItem {
  /** Company id */
  id: int64;
  name?: string;
  responsible_user_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  /** Custom fields payload */
  custom_fields_values?: CustomFieldValue[];
  /** Tags to attach */
  tags_to_add?: Tag[];
  /** Tags to delete */
  tags_to_delete?: Tag[];
  _embedded?: {
    tags?: Tag[] | null;
  };
}

model CompanyUpdateById {
  name?: string;
  responsible_user_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  /** Custom fields payload */
  custom_fields_values?: CustomFieldValue[];
  /** Tags to attach */
  tags_to_add?: Tag[];
  /** Tags to delete */
  tags_to_delete?: Tag[];
  _embedded?: {
    tags?: Tag[] | null;
  };
}

model CompanyListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    companies?: Company[];
  };
}

model CompanyCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model CompanyCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    companies?: CompanyCreateResult[];
  };
}

model CompanyUpdatedResult {
  id?: int64;
  updated_at?: int64;
  _links?: Record<unknown>;
}

model CompanyUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    companies?: CompanyUpdatedResult[];
  };
}

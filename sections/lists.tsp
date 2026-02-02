using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/catalogs-api
// Section: Lists

/** Catalogs (lists) management. */
@route("/api/v4/catalogs")
interface Catalogs {
  /** Get catalogs list. */
  @get
  list(
    @query page?: int32,
    @query limit?: int32,
  ): CatalogListResponse | Problem;

  /** Get catalog by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
  ): Catalog | Problem;

  /** Create catalogs. */
  @post
  create(
    @body body: CatalogCreateItem[],
  ): CatalogCreateResponse | Problem;

  /** Update catalogs (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: CatalogUpdateItem[],
  ): CatalogUpdateResponse | Problem;

  /** Update catalog by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: CatalogUpdateById,
  ): CatalogUpdateResponse | Problem;
}

/** Elements of a catalog. */
@route("/api/v4/catalogs/{catalog_id}/elements")
interface CatalogElements {
  /** Get catalog elements list. */
  @get
  list(
    @path catalog_id: int64,
    @query page?: int32,
    @query limit?: int32,
    @query query?: string | int64,
    @query filter?: Record<unknown>,
  ): CatalogElementListResponse | Problem;

  /** Get catalog element by id. */
  @get
  @route("/{id}")
  getById(
    @path catalog_id: int64,
    @path id: int64,
    /** Additional data to include (comma-separated). */
    @query with?: string,
  ): CatalogElement | Problem;

  /** Create catalog elements. */
  @post
  create(
    @path catalog_id: int64,
    @body body: CatalogElementCreateItem[],
  ): CatalogElementCreateResponse | Problem;

  /** Update catalog elements (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @path catalog_id: int64,
    @body body: CatalogElementUpdateItem[],
  ): CatalogElementUpdateResponse | Problem;

  /** Update catalog element by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path catalog_id: int64,
    @path id: int64,
    @body body: CatalogElementUpdateById,
  ): CatalogElementUpdateResponse | Problem;
}

enum CatalogType {
  regular,
  invoices,
  products,
}

model Catalog {
  id?: int64;
  name?: string;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  sort?: int32;
  type?: CatalogType | string;
  can_add_elements?: boolean;
  can_show_in_cards?: boolean;
  can_link_multiple?: boolean;
  can_be_deleted?: boolean;
  sdk_widget_code?: string | int32 | null;
  account_id?: int64;
  _links?: Record<unknown>;
}

model CatalogListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    catalogs?: Catalog[];
  };
}

model CatalogCreateItem {
  name: string;
  type?: CatalogType | string;
  sort?: int32;
  can_add_elements?: boolean;
  can_link_multiple?: boolean;
  request_id?: string;
}

model CatalogUpdateItem {
  id: int64;
  name?: string;
  sort?: int32;
  can_add_elements?: boolean;
  can_link_multiple?: boolean;
  request_id?: string;
}

model CatalogUpdateById {
  name?: string;
  sort?: int32;
  can_add_elements?: boolean;
  can_link_multiple?: boolean;
  request_id?: string;
}

model CatalogCreateResult extends Catalog {
  request_id?: string;
}

model CatalogCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    catalogs?: CatalogCreateResult[];
  };
}

model CatalogUpdateResult extends Catalog {
  request_id?: string;
}

model CatalogUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    catalogs?: CatalogUpdateResult[];
  };
}

model CatalogElementWarning {
  message?: string | null;
}

model CatalogElementEmbedded {
  warning?: CatalogElementWarning | null;
}

model CatalogCustomFieldValueItem {
  value: unknown;
  enum_id?: int64;
  enum_code?: string;
}

model CatalogCustomFieldValue {
  field_id?: int64;
  field_code?: string;
  field_name?: string;
  field_type?: string;
  values: CatalogCustomFieldValueItem[];
}

model CatalogElement {
  id?: int64;
  catalog_id?: int64;
  name?: string;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  is_deleted?: boolean;
  custom_fields_values?: CatalogCustomFieldValue[] | null;
  account_id?: int64;
  invoice_link?: string | null;
  _embedded?: CatalogElementEmbedded;
  _links?: Record<unknown>;
}

model CatalogElementListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    elements?: CatalogElement[];
  };
}

model CatalogElementCreateItem {
  name: string;
  custom_fields_values?: CatalogCustomFieldValue[];
  request_id?: string;
}

model CatalogElementUpdateItem {
  id: int64;
  name?: string;
  custom_fields_values?: CatalogCustomFieldValue[];
  request_id?: string;
}

model CatalogElementUpdateById {
  name?: string;
  custom_fields_values?: CatalogCustomFieldValue[];
  request_id?: string;
}

model CatalogElementCreateResult extends CatalogElement {
  request_id?: string;
}

model CatalogElementCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    elements?: CatalogElementCreateResult[];
  };
}

model CatalogElementUpdateResult extends CatalogElement {
  request_id?: string;
}

model CatalogElementUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    elements?: CatalogElementUpdateResult[];
  };
}

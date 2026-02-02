using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/custom-fields
// Section: Fields and field groups

/** Methods for working with custom fields. */
@route("/api/v4/{entity_type}/custom_fields")
interface CustomFields {
  /** Get custom fields list. */
  @get
  list(
    @path entity_type: string,
    @query page?: int32,
    @query limit?: int32,
  ): CustomFieldListResponse | Problem;

  /** Get custom field by id. */
  @get
  @route("/{id}")
  getById(
    @path entity_type: string,
    @path id: int64,
  ): CustomField | Problem;

  /** Create custom fields. */
  @post
  create(
    @path entity_type: string,
    @body body: CustomFieldCreate[],
  ): CustomFieldCreateResponse | Problem;

  /** Update custom fields (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @path entity_type: string,
    @body body: CustomFieldUpdateItem[],
  ): Record<unknown> | Problem;

  /** Update a custom field by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path entity_type: string,
    @path id: int64,
    @body body: CustomFieldUpdateById,
  ): Record<unknown> | Problem;

  /** Delete a custom field by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path entity_type: string,
    @path id: int64,
  ): Record<unknown> | Problem;
}

/** Methods for working with custom field groups. */
@route("/api/v4/{entity_type}/custom_fields/groups")
interface CustomFieldGroups {
  /** Get custom field groups list. */
  @get
  list(
    @path entity_type: string,
    @query page?: int32,
    @query limit?: int32,
  ): CustomFieldGroupListResponse | Problem;

  /** Get custom field group by id. */
  @get
  @route("/{id}")
  getById(
    @path entity_type: string,
    @path id: int64,
  ): CustomFieldGroup | Problem;

  /** Create custom field groups. */
  @post
  create(
    @path entity_type: string,
    @body body: CustomFieldGroupCreate[],
  ): CustomFieldGroupCreateResponse | Problem;

  /** Update a custom field group by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path entity_type: string,
    @path id: int64,
    @body body: CustomFieldGroupUpdateById,
  ): Record<unknown> | Problem;

  /** Delete a custom field group by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path entity_type: string,
    @path id: int64,
  ): Record<unknown> | Problem;
}

model CustomField {
  id?: int64;
  name?: string;
  type?: string;
  code?: string;
  is_multiple?: boolean;
  is_required?: boolean;
  is_deletable?: boolean;
  is_visible?: boolean;
  sort?: int32;
  enums?: Record<unknown>[];
  settings?: Record<unknown>;
  entity_type?: string;
  group_id?: int64;
}

model CustomFieldCreate {
  /** Client-side request id */
  request_id?: string;
  name: string;
  type: string;
  code?: string;
  is_multiple?: boolean;
  is_required?: boolean;
  is_deletable?: boolean;
  is_visible?: boolean;
  sort?: int32;
  enums?: Record<unknown>[];
  settings?: Record<unknown>;
  group_id?: int64;
}

model CustomFieldUpdateItem {
  /** Custom field id */
  id: int64;
  name?: string;
  type?: string;
  code?: string;
  is_multiple?: boolean;
  is_required?: boolean;
  is_deletable?: boolean;
  is_visible?: boolean;
  sort?: int32;
  enums?: Record<unknown>[];
  settings?: Record<unknown>;
  group_id?: int64;
}

model CustomFieldUpdateById {
  name?: string;
  type?: string;
  code?: string;
  is_multiple?: boolean;
  is_required?: boolean;
  is_deletable?: boolean;
  is_visible?: boolean;
  sort?: int32;
  enums?: Record<unknown>[];
  settings?: Record<unknown>;
  group_id?: int64;
}

model CustomFieldListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    custom_fields?: CustomField[];
  };
}

model CustomFieldCreateResult {
  id?: int64;
  name?: string;
  request_id?: string;
}

model CustomFieldCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    custom_fields?: CustomFieldCreateResult[];
  };
}

model CustomFieldGroup {
  id?: int64;
  name?: string;
  sort?: int32;
  is_predefined?: boolean;
}

model CustomFieldGroupCreate {
  /** Client-side request id */
  request_id?: string;
  name: string;
  sort?: int32;
}

model CustomFieldGroupUpdateById {
  name?: string;
  sort?: int32;
}

model CustomFieldGroupListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    groups?: CustomFieldGroup[];
  };
}

model CustomFieldGroupCreateResult {
  id?: int64;
  name?: string;
  request_id?: string;
}

model CustomFieldGroupCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    groups?: CustomFieldGroupCreateResult[];
  };
}

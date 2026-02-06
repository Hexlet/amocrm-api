using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/contacts-api
// Section: Contacts

/** Methods for working with contacts. */
@route("/api/v4/contacts")
interface Contacts {
  /** Get a list of contacts (pagination, sorting, filtering). */
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
  ): JsonOrHal<ContactListResponse | Problem>;

  /** Get a contact by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
    /** Expand related entities; comma-separated values */
    @query with?: string,
  ): JsonOrHal<Contact | Problem>;

  /** Create contacts. */
  @post
  create(
    @body body: ContactCreateItem[],
  ): ContactCreateResponse | Problem;

  /** Update contacts (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: ContactUpdateItem[],
  ): ContactUpdateResponse | Problem;

  /** Update a contact by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: ContactUpdateById,
  ): ContactUpdateResponse | Problem;
}

/** Methods for linking chats to contacts. */
@route("/api/v4/contacts/chats")
interface ContactChats {
  /** Get list of linked chats. */
  @get
  list(
    @query filter?: Record<unknown>,
  ): ContactChatLinksResponse | Problem;

  /** Link chats to contacts. */
  @post
  link(
    @body body: ContactChatLink[],
  ): ContactChatLinksResponse | Problem;
}

model ContactChatLink {
  contact_id: int64;
  chat_id: string;
  request_id?: string;
}

model ContactChatLinksResponse {
  _links?: Record<unknown>;
  _embedded?: {
    chats?: ContactChatLink[];
  };
}

model ContactEmbedded {
  tags?: Tag[];
  leads?: RefEntity[];
  companies?: RefEntity[];
  customers?: RefEntity[];
  catalog_elements?: RefEntity[];
  social_profiles?: Record<unknown>[];
}

model Contact {
  id?: int64;
  name?: string;
  first_name?: string;
  last_name?: string;
  responsible_user_id?: int64;
  group_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  closest_task_at?: int64;
  custom_fields_values?: CustomFieldValue[] | null;
  account_id?: int64;
  is_unsorted?: boolean;
  _links?: Record<unknown>;
  _embedded?: ContactEmbedded;
}

model ContactCreateItem {
  /** Client-side request id */
  request_id?: string;
  name?: string;
  first_name?: string;
  last_name?: string;
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

model ContactUpdateItem {
  /** Contact id */
  id: int64;
  name?: string;
  first_name?: string;
  last_name?: string;
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

model ContactUpdateById {
  name?: string;
  first_name?: string;
  last_name?: string;
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

model ContactListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    contacts?: Contact[];
  };
}

model ContactCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model ContactCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    contacts?: ContactCreateResult[];
  };
}

model ContactUpdatedResult {
  id?: int64;
  updated_at?: int64;
  _links?: Record<unknown>;
}

model ContactUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    contacts?: ContactUpdatedResult[];
  };
}

using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/users-api
// Section: Users

/** Users management. */
@route("/api/v4/users")
interface Users {
  /** Get users list. */
  @get
  list(
    @query with?: string,
    @query page?: int32,
    @query limit?: int32,
  ): UserListResponse | Problem;

  /** Get user by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
    @query with?: string,
  ): User | Problem;

  /** Create users (batch). */
  @post
  create(
    @body body: UserCreateItem[],
  ): UserCreateResponse | Problem;
}

/** User roles management. */
@route("/api/v4/roles")
interface Roles {
  /** Get roles list. */
  @get
  list(
    @query with?: string,
    @query page?: int32,
    @query limit?: int32,
  ): RoleListResponse | Problem;

  /** Get role by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
    @query with?: string,
  ): Role | Problem;

  /** Create roles (batch). */
  @post
  create(
    @body body: RoleCreateItem[],
  ): RoleCreateResponse | Problem;

  /** Update role by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: RoleUpdateById,
  ): Role | Problem;

  /** Delete role by id. */
  @delete
  @route("/{id}")
  deleteById(
    @path id: int64,
  ): EmptyResponse | Problem;
}

model StatusRight {
  entity_type?: string;
  pipeline_id?: int64;
  status_id?: int64;
  rights?: Record<unknown>;
}

model UserRights {
  leads?: Record<unknown>;
  contacts?: Record<unknown>;
  companies?: Record<unknown>;
  tasks?: Record<unknown>;
  mail_access?: boolean;
  catalog_access?: boolean;
  is_admin?: boolean;
  is_free?: boolean;
  is_active?: boolean;
  group_id?: int64 | null;
  role_id?: int64 | null;
  status_rights?: StatusRight[] | null;
}

model UserEmbedded {
  roles?: Role[];
  groups?: UsersGroup[];
}

model User {
  id?: int64;
  name?: string;
  email?: string;
  lang?: string;
  rights?: UserRights;
  uuid?: string | null;
  amojo_id?: string | null;
  user_rank?: string | null;
  phone_number?: string | null;
  _links?: Record<unknown>;
  _embedded?: UserEmbedded;
}

model UserListResponse {
  _total_items?: int32;
  _page?: int32;
  _page_count?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    users?: User[];
  };
}

model UserCreateItem {
  name: string;
  email: string;
  password: string;
  lang?: string;
  rights?: UserRights;
  request_id?: string;
}

model UserCreateResult extends User {
  request_id?: string;
}

model UserCreateResponse {
  _total_items?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    users?: UserCreateResult[];
  };
}

model RoleEmbedded {
  users?: {
    id?: int64;
  }[];
}

model Role {
  id?: int64;
  name?: string;
  rights?: UserRights;
  _links?: Record<unknown>;
  _embedded?: RoleEmbedded;
}

model RoleListResponse {
  _total_items?: int32;
  _page?: int32;
  _page_count?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    roles?: Role[];
  };
}

model RoleCreateItem {
  name: string;
  rights?: UserRights;
  request_id?: string;
}

model RoleCreateResult extends Role {
  request_id?: string;
}

model RoleCreateResponse {
  _total_items?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    roles?: RoleCreateResult[];
  };
}

model RoleUpdateById {
  name?: string;
  rights?: UserRights | null;
  request_id?: string;
}

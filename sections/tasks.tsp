using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/tasks-api
// Section: Tasks

/** Methods for working with tasks. */
@route("/api/v4/tasks")
interface Tasks {
  /** Get a list of tasks (pagination, sorting, filtering). */
  @get
  list(
    /** Pagination page */
    @query page?: int32,
    /** Pagination limit */
    @query limit?: int32,
    /** Search by query string or id */
    @query query?: string | int64,
    /** Sorting, e.g. order[updated_at]=asc */
    @query order?: Record<unknown>,
    /** Filtering parameters */
    @query filter?: Record<unknown>,
  ): TaskListResponse | Problem;

  /** Get a task by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
  ): Task | Problem;

  /** Create tasks. */
  @post
  create(
    @body body: TaskCreate[],
  ): TaskCreateResponse | Problem;

  /** Update tasks (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: TaskUpdateItem[],
  ): TaskUpdateResponse | Problem;

  /** Update a task by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: TaskUpdateById,
  ): TaskUpdateResponse | Problem;
}

model Task {
  id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  responsible_user_id?: int64;
  group_id?: int64;
  entity_id?: int64;
  entity_type?: string;
  duration?: int64;
  is_completed?: boolean;
  task_type_id?: int64;
  text?: string;
  result?: {
    text?: string;
  } | Record<unknown>;
  complete_till?: int64;
  account_id?: int64;
  _links?: Record<unknown>;
}

model TaskCreate {
  /** Client-side request id */
  request_id?: string;
  task_type_id?: int64;
  text: string;
  complete_till?: int64;
  entity_id?: int64;
  entity_type?: string;
  responsible_user_id?: int64;
  created_by?: int64;
  updated_by?: int64;
}

model TaskUpdateItem {
  /** Task id */
  id: int64;
  task_type_id?: int64;
  text?: string;
  complete_till?: int64;
  entity_id?: int64;
  entity_type?: string;
  responsible_user_id?: int64;
  is_completed?: boolean;
  result?: {
    text?: string;
  };
}

model TaskUpdateById {
  task_type_id?: int64;
  text?: string;
  complete_till?: int64;
  entity_id?: int64;
  entity_type?: string;
  responsible_user_id?: int64;
  is_completed?: boolean;
  result?: {
    text?: string;
  };
}

model TaskListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    tasks?: Task[];
  };
}

model TaskCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model TaskCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    tasks?: TaskCreateResult[];
  };
}

model TaskUpdatedResult {
  id?: int64;
  updated_at?: int64;
  _links?: Record<unknown>;
}

model TaskUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    tasks?: TaskUpdatedResult[];
  };
}

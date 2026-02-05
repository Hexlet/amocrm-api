using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/events-and-notes
// Section: Events and notes

/** Methods for working with events. */
@route("/api/v4/events")
interface Events {
  /** Get events list. */
  @get
  list(
    @query page?: int32,
    @query limit?: int32,
    @query with?: string,
    @query filter?: Record<unknown>,
  ): EventListResponse | Problem;

  /** Get event by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
    @query with?: string,
  ): Event | Problem;

  /** Get event types. */
  @get
  @route("/types")
  listTypes(
    @query language_code?: string,
  ): EventTypesResponse | Problem;
}

model Event {
  id?: int64;
  type?: string;
  entity_id?: int64;
  entity_type?: string;
  created_by?: int64;
  created_at?: int64;
  value_before?: Record<unknown>;
  value_after?: Record<unknown>;
  _links?: Record<unknown>;
}

model EventListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    events?: Event[];
  };
}

model EventTypesResponse {
  _embedded?: {
    types?: Record<unknown>[];
  };
}

/** Methods for working with notes (by entity type). */
@route("/api/v4/{entity_type}/notes")
interface EntityNotes {
  /** Get notes list for entity type. */
  @get
  list(
    @path entity_type: EntityLinkType,
    @query page?: int32,
    @query limit?: int32,
    @query filter?: Record<unknown>,
  ): NoteListResponse | Problem;

  /** Create notes for entity type. */
  @post
  create(
    @path entity_type: EntityLinkType,
    @body body: NoteCreate[],
  ): NoteCreateResponse | Problem;

  /** Update notes for entity type (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @path entity_type: EntityLinkType,
    @body body: NoteUpdateItem[],
  ): NoteCreateResponse | Problem;

  /** Get note by id. */
  @get
  @route("/{id}")
  getById(
    @path entity_type: EntityLinkType,
    @path id: int64,
    @query with?: string,
  ): Note | Problem;

  /** Update note by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path entity_type: EntityLinkType,
    @path id: int64,
    @body body: NoteUpdateById,
  ): NoteCreateResponse | Problem;

  /** Pin note by id. */
  @post
  @route("/{id}/pin")
  pin(
    @path entity_type: EntityLinkType,
    @path id: int64,
  ): EmptyResponse | Problem;

  /** Unpin note by id. */
  @post
  @route("/{id}/unpin")
  unpin(
    @path entity_type: EntityLinkType,
    @path id: int64,
  ): EmptyResponse | Problem;
}

/** Methods for working with notes by parent entity. */
@route("/api/v4/{entity_type}/{entity_id}/notes")
interface EntityNotesByParent {
  /** Get notes list for a specific entity. */
  @get
  listByParent(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @query page?: int32,
    @query limit?: int32,
    @query filter?: Record<unknown>,
  ): NoteListResponse | Problem;

  /** Create notes for a specific entity. */
  @post
  createByParent(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @body body: NoteCreate[],
  ): NoteCreateResponse | Problem;

  /** Update notes for a specific entity (batch). */
  @patch(#{ implicitOptionality: false })
  updateByParent(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @body body: NoteUpdateItem[],
  ): NoteCreateResponse | Problem;

  /** Get note by id for a specific entity. */
  @get
  @route("/{note_id}")
  getByParentId(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @path note_id: int64,
    @query with?: string,
  ): Note | Problem;

  /** Update note by id for a specific entity. */
  @patch(#{ implicitOptionality: false })
  @route("/{note_id}")
  updateByParentId(
    @path entity_type: EntityLinkType,
    @path entity_id: int64,
    @path note_id: int64,
    @body body: NoteUpdateById,
  ): NoteCreateResponse | Problem;
}

model Note {
  id?: int64;
  entity_id?: int64;
  note_type?: string;
  responsible_user_id?: int64;
  group_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  account_id?: int64;
  is_pinned?: boolean;
  params?: Record<unknown>;
  _links?: Record<unknown>;
}

model NoteCreate {
  /** Client-side request id */
  request_id?: string;
  entity_id?: int64;
  note_type: string;
  params?: Record<unknown>;
  created_by?: int64;
  responsible_user_id?: int64;
  updated_by?: int64;
  created_at?: int64;
  is_need_to_trigger_digital_pipeline?: boolean;
}

model NoteUpdateItem {
  /** Note id */
  id: int64;
  entity_id?: int64;
  note_type?: string;
  params?: Record<unknown>;
  updated_by?: int64;
  updated_at?: int64;
}

model NoteUpdateById {
  entity_id?: int64;
  note_type?: string;
  params?: Record<unknown>;
  updated_by?: int64;
  updated_at?: int64;
}

model NoteListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    notes?: Note[];
  };
}

model NoteCreateResult {
  id?: int64;
  entity_id?: int64;
  request_id?: string;
  updated_at?: int64;
  _links?: Record<unknown>;
}

model NoteCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    notes?: NoteCreateResult[];
  };
}

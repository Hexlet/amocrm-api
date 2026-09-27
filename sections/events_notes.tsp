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
    @body body: NoteUpdateByParentId,
  ): NoteCreateResponse | Problem;
}

model Note {
  id?: int64;
  entity_id?: int64;
  note_type?: NoteType;
  responsible_user_id?: int64;
  group_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  account_id?: int64;
  is_pinned?: boolean;
  params?: NoteParams;
  _links?: Record<unknown>;
}

model NoteCreate {
  /** Client-side request id */
  request_id?: string;
  entity_id?: int64;
  note_type: NoteType;
  params?: NoteParams;
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
  note_type?: NoteType;
  params?: NoteParams;
  updated_by?: int64;
  updated_at?: int64;
}

model NoteUpdateById {
  entity_id?: int64;
  note_type?: NoteType;
  params?: NoteParams;
  updated_by?: int64;
  updated_at?: int64;
}

model NoteUpdateByParentId {
  note_type?: NoteType;
  params?: NoteParams;
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

/** Тип примечания. */
union NoteType {
  "common",
  "call_in",
  "call_out",
  "service_message",
  "message_cashier",
  "geolocation",
  "sms_in",
  "sms_out",
  "extended_service_message",
  "attachment",
}

/**
 * Параметры примечания: состав зависит от `note_type`. Варианты — от самого специфичного
 * к общему, дискриминатора внутри params нет.
 */
union NoteParams {
  NoteParamsCall,
  NoteParamsGeolocation,
  NoteParamsAttachment,
  NoteParamsMessageCashier,
  NoteParamsServiceMessage,
  NoteParamsSms,
  NoteParamsCommon,
}

/** call_in, call_out */
model NoteParamsCall {
  uniq: string;
  /** Длительность звонка в секундах */
  duration: int32;
  source: string;
  /** Ссылка на запись звонка */
  link: string;
  phone: string;
  /** Имя ответственного или ID пользователя */
  call_responsible: string | int64;
}

/** geolocation */
model NoteParamsGeolocation {
  text: string;
  address: string;
  longitude: string;
  latitude: string;
}

/** attachment */
model NoteParamsAttachment {
  /** Версия файла; без неё берётся последняя */
  version_uuid?: string;
  file_uuid: string;
  /** Название файла, которое отображается в примечании */
  file_name: string;
}

/** message_cashier */
model NoteParamsMessageCashier {
  status: "created" | "shown" | "canceled";
  text: string;
}

/** service_message, extended_service_message */
model NoteParamsServiceMessage {
  service: string;
  text: string;
}

/** sms_in, sms_out */
model NoteParamsSms {
  text: string;
  phone: string;
}

/** common */
model NoteParamsCommon {
  text: string;
}

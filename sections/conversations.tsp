using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/talks-api
// Section: Conversations

/** Talks (conversations) API. */
@route("/api/v4/talks")
interface Talks {
  /** Get talk by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
  ): Talk | Problem;

  /** Close talk by id (optionally force without NPS bot). */
  @post
  @route("/{id}/close")
  close(
    @path id: int64,
    @body body: TalkCloseRequest,
  ): EmptyResponse | Problem;
}

model TalkEmbedded {
  contacts?: RefEntity[];
  leads?: RefEntity[];
  customers?: RefEntity[];
}

model Talk {
  talk_id?: int64;
  created_at?: int64;
  updated_at?: int64;
  rate?: int32;
  contact_id?: int64;
  chat_id?: string;
  entity_id?: int64 | null;
  entity_type?: string | null;
  is_in_work?: boolean;
  is_read?: boolean;
  origin?: string;
  missed_at?: int64 | null;
  account_id?: int64;
  _links?: Record<unknown>;
  _embedded?: TalkEmbedded;
}

model TalkCloseRequest {
  /** Force close talk without NPS bot. */
  force_close?: boolean;
}

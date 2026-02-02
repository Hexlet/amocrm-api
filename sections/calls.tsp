using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/calls-api
// Section: Calls

/** Add calls to entities by phone number. */
@route("/api/v4/calls")
interface Calls {
  /** Add calls (batch). */
  @post
  create(
    @body body: CallCreateItem[],
  ): CallCreateResponse | Problem;
}

enum CallDirection {
  inbound,
  outbound,
}

model CallCreateItem {
  direction: CallDirection | string;
  uniq?: string;
  duration: int32;
  source: string;
  link?: string;
  phone: string;
  call_responsible?: string | int64 | null;
  call_result?: string;
  call_status?: int32;
  responsible_user_id?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  request_id?: string;
}

model CallEmbeddedEntity {
  id?: int64;
  _links?: Record<unknown>;
}

model CallEmbedded {
  entity?: CallEmbeddedEntity;
}

model CallCreateResult {
  id?: int64;
  entity_id?: int64;
  entity_type?: string | int32;
  account_id?: int64;
  request_id?: string;
  _embedded?: CallEmbedded;
}

model CallCreateResponse {
  _total_items?: int32;
  errors?: Record<unknown>[];
  _embedded?: {
    calls?: CallCreateResult[];
  };
}

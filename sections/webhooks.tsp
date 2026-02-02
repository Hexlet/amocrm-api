using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/webhooks-api
// Section: Webhooks

/** Webhooks management. */
@route("/api/v4/webhooks")
interface Webhooks {
  /** Get webhooks list. */
  @get
  list(
    @query filter?: {
      destination?: string;
    },
  ): WebhookListResponse | Problem;

  /** Subscribe to webhook events. */
  @post
  subscribe(
    @body body: WebhookSubscribeRequest,
  ): Webhook | Problem;

  /** Unsubscribe webhook by destination. */
  @delete
  unsubscribe(
    @body body: WebhookUnsubscribeRequest,
  ): EmptyResponse | Problem;
}

model Webhook {
  id?: int64;
  destination?: string;
  created_at?: int64;
  updated_at?: int64;
  account_id?: int64;
  created_by?: int64;
  sort?: int32;
  disabled?: boolean;
  settings?: string[];
}

model WebhookListResponse {
  _total_items?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    webhooks?: Webhook[];
  };
}

model WebhookSubscribeRequest {
  destination: string;
  settings: string[];
  sort?: int32;
}

model WebhookUnsubscribeRequest {
  destination: string;
}

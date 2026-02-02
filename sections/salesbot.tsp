using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/api/salesbot-api
// Section: Salesbot

/** Salesbot API. */
@route("/api/v2/salesbot")
interface Salesbot {
  /** Run salesbot (batch, up to 100 tasks). */
  @post
  @route("/run")
  run(
    @body body: SalesbotRunItem[],
  ): SalesbotRunResponse | Problem;
}

model SalesbotRunItem {
  bot_id: int64;
  entity_id: int64;
  entity_type: int32;
}

model SalesbotRunResponse {
  success?: boolean;
  _links?: {
    self?: {
      href?: string;
      method?: string;
    };
  };
}

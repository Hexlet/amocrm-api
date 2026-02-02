using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/short_links
// Section: Short links

/** Short links API. */
@route("/api/v4/short_links")
interface ShortLinks {
  /** Create short link. */
  @post
  create(
    @body body: ShortLinkCreateRequest,
  ): ShortLinkCreateResponse | Problem;
}

model ShortLinkCreateRequest {
  url: string;
}

model ShortLinkCreateResponse {
  short_link?: string;
}

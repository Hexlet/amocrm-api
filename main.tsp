// API Reference: https://www.amocrm.ru/developers/content/crm_platform/api-reference

import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "./sections/types.tsp";
import "./sections/limits_recommendations.tsp";
import "./sections/account.tsp";
import "./sections/leads.tsp";
import "./sections/unsorted.tsp";
import "./sections/pipelines.tsp";
import "./sections/filtering_alpha.tsp";
import "./sections/contacts.tsp";
import "./sections/companies.tsp";
import "./sections/lists.tsp";
import "./sections/entity_links.tsp";
import "./sections/tasks.tsp";
import "./sections/fields.tsp";
import "./sections/tags.tsp";
import "./sections/events_notes.tsp";
import "./sections/customers.tsp";
import "./sections/customers_statuses_segments.tsp";
import "./sections/users.tsp";
import "./sections/catalogs.tsp";
import "./sections/webhooks.tsp";
import "./sections/widgets.tsp";
import "./sections/calls.tsp";
import "./sections/conversations.tsp";
import "./sections/entity_followers.tsp";
import "./sections/sources.tsp";
import "./sections/salesbot.tsp";
import "./sections/short_links.tsp";
import "./sections/chat_templates.tsp";
import "./sections/duplicates.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@service(#{
  title: "amoCRM API",
})
@info(#{
  version: "0.1.0",
})
// `subdomain` is provided by SDK client settings (e.g. AMOCRM_SUBDOMAIN).
@server(
  "https://{subdomain}.amocrm.ru",
  "amoCRM account server",
  {
    subdomain: string,
  }
)
@useAuth(BearerAuth)
namespace AmoCRM;

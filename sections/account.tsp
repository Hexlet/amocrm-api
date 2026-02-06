using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/account-info
// Section: Account parameters

/** Account info and settings. */
@route("/api/v4/account")
interface Account {
  /** Get account info. */
  @get
  get(
    /** Additional data to include (comma-separated). */
    @query with?: string,
  ): JsonOrHal<AccountInfo | Problem>;
}

model AmojoRights {
  can_direct?: boolean;
  can_create_groups?: boolean;
}

model DateTimeSettings {
  date_pattern?: string;
  short_date_pattern?: string;
  short_time_pattern?: string;
  date_format?: string;
  time_format?: string;
  timezone?: string;
  timezone_offset?: string;
}

model InvoicesSettings {
  lang?: string;
  invoices_catalog_id?: int64;
}

model TaskType {
  id?: int64;
  name?: string;
  color?: string;
  icon_id?: int64;
  code?: string;
}

model UsersGroup {
  id?: int64;
  name?: string;
  uuid?: string;
}

model AccountEmbedded {
  amojo_rights?: AmojoRights;
  users_groups?: UsersGroup[];
  task_types?: TaskType[];
  datetime_settings?: DateTimeSettings;
}

enum AccountCustomersMode {
  periodicity,
  dynamic,
  segments,
  disabled,
  unavailable,
}

model AccountInfo {
  id?: int64;
  name?: string;
  subdomain?: string;
  created_at?: int64;
  created_by?: int64;
  updated_at?: int64;
  updated_by?: int64;
  current_user_id?: int64;
  country?: string;
  currency?: string;
  currency_symbol?: string;
  is_unsorted_on?: boolean;
  mobile_feature_version?: int32;
  customers_mode?: AccountCustomersMode | string;
  is_loss_reason_enabled?: boolean;
  is_helpbot_enabled?: boolean;
  contact_name_display_order?: int32;
  is_technical_account?: boolean;
  amojo_id?: string;
  uuid?: string;
  version?: int32;
  invoices_settings?: InvoicesSettings;
  is_api_filter_enabled?: boolean;
  drive_url?: string;
  _links?: Record<unknown>;
  _embedded?: AccountEmbedded;
}

using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/widgets-api
// Section: Widgets

/** Widgets management. */
@route("/api/v4/widgets")
interface Widgets {
  /** Get widgets list. */
  @get
  list(
    @query page?: int32,
    @query limit?: int32,
  ): WidgetListResponse | Problem;

  /** Get widget info by code. */
  @get
  @route("/{widget_code}")
  getByCode(
    @path widget_code: string,
  ): Widget | Problem;

  /** Install widget in account. */
  @post
  @route("/{widget_code}")
  install(
    @path widget_code: string,
    @body body: Record<unknown>,
  ): Widget | Problem;

  /** Uninstall widget from account. */
  @delete
  @route("/{widget_code}")
  uninstall(
    @path widget_code: string,
  ): EmptyResponse | Problem;
}

/** Continue Salesbot/Marketingbot after widget execution. */
@route("/api/v4/{bot_type}/{bot_id}/continue/{continue_id}")
interface WidgetBotContinue {
  @post
  continue(
    @path bot_type: "salesbot" | "marketingbot",
    @path bot_id: int64,
    @path continue_id: int64,
    @body body: WidgetContinueRequest,
  ): EmptyResponse | Problem;
}

model WidgetSettingTemplate {
  key?: string;
  name?: string;
  type?: string;
  is_required?: boolean;
}

model Widget {
  id?: int64;
  code?: string;
  version?: string | int32 | null;
  rating?: string | float64 | null;
  settings_template?: WidgetSettingTemplate[];
  is_lead_source?: boolean;
  is_work_with_dp?: boolean;
  is_crm_template?: boolean;
  client_uuid?: string | null;
  is_active_in_account?: boolean;
  pipeline_id?: int64 | null;
  settings?: Record<unknown> | null;
  _links?: Record<unknown>;
}

model WidgetListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    widgets?: Widget[];
  };
}

model WidgetContinueRequest {
  data?: Record<unknown>;
  execute_handlers?: WidgetExecuteHandler[];
}

model WidgetExecuteHandler {
  handler?: string;
  params?: Record<unknown>;
}

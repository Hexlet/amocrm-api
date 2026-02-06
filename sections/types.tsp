using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/api-reference

alias JsonOrHal<T> = {
  @header contentType: "application/json";
  @body body: T;
} | {
  @header contentType: "application/hal+json";
  @body body: T;
};


model Problem {
  title?: string;
  status?: int32;
  detail?: string;
  type?: string;
}

model Tag {
  id?: int64;
  name?: string;
  color?: string;
}

model CustomFieldValueItem {
  value: string | int32 | boolean;
  /** Option id for list/select custom fields (one of predefined options) */
  enum_id?: int64;
  /** Option code for list/select custom fields (if you use code instead of id) */
  enum_code?: string;
}

model CustomFieldValue {
  /** Use either field_id or field_code (e.g. PHONE/EMAIL) */
  field_id?: int64;

  /** Field code (e.g. PHONE/EMAIL) */
  field_code?: string;
  /** Values for the field (multiple values allowed) */
  values: CustomFieldValueItem[];
}

model RefEntity {
  id?: int64;
  _links?: Record<unknown>;
}

model ContactCreate {
  id?: int64;
  name?: string;
  first_name?: string;
  last_name?: string;
  /** Custom fields payload (same as contact create API) */
  custom_fields_values?: CustomFieldValue[];
}

model CompanyCreate {
  id?: int64;
  name?: string;
}

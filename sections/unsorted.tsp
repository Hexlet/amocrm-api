using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/unsorted-api
// Section: Unsorted


model FormMetadata {
  /** IP address of the submitter */
  ip?: string;
  /** Form id in your system (string or numeric) */
  form_id?: string | int64;
  /** Unix timestamp (seconds) when the form was submitted */
  form_sent_at?: int64;
  /** Form name (shown in amoCRM) */
  form_name?: string;
  /** Page URL where form lives */
  form_page?: string;
  /** Referrer URL */
  referer?: string;
  /** Visitor uid from tracking, if you have it */
  visitor_uid?: string;
  /** Form type code from amoCRM, use only if you know it */
  form_type?: int32;
}

model UnsortedEmbeddedCreate {
  /** Create related entities together with unsorted (lead/contact/company) */
  leads?: LeadCreate[];
  contacts?: ContactCreate[];
  companies?: CompanyCreate[];
}

model UnsortedFormCreateItem {
  /** Your request id to match request items with response items */
  request_id?: string;
  /** Your stable id of the source: site/form/widget/integration that sent the lead */
  source_uid: string;
  /** Human-readable source name shown in amoCRM (e.g. "Website form", "Landing page") */
  source_name: string;
  /** Pipeline id to place the created lead into */
  pipeline_id?: int64;
  /** Unix timestamp (seconds) when the form entry was created */
  created_at?: int64;
  /** Embedded entities (lead/contact/company) */
  _embedded?: UnsortedEmbeddedCreate;
  /** Form metadata */
  metadata: FormMetadata;
}

model UnsortedCreatedEmbedded {
  leads?: RefEntity[];
  contacts?: RefEntity[];
  companies?: RefEntity[];
}

model UnsortedCreatedItem {
  uid?: string;
  account_id?: int64;
  /** Echoed request id */
  request_id?: string;
  _links?: Record<unknown>;
  _embedded?: UnsortedCreatedEmbedded;
}

model UnsortedCreateResponse {
  _total_items?: int32;
  _embedded?: {
    unsorted?: UnsortedCreatedItem[];
  };
}

model UnsortedAcceptRequest {
  /** User id on whose behalf the item is accepted */
  user_id?: int64;
  /** Status id for the created lead */
  status_id?: int64;
}

model UnsortedDeclineRequest {
  /** User id on whose behalf the item is declined */
  user_id?: int64;
}

model UnsortedAcceptResponse {
  uid?: string;
  pipeline_id?: int64;
  category?: "sip" | "mail" | "chats" | "forms";
  created_at?: int64;
  _embedded?: UnsortedCreatedEmbedded;
}

@route("/api/v4/leads/unsorted")
interface UnsortedLeads {
  @post
  @route("/forms")
  createForms(
    @body body: UnsortedFormCreateItem[],
  ): UnsortedCreateResponse | Problem;

  @post
  @route("/{uid}/accept")
  accept(
    @path uid: string,
    @body body?: UnsortedAcceptRequest,
  ): UnsortedAcceptResponse | Problem;

  @delete
  @route("/{uid}/decline")
  decline(
    @path uid: string,
    @body body?: UnsortedDeclineRequest,
  ): UnsortedAcceptResponse | Problem;
}

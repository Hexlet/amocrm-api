using TypeSpec.Http;

namespace AmoCRM;
// API Reference: https://www.amocrm.ru/developers/content/crm_platform/customers-api
// Section: Customers

/** Methods for working with customers. */
@route("/api/v4/customers")
interface Customers {
  /** Get a list of customers. */
  @get
  list(
    @query page?: int32,
    @query limit?: int32,
    @query query?: string | int64,
    /** Expand related entities; comma-separated values */
    @query with?: string,
    @query order?: Record<unknown>,
    @query filter?: Record<unknown>,
  ): CustomerListResponse | Problem;

  /** Get a customer by id. */
  @get
  @route("/{id}")
  getById(
    @path id: int64,
    /** Expand related entities; comma-separated values */
    @query with?: string,
  ): Customer | Problem;

  /** Create customers. */
  @post
  create(
    @body body: CustomerCreateItem[],
  ): CustomerCreateResponse | Problem;

  /** Update customers (batch). */
  @patch(#{ implicitOptionality: false })
  update(
    @body body: CustomerUpdateItem[],
  ): CustomerUpdateResponse | Problem;

  /** Update a customer by id. */
  @patch(#{ implicitOptionality: false })
  @route("/{id}")
  updateById(
    @path id: int64,
    @body body: CustomerUpdateById,
  ): CustomerUpdateResponse | Problem;
}

/** Customers mode (segments/periodicity). */
@route("/api/v4/customers/mode")
interface CustomersMode {
  /** Enable or switch customers mode. */
  @patch(#{ implicitOptionality: false })
  setMode(
    @body body: CustomerModeRequest,
  ): CustomerModeResponse | Problem;
}

/** Customer transactions. */
@route("/api/v4/customers")
interface CustomerTransactions {
  /** Get list of transactions. */
  @get
  @route("/transactions")
  list(
    @query page?: int32,
    @query limit?: int32,
    @query filter?: Record<unknown>,
  ): CustomerTransactionListResponse | Problem;

  /** Get list of transactions for a customer. */
  @get
  @route("/{customer_id}/transactions")
  listByCustomer(
    @path customer_id: int64,
    @query page?: int32,
    @query limit?: int32,
    @query filter?: Record<unknown>,
  ): CustomerTransactionListResponse | Problem;

  /** Create transactions for a customer. */
  @post
  @route("/{customer_id}/transactions")
  create(
    @path customer_id: int64,
    @query accrue_bonus?: boolean,
    @body body: CustomerTransactionCreate[],
  ): CustomerTransactionCreateResponse | Problem;

  /** Delete a transaction for a customer. */
  @delete
  @route("/{customer_id}/transactions/{transaction_id}")
  deleteById(
    @path customer_id: int64,
    @path transaction_id: int64,
  ): Record<unknown> | Problem;
}

/** Customer bonus points. */
@route("/api/v4/customers/{customer_id}/bonus_points")
interface CustomerBonusPoints {
  /** Earn or redeem bonus points. */
  @post
  change(
    @path customer_id: int64,
    @body body: CustomerBonusPointsEarn | CustomerBonusPointsRedeem,
  ): CustomerBonusPointsResponse | Problem;
}

model CustomerEmbedded {
  tags?: Tag[];
  contacts?: RefEntity[];
  companies?: RefEntity[];
  catalog_elements?: RefEntity[];
  segments?: RefEntity[];
}

model Customer {
  id?: int64;
  name?: string;
  next_price?: int64;
  next_date?: int64;
  periodicity?: int64;
  closest_task_at?: int64;
  ltv?: int64;
  purchases_count?: int64;
  average_check?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  updated_at?: int64;
  status_id?: int64;
  responsible_user_id?: int64;
  group_id?: int64;
  is_deleted?: boolean;
  main_user_id?: int64;
  custom_fields_values?: CustomFieldValue[] | null;
  account_id?: int64;
  _links?: Record<unknown>;
  _embedded?: CustomerEmbedded;
}

model CustomerCreateItem {
  request_id?: string;
  name?: string;
  next_price?: int64;
  next_date?: int64;
  periodicity?: int64;
  created_by?: int64;
  updated_by?: int64;
  created_at?: int64;
  status_id?: int64;
  responsible_user_id?: int64;
  main_user_id?: int64;
  custom_fields_values?: CustomFieldValue[];
  tags_to_add?: Tag[];
  _embedded?: {
    tags?: Tag[];
    segments?: RefEntity[];
  };
}

model CustomerUpdateItem {
  id: int64;
  name?: string;
  next_price?: int64;
  next_date?: int64;
  periodicity?: int64;
  updated_by?: int64;
  updated_at?: int64;
  status_id?: int64;
  responsible_user_id?: int64;
  main_user_id?: int64;
  custom_fields_values?: CustomFieldValue[];
  tags_to_add?: Tag[];
  tags_to_delete?: Tag[];
  _embedded?: {
    tags?: Tag[] | null;
    segments?: RefEntity[] | null;
  };
}

model CustomerUpdateById {
  name?: string;
  next_price?: int64;
  next_date?: int64;
  periodicity?: int64;
  updated_by?: int64;
  updated_at?: int64;
  status_id?: int64;
  responsible_user_id?: int64;
  main_user_id?: int64;
  custom_fields_values?: CustomFieldValue[];
  tags_to_add?: Tag[];
  tags_to_delete?: Tag[];
  _embedded?: {
    tags?: Tag[] | null;
    segments?: RefEntity[] | null;
  };
}

model CustomerListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    customers?: Customer[];
  };
}

model CustomerCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model CustomerCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    customers?: CustomerCreateResult[];
  };
}

model CustomerUpdatedResult {
  id?: int64;
  updated_at?: int64;
  _links?: Record<unknown>;
}

model CustomerUpdateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    customers?: CustomerUpdatedResult[];
  };
}

model CustomerModeRequest {
  mode: "segments" | "periodicity";
  is_enabled: boolean;
}

model CustomerModeResponse {
  mode?: "segments" | "periodicity";
  is_enabled?: boolean;
}

model CustomerTransaction {
  id?: int64;
  customer_id?: int64;
  price?: int64;
  comment?: string;
  created_at?: int64;
  created_by?: int64;
  _links?: Record<unknown>;
}

model CustomerTransactionCreate {
  request_id?: string;
  price: int64;
  comment?: string;
  created_at?: int64;
  created_by?: int64;
}

model CustomerTransactionListResponse {
  _page?: int32;
  _links?: Record<unknown>;
  _embedded?: {
    transactions?: CustomerTransaction[];
  };
}

model CustomerTransactionCreateResult {
  id?: int64;
  request_id?: string;
  _links?: Record<unknown>;
}

model CustomerTransactionCreateResponse {
  _links?: Record<unknown>;
  _embedded?: {
    transactions?: CustomerTransactionCreateResult[];
  };
}

model CustomerBonusPointsEarn {
  earn: int64;
}

model CustomerBonusPointsRedeem {
  redeem: int64;
}

model CustomerBonusPointsResponse {
  bonus_points?: int64;
}

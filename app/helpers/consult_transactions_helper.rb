module ConsultTransactionsHelper

  def status_text_of(transaction)
    puts transaction.status
    { initiated: I18n.t("service_status.initiated"),
      confirmed: I18n.t("service_status.confirmed") ,
      payment_pending: I18n.t("service_status.payment_pending") ,
      payment_completed: I18n.t("service_status.payment_completed") ,
      canceled: I18n.t("service_status.canceled") ,
      completed: I18n.t("service_status.completed") ,
      aborted: I18n.t("service_status.aborted"),
      reviewed: I18n.t("service_status.reviewed") }[transaction.status.intern]
  end
end

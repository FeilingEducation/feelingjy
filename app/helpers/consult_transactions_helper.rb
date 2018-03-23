module ConsultTransactionsHelper

  def status_text_of(transaction)
    puts transaction.status
    { initiated: I18n.t("service_status.initiated"),
      payment_pending: I18n.t("service_status.payment_pending") ,
      confirmed: I18n.t("service_status.confirmed") ,
      canceled: I18n.t("service_status.canceled") ,
      completed: I18n.t("service_status.completed") ,
      aborted: I18n.t("service_status.aborted")  }[transaction.status.intern]
  end
end

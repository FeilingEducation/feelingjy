module ConsultTransactionsHelper

  def status_text_of(transaction)
    puts transaction.status
    { initiated: "等待导师确认",
      payment_pending: "待付款",
      confirmed: "已付款",
      canceled: "已取消",
      completed: "已完成",
      aborted: "已终止" }[transaction.status.intern]
  end
end

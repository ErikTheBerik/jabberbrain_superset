-- 1) Unified transactions+logs
CREATE SCHEMA IF NOT EXISTS default.feedback;

CREATE OR REPLACE VIEW default.feedback.transaction_data AS
SELECT
  t._id                 AS transaction_id,
  l._id                 AS transaction_log_id,
  t.* EXCLUDE (_id),
  l.* EXCLUDE (_id)
FROM prod.session_engine."Transactions" AS t
JOIN prod.session_engine_logs."LoggedTransactionData" AS l
  ON t.relatedDataId = l._id;

-- 2) Join on MySQL feedback (NULL means “no feedback yet”)
CREATE OR REPLACE VIEW default.feedback.transaction_with_feedback AS
SELECT
  td.*,
  tf.*
FROM default.feedback.transaction_data AS td
LEFT JOIN jb.jbdb.chat_transaction_audit AS tf
  ON tf.jbse_chat_transaction_id = td.transaction_id;
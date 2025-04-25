CREATE SCHEMA IF NOT EXISTS memory.views;

-- PRODUCTION --

CREATE OR REPLACE VIEW memory.views.transaction_data AS
SELECT
  s._id AS session_id,
  s."SolutionId" as session_solution_id,
  t."_id" AS transaction_id,
  t."Type" AS transaction_type,
  t."Channel" AS transaction_channel,
  t."Timestamp" AS timestamp,
  t."Index" AS transaction_index,
  t."Source" AS transaction_source,
  t."Status" AS transaction_status,
  t."AgentId" AS agent_id,
  t."SentByName" AS agent_name,
  t."ReplyToTransaction" AS reply_to_transaction_id,
  t."Message" AS transaction_message,
  t."Value" AS transaction_value,
  t."RequestType" AS request_type,
  t."RequestStatus" AS request_status,
  t."RequestEndTime" AS request_end_time,
  t."RequestData" AS request_data,
  t."Reason" AS request_reason,
  t."Urgency" AS request_urgency,
  t."Options" AS transaction_options,
  t."FileKey" AS file_key,
  t."FileName" AS file_name,
  t."FileSize" AS file_size,
  t."ContentType" AS file_content_type,
  l."_id" AS transaction_loged_data_id,
  l."Records" AS logged_records,
  l."RawInput" AS raw_user_input,
  l."CleanInput" AS clean_user_input,
  l."DetectedLanguageCode" AS detected_language_code,
  l."UsedWords" AS used_words,
  l."UsedIndices" AS used_indices,
  l."LeftUnusedWords" AS left_unused_words,
  l."Context" AS context,
  l."Rank" AS matched_rank,
  l."Layer" AS matched_layer,
  l."TranslatedInput" AS translated_input
FROM prod.session_engine."Transactions" AS t
LEFT JOIN prod.session_engine."Sessions" as s ON t."SessionId" = s._id
LEFT JOIN prod.session_engine_logs."LoggedTransactionData" AS l
  ON t."RelatedDataId" = l._id;

-- 2) Join on MySQL feedback (NULL means “no feedback yet”)
CREATE OR REPLACE VIEW memory.views.transaction_with_feedback AS
SELECT
  td.*,
  tf.*
FROM memory.views.transaction_data AS td
LEFT JOIN jb.jbdb.chat_transaction_audit AS tf
  ON tf.jbse_chat_transaction_id = td.transaction_id;

-- DEVELOPMENT --
CREATE OR REPLACE VIEW memory.views.dev_transaction_data AS
SELECT
  s._id AS session_id,
  s."SolutionId" as session_solution_id,
  t."_id" AS transaction_id,
  t."Type" AS transaction_type,
  t."Channel" AS transaction_channel,
  t."Timestamp" AS timestamp,
  t."Index" AS transaction_index,
  t."Source" AS transaction_source,
  t."Status" AS transaction_status,
  t."AgentId" AS agent_id,
  t."SentByName" AS agent_name,
  t."ReplyToTransaction" AS reply_to_transaction_id,
  t."Message" AS transaction_message,
  t."Value" AS transaction_value,
  t."RequestType" AS request_type,
  t."RequestStatus" AS request_status,
  t."RequestEndTime" AS request_end_time,
  t."RequestData" AS request_data,
  t."Reason" AS request_reason,
  t."Urgency" AS request_urgency,
  t."Options" AS transaction_options,
  t."FileKey" AS file_key,
  t."FileName" AS file_name,
  t."FileSize" AS file_size,
  t."ContentType" AS file_content_type,
  l."_id" AS transaction_loged_data_id,
  l."Records" AS logged_records,
  l."RawInput" AS raw_user_input,
  l."CleanInput" AS clean_user_input,
  l."DetectedLanguageCode" AS detected_language_code,
  l."UsedWords" AS used_words,
  l."UsedIndices" AS used_indices,
  l."LeftUnusedWords" AS left_unused_words,
  l."Context" AS context,
  l."Rank" AS matched_rank,
  l."Layer" AS matched_layer,
  l."TranslatedInput" AS translated_input
FROM dev.session_engine."Transactions" AS t
LEFT JOIN dev.session_engine."Sessions" as s ON t."SessionId" = s._id
LEFT JOIN dev.session_engine_logs."LoggedTransactionData" AS l
  ON t."RelatedDataId" = l._id;

-- 2) Join on MySQL feedback (NULL means “no feedback yet”)
CREATE OR REPLACE VIEW memory.views.dev_transaction_with_feedback AS
SELECT
  td.*,
  tf.*
FROM memory.views.dev_transaction_data AS td
LEFT JOIN jb.jbdb.chat_transaction_audit AS tf
  ON tf.jbse_chat_transaction_id = td.transaction_id;
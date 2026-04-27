--
-- PostgreSQL database dump
--

\restrict erxDdC9Bnc2o0gcpcWluFx0Z4RfNccb6YDeo9MZJuu9TslkbBxGzNB74HZZGDVE

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.store_locale DROP CONSTRAINT store_locale_store_id_foreign;
ALTER TABLE ONLY public.store_currency DROP CONSTRAINT store_currency_store_id_foreign;
ALTER TABLE ONLY public.stock_location DROP CONSTRAINT stock_location_address_id_foreign;
ALTER TABLE ONLY public.shipping_option DROP CONSTRAINT shipping_option_shipping_profile_id_foreign;
ALTER TABLE ONLY public.shipping_option DROP CONSTRAINT shipping_option_shipping_option_type_id_foreign;
ALTER TABLE ONLY public.shipping_option DROP CONSTRAINT shipping_option_service_zone_id_foreign;
ALTER TABLE ONLY public.shipping_option_rule DROP CONSTRAINT shipping_option_rule_shipping_option_id_foreign;
ALTER TABLE ONLY public.shipping_option DROP CONSTRAINT shipping_option_provider_id_foreign;
ALTER TABLE ONLY public.service_zone DROP CONSTRAINT service_zone_fulfillment_set_id_foreign;
ALTER TABLE ONLY public.return_reason DROP CONSTRAINT return_reason_parent_return_reason_id_foreign;
ALTER TABLE ONLY public.reservation_item DROP CONSTRAINT reservation_item_inventory_item_id_foreign;
ALTER TABLE ONLY public.region_country DROP CONSTRAINT region_country_region_id_foreign;
ALTER TABLE ONLY public.refund DROP CONSTRAINT refund_payment_id_foreign;
ALTER TABLE ONLY public.provider_identity DROP CONSTRAINT provider_identity_auth_identity_id_foreign;
ALTER TABLE ONLY public.promotion_rule_value DROP CONSTRAINT promotion_rule_value_promotion_rule_id_foreign;
ALTER TABLE ONLY public.promotion_promotion_rule DROP CONSTRAINT promotion_promotion_rule_promotion_rule_id_foreign;
ALTER TABLE ONLY public.promotion_promotion_rule DROP CONSTRAINT promotion_promotion_rule_promotion_id_foreign;
ALTER TABLE ONLY public.promotion DROP CONSTRAINT promotion_campaign_id_foreign;
ALTER TABLE ONLY public.promotion_campaign_budget_usage DROP CONSTRAINT promotion_campaign_budget_usage_budget_id_foreign;
ALTER TABLE ONLY public.promotion_campaign_budget DROP CONSTRAINT promotion_campaign_budget_campaign_id_foreign;
ALTER TABLE ONLY public.promotion_application_method DROP CONSTRAINT promotion_application_method_promotion_id_foreign;
ALTER TABLE ONLY public.product_variant_product_image DROP CONSTRAINT product_variant_product_image_image_id_foreign;
ALTER TABLE ONLY public.product_variant DROP CONSTRAINT product_variant_product_id_foreign;
ALTER TABLE ONLY public.product_variant_option DROP CONSTRAINT product_variant_option_variant_id_foreign;
ALTER TABLE ONLY public.product_variant_option DROP CONSTRAINT product_variant_option_option_value_id_foreign;
ALTER TABLE ONLY public.product DROP CONSTRAINT product_type_id_foreign;
ALTER TABLE ONLY public.product_tags DROP CONSTRAINT product_tags_product_tag_id_foreign;
ALTER TABLE ONLY public.product_tags DROP CONSTRAINT product_tags_product_id_foreign;
ALTER TABLE ONLY public.product_option_value DROP CONSTRAINT product_option_value_option_id_foreign;
ALTER TABLE ONLY public.product_option DROP CONSTRAINT product_option_product_id_foreign;
ALTER TABLE ONLY public.product DROP CONSTRAINT product_collection_id_foreign;
ALTER TABLE ONLY public.product_category_product DROP CONSTRAINT product_category_product_product_id_foreign;
ALTER TABLE ONLY public.product_category_product DROP CONSTRAINT product_category_product_product_category_id_foreign;
ALTER TABLE ONLY public.product_category DROP CONSTRAINT product_category_parent_category_id_foreign;
ALTER TABLE ONLY public.price_rule DROP CONSTRAINT price_rule_price_id_foreign;
ALTER TABLE ONLY public.price DROP CONSTRAINT price_price_set_id_foreign;
ALTER TABLE ONLY public.price DROP CONSTRAINT price_price_list_id_foreign;
ALTER TABLE ONLY public.price_list_rule DROP CONSTRAINT price_list_rule_price_list_id_foreign;
ALTER TABLE ONLY public.payment_session DROP CONSTRAINT payment_session_payment_collection_id_foreign;
ALTER TABLE ONLY public.payment DROP CONSTRAINT payment_payment_collection_id_foreign;
ALTER TABLE ONLY public.payment_collection_payment_providers DROP CONSTRAINT payment_collection_payment_providers_payment_pro_2d555_foreign;
ALTER TABLE ONLY public.payment_collection_payment_providers DROP CONSTRAINT payment_collection_payment_providers_payment_col_aa276_foreign;
ALTER TABLE ONLY public.order_transaction DROP CONSTRAINT order_transaction_order_id_foreign;
ALTER TABLE ONLY public.order_summary DROP CONSTRAINT order_summary_order_id_foreign;
ALTER TABLE ONLY public.order_shipping DROP CONSTRAINT order_shipping_order_id_foreign;
ALTER TABLE ONLY public.order_shipping_method_tax_line DROP CONSTRAINT order_shipping_method_tax_line_shipping_method_id_foreign;
ALTER TABLE ONLY public.order_shipping_method_adjustment DROP CONSTRAINT order_shipping_method_adjustment_shipping_method_id_foreign;
ALTER TABLE ONLY public."order" DROP CONSTRAINT order_shipping_address_id_foreign;
ALTER TABLE ONLY public.order_line_item DROP CONSTRAINT order_line_item_totals_id_foreign;
ALTER TABLE ONLY public.order_line_item_tax_line DROP CONSTRAINT order_line_item_tax_line_item_id_foreign;
ALTER TABLE ONLY public.order_line_item_adjustment DROP CONSTRAINT order_line_item_adjustment_item_id_foreign;
ALTER TABLE ONLY public.order_item DROP CONSTRAINT order_item_order_id_foreign;
ALTER TABLE ONLY public.order_item DROP CONSTRAINT order_item_item_id_foreign;
ALTER TABLE ONLY public.order_credit_line DROP CONSTRAINT order_credit_line_order_id_foreign;
ALTER TABLE ONLY public.order_change DROP CONSTRAINT order_change_order_id_foreign;
ALTER TABLE ONLY public.order_change_action DROP CONSTRAINT order_change_action_order_change_id_foreign;
ALTER TABLE ONLY public."order" DROP CONSTRAINT order_billing_address_id_foreign;
ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_provider_id_foreign;
ALTER TABLE ONLY public.inventory_level DROP CONSTRAINT inventory_level_inventory_item_id_foreign;
ALTER TABLE ONLY public.image DROP CONSTRAINT image_product_id_foreign;
ALTER TABLE ONLY public.geo_zone DROP CONSTRAINT geo_zone_service_zone_id_foreign;
ALTER TABLE ONLY public.fulfillment DROP CONSTRAINT fulfillment_shipping_option_id_foreign;
ALTER TABLE ONLY public.fulfillment DROP CONSTRAINT fulfillment_provider_id_foreign;
ALTER TABLE ONLY public.fulfillment_label DROP CONSTRAINT fulfillment_label_fulfillment_id_foreign;
ALTER TABLE ONLY public.fulfillment_item DROP CONSTRAINT fulfillment_item_fulfillment_id_foreign;
ALTER TABLE ONLY public.fulfillment DROP CONSTRAINT fulfillment_delivery_address_id_foreign;
ALTER TABLE ONLY public.customer_group_customer DROP CONSTRAINT customer_group_customer_customer_id_foreign;
ALTER TABLE ONLY public.customer_group_customer DROP CONSTRAINT customer_group_customer_customer_group_id_foreign;
ALTER TABLE ONLY public.customer_address DROP CONSTRAINT customer_address_customer_id_foreign;
ALTER TABLE ONLY public.credit_line DROP CONSTRAINT credit_line_cart_id_foreign;
ALTER TABLE ONLY public.cart_shipping_method_tax_line DROP CONSTRAINT cart_shipping_method_tax_line_shipping_method_id_foreign;
ALTER TABLE ONLY public.cart_shipping_method DROP CONSTRAINT cart_shipping_method_cart_id_foreign;
ALTER TABLE ONLY public.cart_shipping_method_adjustment DROP CONSTRAINT cart_shipping_method_adjustment_shipping_method_id_foreign;
ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_shipping_address_id_foreign;
ALTER TABLE ONLY public.cart_line_item_tax_line DROP CONSTRAINT cart_line_item_tax_line_item_id_foreign;
ALTER TABLE ONLY public.cart_line_item DROP CONSTRAINT cart_line_item_cart_id_foreign;
ALTER TABLE ONLY public.cart_line_item_adjustment DROP CONSTRAINT cart_line_item_adjustment_item_id_foreign;
ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_billing_address_id_foreign;
ALTER TABLE ONLY public.capture DROP CONSTRAINT capture_payment_id_foreign;
ALTER TABLE ONLY public.application_method_target_rules DROP CONSTRAINT application_method_target_rules_promotion_rule_id_foreign;
ALTER TABLE ONLY public.application_method_target_rules DROP CONSTRAINT application_method_target_rules_application_method_id_foreign;
ALTER TABLE ONLY public.application_method_buy_rules DROP CONSTRAINT application_method_buy_rules_promotion_rule_id_foreign;
ALTER TABLE ONLY public.application_method_buy_rules DROP CONSTRAINT application_method_buy_rules_application_method_id_foreign;
ALTER TABLE ONLY public.tax_region DROP CONSTRAINT "FK_tax_region_provider_id";
ALTER TABLE ONLY public.tax_region DROP CONSTRAINT "FK_tax_region_parent_id";
ALTER TABLE ONLY public.tax_rate DROP CONSTRAINT "FK_tax_rate_tax_region_id";
ALTER TABLE ONLY public.tax_rate_rule DROP CONSTRAINT "FK_tax_rate_rule_tax_rate_id";
DROP INDEX public.idx_script_name_unique;
DROP INDEX public."IDX_workflow_execution_workflow_id_transaction_id_run_id_unique";
DROP INDEX public."IDX_workflow_execution_workflow_id_transaction_id";
DROP INDEX public."IDX_workflow_execution_workflow_id";
DROP INDEX public."IDX_workflow_execution_updated_at_retention_time";
DROP INDEX public."IDX_workflow_execution_transaction_id";
DROP INDEX public."IDX_workflow_execution_state_updated_at";
DROP INDEX public."IDX_workflow_execution_state";
DROP INDEX public."IDX_workflow_execution_run_id";
DROP INDEX public."IDX_workflow_execution_retention_time_updated_at_state";
DROP INDEX public."IDX_workflow_execution_id";
DROP INDEX public."IDX_workflow_execution_deleted_at";
DROP INDEX public."IDX_view_configuration_user_id";
DROP INDEX public."IDX_view_configuration_entity_user_id";
DROP INDEX public."IDX_view_configuration_entity_is_system_default";
DROP INDEX public."IDX_view_configuration_deleted_at";
DROP INDEX public."IDX_variant_id_52b23597";
DROP INDEX public."IDX_variant_id_17b4c4e35";
DROP INDEX public."IDX_user_preference_user_id_key_unique";
DROP INDEX public."IDX_user_preference_user_id";
DROP INDEX public."IDX_user_preference_deleted_at";
DROP INDEX public."IDX_user_id_64ff0c4c";
DROP INDEX public."IDX_user_email_unique";
DROP INDEX public."IDX_user_deleted_at";
DROP INDEX public."IDX_unique_promotion_code";
DROP INDEX public."IDX_type_value_unique";
DROP INDEX public."IDX_tax_region_unique_country_province";
DROP INDEX public."IDX_tax_region_unique_country_nullable_province";
DROP INDEX public."IDX_tax_region_provider_id";
DROP INDEX public."IDX_tax_region_parent_id";
DROP INDEX public."IDX_tax_region_deleted_at";
DROP INDEX public."IDX_tax_rate_tax_region_id";
DROP INDEX public."IDX_tax_rate_rule_unique_rate_reference";
DROP INDEX public."IDX_tax_rate_rule_tax_rate_id";
DROP INDEX public."IDX_tax_rate_rule_reference_id";
DROP INDEX public."IDX_tax_rate_rule_deleted_at";
DROP INDEX public."IDX_tax_rate_deleted_at";
DROP INDEX public."IDX_tax_provider_deleted_at";
DROP INDEX public."IDX_tag_value_unique";
DROP INDEX public."IDX_store_locale_store_id";
DROP INDEX public."IDX_store_locale_deleted_at";
DROP INDEX public."IDX_store_deleted_at";
DROP INDEX public."IDX_store_currency_store_id";
DROP INDEX public."IDX_store_currency_deleted_at";
DROP INDEX public."IDX_stock_location_id_26d06f470";
DROP INDEX public."IDX_stock_location_id_-e88adb96";
DROP INDEX public."IDX_stock_location_id_-1e5992737";
DROP INDEX public."IDX_stock_location_deleted_at";
DROP INDEX public."IDX_stock_location_address_id_unique";
DROP INDEX public."IDX_stock_location_address_deleted_at";
DROP INDEX public."IDX_single_default_region";
DROP INDEX public."IDX_shipping_profile_name_unique";
DROP INDEX public."IDX_shipping_profile_id_17a262437";
DROP INDEX public."IDX_shipping_profile_deleted_at";
DROP INDEX public."IDX_shipping_option_type_deleted_at";
DROP INDEX public."IDX_shipping_option_shipping_profile_id";
DROP INDEX public."IDX_shipping_option_shipping_option_type_id";
DROP INDEX public."IDX_shipping_option_service_zone_id";
DROP INDEX public."IDX_shipping_option_rule_shipping_option_id";
DROP INDEX public."IDX_shipping_option_rule_deleted_at";
DROP INDEX public."IDX_shipping_option_provider_id";
DROP INDEX public."IDX_shipping_option_id_ba32fa9c";
DROP INDEX public."IDX_shipping_option_deleted_at";
DROP INDEX public."IDX_shipping_method_tax_line_tax_rate_id";
DROP INDEX public."IDX_shipping_method_option_id";
DROP INDEX public."IDX_shipping_method_adjustment_promotion_id";
DROP INDEX public."IDX_service_zone_name_unique";
DROP INDEX public."IDX_service_zone_fulfillment_set_id";
DROP INDEX public."IDX_service_zone_deleted_at";
DROP INDEX public."IDX_sales_channel_id_26d06f470";
DROP INDEX public."IDX_sales_channel_id_20b454295";
DROP INDEX public."IDX_sales_channel_id_-1d67bae40";
DROP INDEX public."IDX_sales_channel_deleted_at";
DROP INDEX public."IDX_return_reason_value";
DROP INDEX public."IDX_return_reason_parent_return_reason_id";
DROP INDEX public."IDX_return_order_id";
DROP INDEX public."IDX_return_item_return_id";
DROP INDEX public."IDX_return_item_reason_id";
DROP INDEX public."IDX_return_item_item_id";
DROP INDEX public."IDX_return_item_deleted_at";
DROP INDEX public."IDX_return_id_-31ea43a";
DROP INDEX public."IDX_return_exchange_id";
DROP INDEX public."IDX_return_display_id";
DROP INDEX public."IDX_return_claim_id";
DROP INDEX public."IDX_reservation_item_location_id";
DROP INDEX public."IDX_reservation_item_line_item_id";
DROP INDEX public."IDX_reservation_item_inventory_item_id";
DROP INDEX public."IDX_reservation_item_deleted_at";
DROP INDEX public."IDX_region_id_1c934dab0";
DROP INDEX public."IDX_region_deleted_at";
DROP INDEX public."IDX_region_country_region_id_iso_2_unique";
DROP INDEX public."IDX_region_country_region_id";
DROP INDEX public."IDX_region_country_deleted_at";
DROP INDEX public."IDX_refund_refund_reason_id";
DROP INDEX public."IDX_refund_reason_deleted_at";
DROP INDEX public."IDX_refund_payment_id";
DROP INDEX public."IDX_refund_deleted_at";
DROP INDEX public."IDX_rbac_role_id_64ff0c4c";
DROP INDEX public."IDX_rbac_role_id_-85069d44";
DROP INDEX public."IDX_publishable_key_id_-1d67bae40";
DROP INDEX public."IDX_provider_identity_provider_entity_id";
DROP INDEX public."IDX_provider_identity_deleted_at";
DROP INDEX public."IDX_provider_identity_auth_identity_id";
DROP INDEX public."IDX_promotion_type";
DROP INDEX public."IDX_promotion_status";
DROP INDEX public."IDX_promotion_rule_value_value";
DROP INDEX public."IDX_promotion_rule_value_rule_id_value";
DROP INDEX public."IDX_promotion_rule_value_promotion_rule_id";
DROP INDEX public."IDX_promotion_rule_value_deleted_at";
DROP INDEX public."IDX_promotion_rule_operator";
DROP INDEX public."IDX_promotion_rule_deleted_at";
DROP INDEX public."IDX_promotion_rule_attribute_operator_id";
DROP INDEX public."IDX_promotion_rule_attribute_operator";
DROP INDEX public."IDX_promotion_rule_attribute";
DROP INDEX public."IDX_promotion_is_automatic";
DROP INDEX public."IDX_promotion_id_-a9d4a70b";
DROP INDEX public."IDX_promotion_id_-71518339";
DROP INDEX public."IDX_promotion_deleted_at";
DROP INDEX public."IDX_promotion_campaign_id";
DROP INDEX public."IDX_promotion_campaign_deleted_at";
DROP INDEX public."IDX_promotion_campaign_campaign_identifier_unique";
DROP INDEX public."IDX_promotion_campaign_budget_usage_deleted_at";
DROP INDEX public."IDX_promotion_campaign_budget_usage_budget_id";
DROP INDEX public."IDX_promotion_campaign_budget_usage_attribute_value_budget_id_u";
DROP INDEX public."IDX_promotion_campaign_budget_deleted_at";
DROP INDEX public."IDX_promotion_campaign_budget_campaign_id_unique";
DROP INDEX public."IDX_promotion_application_method_promotion_id_unique";
DROP INDEX public."IDX_promotion_application_method_deleted_at";
DROP INDEX public."IDX_promotion_application_method_currency_code";
DROP INDEX public."IDX_product_variant_upc_unique";
DROP INDEX public."IDX_product_variant_sku_unique";
DROP INDEX public."IDX_product_variant_product_image_variant_id";
DROP INDEX public."IDX_product_variant_product_image_image_id";
DROP INDEX public."IDX_product_variant_product_image_deleted_at";
DROP INDEX public."IDX_product_variant_product_id";
DROP INDEX public."IDX_product_variant_id_product_id";
DROP INDEX public."IDX_product_variant_ean_unique";
DROP INDEX public."IDX_product_variant_deleted_at";
DROP INDEX public."IDX_product_variant_barcode_unique";
DROP INDEX public."IDX_product_type_id";
DROP INDEX public."IDX_product_type_deleted_at";
DROP INDEX public."IDX_product_tag_deleted_at";
DROP INDEX public."IDX_product_status";
DROP INDEX public."IDX_product_option_value_option_id";
DROP INDEX public."IDX_product_option_value_deleted_at";
DROP INDEX public."IDX_product_option_product_id";
DROP INDEX public."IDX_product_option_deleted_at";
DROP INDEX public."IDX_product_image_url_rank_product_id";
DROP INDEX public."IDX_product_image_url";
DROP INDEX public."IDX_product_image_rank_product_id";
DROP INDEX public."IDX_product_image_rank";
DROP INDEX public."IDX_product_id_20b454295";
DROP INDEX public."IDX_product_id_17a262437";
DROP INDEX public."IDX_product_handle_unique";
DROP INDEX public."IDX_product_deleted_at";
DROP INDEX public."IDX_product_collection_id";
DROP INDEX public."IDX_product_collection_deleted_at";
DROP INDEX public."IDX_product_category_path";
DROP INDEX public."IDX_product_category_parent_category_id";
DROP INDEX public."IDX_price_set_id_ba32fa9c";
DROP INDEX public."IDX_price_set_id_52b23597";
DROP INDEX public."IDX_price_set_deleted_at";
DROP INDEX public."IDX_price_rule_price_id_attribute_operator_unique";
DROP INDEX public."IDX_price_rule_price_id";
DROP INDEX public."IDX_price_rule_operator_value";
DROP INDEX public."IDX_price_rule_operator";
DROP INDEX public."IDX_price_rule_deleted_at";
DROP INDEX public."IDX_price_rule_attribute_value_price_id";
DROP INDEX public."IDX_price_rule_attribute_value";
DROP INDEX public."IDX_price_rule_attribute";
DROP INDEX public."IDX_price_price_set_id";
DROP INDEX public."IDX_price_price_list_id";
DROP INDEX public."IDX_price_preference_deleted_at";
DROP INDEX public."IDX_price_preference_attribute_value";
DROP INDEX public."IDX_price_list_rule_value";
DROP INDEX public."IDX_price_list_rule_price_list_id";
DROP INDEX public."IDX_price_list_rule_deleted_at";
DROP INDEX public."IDX_price_list_rule_attribute";
DROP INDEX public."IDX_price_list_id_status_starts_at_ends_at";
DROP INDEX public."IDX_price_list_deleted_at";
DROP INDEX public."IDX_price_deleted_at";
DROP INDEX public."IDX_price_currency_code";
DROP INDEX public."IDX_payment_session_payment_collection_id";
DROP INDEX public."IDX_payment_session_deleted_at";
DROP INDEX public."IDX_payment_provider_id_1c934dab0";
DROP INDEX public."IDX_payment_provider_id";
DROP INDEX public."IDX_payment_provider_deleted_at";
DROP INDEX public."IDX_payment_payment_session_id_unique";
DROP INDEX public."IDX_payment_payment_session_id";
DROP INDEX public."IDX_payment_payment_collection_id";
DROP INDEX public."IDX_payment_deleted_at";
DROP INDEX public."IDX_payment_collection_id_f42b9949";
DROP INDEX public."IDX_payment_collection_id_-4a39f6c9";
DROP INDEX public."IDX_payment_collection_deleted_at";
DROP INDEX public."IDX_order_transaction_return_id";
DROP INDEX public."IDX_order_transaction_reference_id";
DROP INDEX public."IDX_order_transaction_order_id_version";
DROP INDEX public."IDX_order_transaction_order_id";
DROP INDEX public."IDX_order_transaction_exchange_id";
DROP INDEX public."IDX_order_transaction_currency_code";
DROP INDEX public."IDX_order_transaction_claim_id";
DROP INDEX public."IDX_order_summary_order_id_version";
DROP INDEX public."IDX_order_summary_deleted_at";
DROP INDEX public."IDX_order_shipping_shipping_method_id";
DROP INDEX public."IDX_order_shipping_return_id";
DROP INDEX public."IDX_order_shipping_order_id_version";
DROP INDEX public."IDX_order_shipping_order_id";
DROP INDEX public."IDX_order_shipping_method_tax_line_shipping_method_id";
DROP INDEX public."IDX_order_shipping_method_shipping_option_id";
DROP INDEX public."IDX_order_shipping_method_adjustment_shipping_method_id";
DROP INDEX public."IDX_order_shipping_item_id";
DROP INDEX public."IDX_order_shipping_exchange_id";
DROP INDEX public."IDX_order_shipping_deleted_at";
DROP INDEX public."IDX_order_shipping_claim_id";
DROP INDEX public."IDX_order_shipping_address_id";
DROP INDEX public."IDX_order_sales_channel_id";
DROP INDEX public."IDX_order_region_id";
DROP INDEX public."IDX_order_line_item_variant_id";
DROP INDEX public."IDX_order_line_item_tax_line_item_id";
DROP INDEX public."IDX_order_line_item_product_id";
DROP INDEX public."IDX_order_line_item_adjustment_item_id";
DROP INDEX public."IDX_order_item_order_id_version";
DROP INDEX public."IDX_order_item_order_id";
DROP INDEX public."IDX_order_item_item_id";
DROP INDEX public."IDX_order_item_deleted_at";
DROP INDEX public."IDX_order_is_draft_order";
DROP INDEX public."IDX_order_id_f42b9949";
DROP INDEX public."IDX_order_id_-e8d2543e";
DROP INDEX public."IDX_order_id_-71518339";
DROP INDEX public."IDX_order_id_-71069c16";
DROP INDEX public."IDX_order_exchange_return_id";
DROP INDEX public."IDX_order_exchange_order_id";
DROP INDEX public."IDX_order_exchange_item_item_id";
DROP INDEX public."IDX_order_exchange_item_exchange_id";
DROP INDEX public."IDX_order_exchange_item_deleted_at";
DROP INDEX public."IDX_order_exchange_display_id";
DROP INDEX public."IDX_order_exchange_deleted_at";
DROP INDEX public."IDX_order_display_id";
DROP INDEX public."IDX_order_deleted_at";
DROP INDEX public."IDX_order_customer_id";
DROP INDEX public."IDX_order_custom_display_id";
DROP INDEX public."IDX_order_currency_code";
DROP INDEX public."IDX_order_credit_line_order_id_version";
DROP INDEX public."IDX_order_credit_line_order_id";
DROP INDEX public."IDX_order_credit_line_deleted_at";
DROP INDEX public."IDX_order_claim_return_id";
DROP INDEX public."IDX_order_claim_order_id";
DROP INDEX public."IDX_order_claim_item_item_id";
DROP INDEX public."IDX_order_claim_item_image_deleted_at";
DROP INDEX public."IDX_order_claim_item_image_claim_item_id";
DROP INDEX public."IDX_order_claim_item_deleted_at";
DROP INDEX public."IDX_order_claim_item_claim_id";
DROP INDEX public."IDX_order_claim_display_id";
DROP INDEX public."IDX_order_claim_deleted_at";
DROP INDEX public."IDX_order_change_version";
DROP INDEX public."IDX_order_change_status";
DROP INDEX public."IDX_order_change_return_id";
DROP INDEX public."IDX_order_change_order_id_version";
DROP INDEX public."IDX_order_change_order_id";
DROP INDEX public."IDX_order_change_exchange_id";
DROP INDEX public."IDX_order_change_deleted_at";
DROP INDEX public."IDX_order_change_claim_id";
DROP INDEX public."IDX_order_change_change_type";
DROP INDEX public."IDX_order_change_action_return_id";
DROP INDEX public."IDX_order_change_action_ordering";
DROP INDEX public."IDX_order_change_action_order_id";
DROP INDEX public."IDX_order_change_action_order_change_id";
DROP INDEX public."IDX_order_change_action_exchange_id";
DROP INDEX public."IDX_order_change_action_deleted_at";
DROP INDEX public."IDX_order_change_action_claim_id";
DROP INDEX public."IDX_order_billing_address_id";
DROP INDEX public."IDX_order_address_deleted_at";
DROP INDEX public."IDX_order_address_customer_id";
DROP INDEX public."IDX_option_value_option_id_unique";
DROP INDEX public."IDX_option_product_id_title_unique";
DROP INDEX public."IDX_notification_receiver_id";
DROP INDEX public."IDX_notification_provider_id";
DROP INDEX public."IDX_notification_provider_deleted_at";
DROP INDEX public."IDX_notification_idempotency_key_unique";
DROP INDEX public."IDX_notification_deleted_at";
DROP INDEX public."IDX_line_item_variant_id";
DROP INDEX public."IDX_line_item_tax_line_tax_rate_id";
DROP INDEX public."IDX_line_item_product_type_id";
DROP INDEX public."IDX_line_item_product_id";
DROP INDEX public."IDX_line_item_adjustment_promotion_id";
DROP INDEX public."IDX_invite_token";
DROP INDEX public."IDX_invite_id_-85069d44";
DROP INDEX public."IDX_invite_email_unique";
DROP INDEX public."IDX_invite_deleted_at";
DROP INDEX public."IDX_inventory_level_location_id_inventory_item_id";
DROP INDEX public."IDX_inventory_level_location_id";
DROP INDEX public."IDX_inventory_level_inventory_item_id";
DROP INDEX public."IDX_inventory_level_deleted_at";
DROP INDEX public."IDX_inventory_item_sku";
DROP INDEX public."IDX_inventory_item_id_17b4c4e35";
DROP INDEX public."IDX_inventory_item_deleted_at";
DROP INDEX public."IDX_image_product_id";
DROP INDEX public."IDX_image_deleted_at";
DROP INDEX public."IDX_id_f42b9949";
DROP INDEX public."IDX_id_ba32fa9c";
DROP INDEX public."IDX_id_64ff0c4c";
DROP INDEX public."IDX_id_5cb3a0c0";
DROP INDEX public."IDX_id_52b23597";
DROP INDEX public."IDX_id_26d06f470";
DROP INDEX public."IDX_id_20b454295";
DROP INDEX public."IDX_id_1c934dab0";
DROP INDEX public."IDX_id_17b4c4e35";
DROP INDEX public."IDX_id_17a262437";
DROP INDEX public."IDX_id_-e8d2543e";
DROP INDEX public."IDX_id_-e88adb96";
DROP INDEX public."IDX_id_-a9d4a70b";
DROP INDEX public."IDX_id_-85069d44";
DROP INDEX public."IDX_id_-71518339";
DROP INDEX public."IDX_id_-71069c16";
DROP INDEX public."IDX_id_-4a39f6c9";
DROP INDEX public."IDX_id_-31ea43a";
DROP INDEX public."IDX_id_-1e5992737";
DROP INDEX public."IDX_id_-1d67bae40";
DROP INDEX public."IDX_geo_zone_service_zone_id";
DROP INDEX public."IDX_geo_zone_province_code";
DROP INDEX public."IDX_geo_zone_deleted_at";
DROP INDEX public."IDX_geo_zone_country_code";
DROP INDEX public."IDX_geo_zone_city";
DROP INDEX public."IDX_fulfillment_shipping_option_id";
DROP INDEX public."IDX_fulfillment_set_name_unique";
DROP INDEX public."IDX_fulfillment_set_id_-e88adb96";
DROP INDEX public."IDX_fulfillment_set_deleted_at";
DROP INDEX public."IDX_fulfillment_provider_id_-1e5992737";
DROP INDEX public."IDX_fulfillment_provider_deleted_at";
DROP INDEX public."IDX_fulfillment_location_id";
DROP INDEX public."IDX_fulfillment_label_fulfillment_id";
DROP INDEX public."IDX_fulfillment_label_deleted_at";
DROP INDEX public."IDX_fulfillment_item_line_item_id";
DROP INDEX public."IDX_fulfillment_item_inventory_item_id";
DROP INDEX public."IDX_fulfillment_item_fulfillment_id";
DROP INDEX public."IDX_fulfillment_item_deleted_at";
DROP INDEX public."IDX_fulfillment_id_-e8d2543e";
DROP INDEX public."IDX_fulfillment_id_-31ea43a";
DROP INDEX public."IDX_fulfillment_deleted_at";
DROP INDEX public."IDX_fulfillment_address_deleted_at";
DROP INDEX public."IDX_deleted_at_f42b9949";
DROP INDEX public."IDX_deleted_at_ba32fa9c";
DROP INDEX public."IDX_deleted_at_64ff0c4c";
DROP INDEX public."IDX_deleted_at_5cb3a0c0";
DROP INDEX public."IDX_deleted_at_52b23597";
DROP INDEX public."IDX_deleted_at_26d06f470";
DROP INDEX public."IDX_deleted_at_20b454295";
DROP INDEX public."IDX_deleted_at_1c934dab0";
DROP INDEX public."IDX_deleted_at_17b4c4e35";
DROP INDEX public."IDX_deleted_at_17a262437";
DROP INDEX public."IDX_deleted_at_-e8d2543e";
DROP INDEX public."IDX_deleted_at_-e88adb96";
DROP INDEX public."IDX_deleted_at_-a9d4a70b";
DROP INDEX public."IDX_deleted_at_-85069d44";
DROP INDEX public."IDX_deleted_at_-71518339";
DROP INDEX public."IDX_deleted_at_-71069c16";
DROP INDEX public."IDX_deleted_at_-4a39f6c9";
DROP INDEX public."IDX_deleted_at_-31ea43a";
DROP INDEX public."IDX_deleted_at_-1e5992737";
DROP INDEX public."IDX_deleted_at_-1d67bae40";
DROP INDEX public."IDX_customer_id_5cb3a0c0";
DROP INDEX public."IDX_customer_group_name_unique";
DROP INDEX public."IDX_customer_group_deleted_at";
DROP INDEX public."IDX_customer_group_customer_deleted_at";
DROP INDEX public."IDX_customer_group_customer_customer_id";
DROP INDEX public."IDX_customer_group_customer_customer_group_id";
DROP INDEX public."IDX_customer_email_has_account_unique";
DROP INDEX public."IDX_customer_deleted_at";
DROP INDEX public."IDX_customer_address_unique_customer_shipping";
DROP INDEX public."IDX_customer_address_unique_customer_billing";
DROP INDEX public."IDX_customer_address_deleted_at";
DROP INDEX public."IDX_customer_address_customer_id";
DROP INDEX public."IDX_credit_line_deleted_at";
DROP INDEX public."IDX_credit_line_cart_id";
DROP INDEX public."IDX_collection_handle_unique";
DROP INDEX public."IDX_category_handle_unique";
DROP INDEX public."IDX_cart_shipping_method_tax_line_shipping_method_id";
DROP INDEX public."IDX_cart_shipping_method_tax_line_deleted_at";
DROP INDEX public."IDX_cart_shipping_method_deleted_at";
DROP INDEX public."IDX_cart_shipping_method_cart_id";
DROP INDEX public."IDX_cart_shipping_method_adjustment_shipping_method_id";
DROP INDEX public."IDX_cart_shipping_method_adjustment_deleted_at";
DROP INDEX public."IDX_cart_shipping_address_id";
DROP INDEX public."IDX_cart_sales_channel_id";
DROP INDEX public."IDX_cart_region_id";
DROP INDEX public."IDX_cart_line_item_tax_line_item_id";
DROP INDEX public."IDX_cart_line_item_tax_line_deleted_at";
DROP INDEX public."IDX_cart_line_item_deleted_at";
DROP INDEX public."IDX_cart_line_item_cart_id";
DROP INDEX public."IDX_cart_line_item_adjustment_item_id";
DROP INDEX public."IDX_cart_line_item_adjustment_deleted_at";
DROP INDEX public."IDX_cart_id_-a9d4a70b";
DROP INDEX public."IDX_cart_id_-71069c16";
DROP INDEX public."IDX_cart_id_-4a39f6c9";
DROP INDEX public."IDX_cart_deleted_at";
DROP INDEX public."IDX_cart_customer_id";
DROP INDEX public."IDX_cart_currency_code";
DROP INDEX public."IDX_cart_credit_line_reference_reference_id";
DROP INDEX public."IDX_cart_billing_address_id";
DROP INDEX public."IDX_cart_address_deleted_at";
DROP INDEX public."IDX_capture_payment_id";
DROP INDEX public."IDX_capture_deleted_at";
DROP INDEX public."IDX_campaign_budget_type";
DROP INDEX public."IDX_auth_identity_deleted_at";
DROP INDEX public."IDX_application_method_type";
DROP INDEX public."IDX_application_method_target_type";
DROP INDEX public."IDX_application_method_allocation";
DROP INDEX public."IDX_api_key_type";
DROP INDEX public."IDX_api_key_token_unique";
DROP INDEX public."IDX_api_key_revoked_at";
DROP INDEX public."IDX_api_key_redacted";
DROP INDEX public."IDX_api_key_deleted_at";
DROP INDEX public."IDX_account_holder_provider_id_external_id_unique";
DROP INDEX public."IDX_account_holder_id_5cb3a0c0";
DROP INDEX public."IDX_account_holder_deleted_at";
ALTER TABLE ONLY public.workflow_execution DROP CONSTRAINT workflow_execution_pkey;
ALTER TABLE ONLY public.view_configuration DROP CONSTRAINT view_configuration_pkey;
ALTER TABLE ONLY public.user_rbac_role DROP CONSTRAINT user_rbac_role_pkey;
ALTER TABLE ONLY public.user_preference DROP CONSTRAINT user_preference_pkey;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
ALTER TABLE ONLY public.tax_region DROP CONSTRAINT tax_region_pkey;
ALTER TABLE ONLY public.tax_rate_rule DROP CONSTRAINT tax_rate_rule_pkey;
ALTER TABLE ONLY public.tax_rate DROP CONSTRAINT tax_rate_pkey;
ALTER TABLE ONLY public.tax_provider DROP CONSTRAINT tax_provider_pkey;
ALTER TABLE ONLY public.store DROP CONSTRAINT store_pkey;
ALTER TABLE ONLY public.store_locale DROP CONSTRAINT store_locale_pkey;
ALTER TABLE ONLY public.store_currency DROP CONSTRAINT store_currency_pkey;
ALTER TABLE ONLY public.stock_location DROP CONSTRAINT stock_location_pkey;
ALTER TABLE ONLY public.stock_location_address DROP CONSTRAINT stock_location_address_pkey;
ALTER TABLE ONLY public.shipping_profile DROP CONSTRAINT shipping_profile_pkey;
ALTER TABLE ONLY public.shipping_option_type DROP CONSTRAINT shipping_option_type_pkey;
ALTER TABLE ONLY public.shipping_option_rule DROP CONSTRAINT shipping_option_rule_pkey;
ALTER TABLE ONLY public.shipping_option_price_set DROP CONSTRAINT shipping_option_price_set_pkey;
ALTER TABLE ONLY public.shipping_option DROP CONSTRAINT shipping_option_pkey;
ALTER TABLE ONLY public.service_zone DROP CONSTRAINT service_zone_pkey;
ALTER TABLE ONLY public.script_migrations DROP CONSTRAINT script_migrations_pkey;
ALTER TABLE ONLY public.sales_channel_stock_location DROP CONSTRAINT sales_channel_stock_location_pkey;
ALTER TABLE ONLY public.sales_channel DROP CONSTRAINT sales_channel_pkey;
ALTER TABLE ONLY public.return_reason DROP CONSTRAINT return_reason_pkey;
ALTER TABLE ONLY public.return DROP CONSTRAINT return_pkey;
ALTER TABLE ONLY public.return_item DROP CONSTRAINT return_item_pkey;
ALTER TABLE ONLY public.return_fulfillment DROP CONSTRAINT return_fulfillment_pkey;
ALTER TABLE ONLY public.reservation_item DROP CONSTRAINT reservation_item_pkey;
ALTER TABLE ONLY public.region DROP CONSTRAINT region_pkey;
ALTER TABLE ONLY public.region_payment_provider DROP CONSTRAINT region_payment_provider_pkey;
ALTER TABLE ONLY public.region_country DROP CONSTRAINT region_country_pkey;
ALTER TABLE ONLY public.refund_reason DROP CONSTRAINT refund_reason_pkey;
ALTER TABLE ONLY public.refund DROP CONSTRAINT refund_pkey;
ALTER TABLE ONLY public.publishable_api_key_sales_channel DROP CONSTRAINT publishable_api_key_sales_channel_pkey;
ALTER TABLE ONLY public.provider_identity DROP CONSTRAINT provider_identity_pkey;
ALTER TABLE ONLY public.promotion_rule_value DROP CONSTRAINT promotion_rule_value_pkey;
ALTER TABLE ONLY public.promotion_rule DROP CONSTRAINT promotion_rule_pkey;
ALTER TABLE ONLY public.promotion_promotion_rule DROP CONSTRAINT promotion_promotion_rule_pkey;
ALTER TABLE ONLY public.promotion DROP CONSTRAINT promotion_pkey;
ALTER TABLE ONLY public.promotion_campaign DROP CONSTRAINT promotion_campaign_pkey;
ALTER TABLE ONLY public.promotion_campaign_budget_usage DROP CONSTRAINT promotion_campaign_budget_usage_pkey;
ALTER TABLE ONLY public.promotion_campaign_budget DROP CONSTRAINT promotion_campaign_budget_pkey;
ALTER TABLE ONLY public.promotion_application_method DROP CONSTRAINT promotion_application_method_pkey;
ALTER TABLE ONLY public.product_variant_product_image DROP CONSTRAINT product_variant_product_image_pkey;
ALTER TABLE ONLY public.product_variant_price_set DROP CONSTRAINT product_variant_price_set_pkey;
ALTER TABLE ONLY public.product_variant DROP CONSTRAINT product_variant_pkey;
ALTER TABLE ONLY public.product_variant_option DROP CONSTRAINT product_variant_option_pkey;
ALTER TABLE ONLY public.product_variant_inventory_item DROP CONSTRAINT product_variant_inventory_item_pkey;
ALTER TABLE ONLY public.product_type DROP CONSTRAINT product_type_pkey;
ALTER TABLE ONLY public.product_tags DROP CONSTRAINT product_tags_pkey;
ALTER TABLE ONLY public.product_tag DROP CONSTRAINT product_tag_pkey;
ALTER TABLE ONLY public.product_shipping_profile DROP CONSTRAINT product_shipping_profile_pkey;
ALTER TABLE ONLY public.product_sales_channel DROP CONSTRAINT product_sales_channel_pkey;
ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
ALTER TABLE ONLY public.product_option_value DROP CONSTRAINT product_option_value_pkey;
ALTER TABLE ONLY public.product_option DROP CONSTRAINT product_option_pkey;
ALTER TABLE ONLY public.product_collection DROP CONSTRAINT product_collection_pkey;
ALTER TABLE ONLY public.product_category_product DROP CONSTRAINT product_category_product_pkey;
ALTER TABLE ONLY public.product_category DROP CONSTRAINT product_category_pkey;
ALTER TABLE ONLY public.price_set DROP CONSTRAINT price_set_pkey;
ALTER TABLE ONLY public.price_rule DROP CONSTRAINT price_rule_pkey;
ALTER TABLE ONLY public.price_preference DROP CONSTRAINT price_preference_pkey;
ALTER TABLE ONLY public.price DROP CONSTRAINT price_pkey;
ALTER TABLE ONLY public.price_list_rule DROP CONSTRAINT price_list_rule_pkey;
ALTER TABLE ONLY public.price_list DROP CONSTRAINT price_list_pkey;
ALTER TABLE ONLY public.payment_session DROP CONSTRAINT payment_session_pkey;
ALTER TABLE ONLY public.payment_provider DROP CONSTRAINT payment_provider_pkey;
ALTER TABLE ONLY public.payment DROP CONSTRAINT payment_pkey;
ALTER TABLE ONLY public.payment_collection DROP CONSTRAINT payment_collection_pkey;
ALTER TABLE ONLY public.payment_collection_payment_providers DROP CONSTRAINT payment_collection_payment_providers_pkey;
ALTER TABLE ONLY public.order_transaction DROP CONSTRAINT order_transaction_pkey;
ALTER TABLE ONLY public.order_summary DROP CONSTRAINT order_summary_pkey;
ALTER TABLE ONLY public.order_shipping DROP CONSTRAINT order_shipping_pkey;
ALTER TABLE ONLY public.order_shipping_method_tax_line DROP CONSTRAINT order_shipping_method_tax_line_pkey;
ALTER TABLE ONLY public.order_shipping_method DROP CONSTRAINT order_shipping_method_pkey;
ALTER TABLE ONLY public.order_shipping_method_adjustment DROP CONSTRAINT order_shipping_method_adjustment_pkey;
ALTER TABLE ONLY public.order_promotion DROP CONSTRAINT order_promotion_pkey;
ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
ALTER TABLE ONLY public.order_payment_collection DROP CONSTRAINT order_payment_collection_pkey;
ALTER TABLE ONLY public.order_line_item_tax_line DROP CONSTRAINT order_line_item_tax_line_pkey;
ALTER TABLE ONLY public.order_line_item DROP CONSTRAINT order_line_item_pkey;
ALTER TABLE ONLY public.order_line_item_adjustment DROP CONSTRAINT order_line_item_adjustment_pkey;
ALTER TABLE ONLY public.order_item DROP CONSTRAINT order_item_pkey;
ALTER TABLE ONLY public.order_fulfillment DROP CONSTRAINT order_fulfillment_pkey;
ALTER TABLE ONLY public.order_exchange DROP CONSTRAINT order_exchange_pkey;
ALTER TABLE ONLY public.order_exchange_item DROP CONSTRAINT order_exchange_item_pkey;
ALTER TABLE ONLY public.order_credit_line DROP CONSTRAINT order_credit_line_pkey;
ALTER TABLE ONLY public.order_claim DROP CONSTRAINT order_claim_pkey;
ALTER TABLE ONLY public.order_claim_item DROP CONSTRAINT order_claim_item_pkey;
ALTER TABLE ONLY public.order_claim_item_image DROP CONSTRAINT order_claim_item_image_pkey;
ALTER TABLE ONLY public.order_change DROP CONSTRAINT order_change_pkey;
ALTER TABLE ONLY public.order_change_action DROP CONSTRAINT order_change_action_pkey;
ALTER TABLE ONLY public.order_cart DROP CONSTRAINT order_cart_pkey;
ALTER TABLE ONLY public.order_address DROP CONSTRAINT order_address_pkey;
ALTER TABLE ONLY public.notification_provider DROP CONSTRAINT notification_provider_pkey;
ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_pkey;
ALTER TABLE ONLY public.mikro_orm_migrations DROP CONSTRAINT mikro_orm_migrations_pkey;
ALTER TABLE ONLY public.location_fulfillment_set DROP CONSTRAINT location_fulfillment_set_pkey;
ALTER TABLE ONLY public.location_fulfillment_provider DROP CONSTRAINT location_fulfillment_provider_pkey;
ALTER TABLE ONLY public.link_module_migrations DROP CONSTRAINT link_module_migrations_table_name_key;
ALTER TABLE ONLY public.link_module_migrations DROP CONSTRAINT link_module_migrations_pkey;
ALTER TABLE ONLY public.invite_rbac_role DROP CONSTRAINT invite_rbac_role_pkey;
ALTER TABLE ONLY public.invite DROP CONSTRAINT invite_pkey;
ALTER TABLE ONLY public.inventory_level DROP CONSTRAINT inventory_level_pkey;
ALTER TABLE ONLY public.inventory_item DROP CONSTRAINT inventory_item_pkey;
ALTER TABLE ONLY public.image DROP CONSTRAINT image_pkey;
ALTER TABLE ONLY public.geo_zone DROP CONSTRAINT geo_zone_pkey;
ALTER TABLE ONLY public.fulfillment_set DROP CONSTRAINT fulfillment_set_pkey;
ALTER TABLE ONLY public.fulfillment_provider DROP CONSTRAINT fulfillment_provider_pkey;
ALTER TABLE ONLY public.fulfillment DROP CONSTRAINT fulfillment_pkey;
ALTER TABLE ONLY public.fulfillment_label DROP CONSTRAINT fulfillment_label_pkey;
ALTER TABLE ONLY public.fulfillment_item DROP CONSTRAINT fulfillment_item_pkey;
ALTER TABLE ONLY public.fulfillment_address DROP CONSTRAINT fulfillment_address_pkey;
ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
ALTER TABLE ONLY public.customer_group DROP CONSTRAINT customer_group_pkey;
ALTER TABLE ONLY public.customer_group_customer DROP CONSTRAINT customer_group_customer_pkey;
ALTER TABLE ONLY public.customer_address DROP CONSTRAINT customer_address_pkey;
ALTER TABLE ONLY public.customer_account_holder DROP CONSTRAINT customer_account_holder_pkey;
ALTER TABLE ONLY public.currency DROP CONSTRAINT currency_pkey;
ALTER TABLE ONLY public.credit_line DROP CONSTRAINT credit_line_pkey;
ALTER TABLE ONLY public.cart_shipping_method_tax_line DROP CONSTRAINT cart_shipping_method_tax_line_pkey;
ALTER TABLE ONLY public.cart_shipping_method DROP CONSTRAINT cart_shipping_method_pkey;
ALTER TABLE ONLY public.cart_shipping_method_adjustment DROP CONSTRAINT cart_shipping_method_adjustment_pkey;
ALTER TABLE ONLY public.cart_promotion DROP CONSTRAINT cart_promotion_pkey;
ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pkey;
ALTER TABLE ONLY public.cart_payment_collection DROP CONSTRAINT cart_payment_collection_pkey;
ALTER TABLE ONLY public.cart_line_item_tax_line DROP CONSTRAINT cart_line_item_tax_line_pkey;
ALTER TABLE ONLY public.cart_line_item DROP CONSTRAINT cart_line_item_pkey;
ALTER TABLE ONLY public.cart_line_item_adjustment DROP CONSTRAINT cart_line_item_adjustment_pkey;
ALTER TABLE ONLY public.cart_address DROP CONSTRAINT cart_address_pkey;
ALTER TABLE ONLY public.capture DROP CONSTRAINT capture_pkey;
ALTER TABLE ONLY public.auth_identity DROP CONSTRAINT auth_identity_pkey;
ALTER TABLE ONLY public.application_method_target_rules DROP CONSTRAINT application_method_target_rules_pkey;
ALTER TABLE ONLY public.application_method_buy_rules DROP CONSTRAINT application_method_buy_rules_pkey;
ALTER TABLE ONLY public.api_key DROP CONSTRAINT api_key_pkey;
ALTER TABLE ONLY public.account_holder DROP CONSTRAINT account_holder_pkey;
ALTER TABLE public.script_migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.return ALTER COLUMN display_id DROP DEFAULT;
ALTER TABLE public.order_exchange ALTER COLUMN display_id DROP DEFAULT;
ALTER TABLE public.order_claim ALTER COLUMN display_id DROP DEFAULT;
ALTER TABLE public.order_change_action ALTER COLUMN ordering DROP DEFAULT;
ALTER TABLE public."order" ALTER COLUMN display_id DROP DEFAULT;
ALTER TABLE public.mikro_orm_migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.link_module_migrations ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.workflow_execution;
DROP TABLE public.view_configuration;
DROP TABLE public.user_rbac_role;
DROP TABLE public.user_preference;
DROP TABLE public."user";
DROP TABLE public.tax_region;
DROP TABLE public.tax_rate_rule;
DROP TABLE public.tax_rate;
DROP TABLE public.tax_provider;
DROP TABLE public.store_locale;
DROP TABLE public.store_currency;
DROP TABLE public.store;
DROP TABLE public.stock_location_address;
DROP TABLE public.stock_location;
DROP TABLE public.shipping_profile;
DROP TABLE public.shipping_option_type;
DROP TABLE public.shipping_option_rule;
DROP TABLE public.shipping_option_price_set;
DROP TABLE public.shipping_option;
DROP TABLE public.service_zone;
DROP SEQUENCE public.script_migrations_id_seq;
DROP TABLE public.script_migrations;
DROP TABLE public.sales_channel_stock_location;
DROP TABLE public.sales_channel;
DROP TABLE public.return_reason;
DROP TABLE public.return_item;
DROP TABLE public.return_fulfillment;
DROP SEQUENCE public.return_display_id_seq;
DROP TABLE public.return;
DROP TABLE public.reservation_item;
DROP TABLE public.region_payment_provider;
DROP TABLE public.region_country;
DROP TABLE public.region;
DROP TABLE public.refund_reason;
DROP TABLE public.refund;
DROP TABLE public.publishable_api_key_sales_channel;
DROP TABLE public.provider_identity;
DROP TABLE public.promotion_rule_value;
DROP TABLE public.promotion_rule;
DROP TABLE public.promotion_promotion_rule;
DROP TABLE public.promotion_campaign_budget_usage;
DROP TABLE public.promotion_campaign_budget;
DROP TABLE public.promotion_campaign;
DROP TABLE public.promotion_application_method;
DROP TABLE public.promotion;
DROP TABLE public.product_variant_product_image;
DROP TABLE public.product_variant_price_set;
DROP TABLE public.product_variant_option;
DROP TABLE public.product_variant_inventory_item;
DROP TABLE public.product_variant;
DROP TABLE public.product_type;
DROP TABLE public.product_tags;
DROP TABLE public.product_tag;
DROP TABLE public.product_shipping_profile;
DROP TABLE public.product_sales_channel;
DROP TABLE public.product_option_value;
DROP TABLE public.product_option;
DROP TABLE public.product_collection;
DROP TABLE public.product_category_product;
DROP TABLE public.product_category;
DROP TABLE public.product;
DROP TABLE public.price_set;
DROP TABLE public.price_rule;
DROP TABLE public.price_preference;
DROP TABLE public.price_list_rule;
DROP TABLE public.price_list;
DROP TABLE public.price;
DROP TABLE public.payment_session;
DROP TABLE public.payment_provider;
DROP TABLE public.payment_collection_payment_providers;
DROP TABLE public.payment_collection;
DROP TABLE public.payment;
DROP TABLE public.order_transaction;
DROP TABLE public.order_summary;
DROP TABLE public.order_shipping_method_tax_line;
DROP TABLE public.order_shipping_method_adjustment;
DROP TABLE public.order_shipping_method;
DROP TABLE public.order_shipping;
DROP TABLE public.order_promotion;
DROP TABLE public.order_payment_collection;
DROP TABLE public.order_line_item_tax_line;
DROP TABLE public.order_line_item_adjustment;
DROP TABLE public.order_line_item;
DROP TABLE public.order_item;
DROP TABLE public.order_fulfillment;
DROP TABLE public.order_exchange_item;
DROP SEQUENCE public.order_exchange_display_id_seq;
DROP TABLE public.order_exchange;
DROP SEQUENCE public.order_display_id_seq;
DROP TABLE public.order_credit_line;
DROP TABLE public.order_claim_item_image;
DROP TABLE public.order_claim_item;
DROP SEQUENCE public.order_claim_display_id_seq;
DROP TABLE public.order_claim;
DROP SEQUENCE public.order_change_action_ordering_seq;
DROP TABLE public.order_change_action;
DROP TABLE public.order_change;
DROP TABLE public.order_cart;
DROP TABLE public.order_address;
DROP TABLE public."order";
DROP TABLE public.notification_provider;
DROP TABLE public.notification;
DROP SEQUENCE public.mikro_orm_migrations_id_seq;
DROP TABLE public.mikro_orm_migrations;
DROP TABLE public.location_fulfillment_set;
DROP TABLE public.location_fulfillment_provider;
DROP SEQUENCE public.link_module_migrations_id_seq;
DROP TABLE public.link_module_migrations;
DROP TABLE public.invite_rbac_role;
DROP TABLE public.invite;
DROP TABLE public.inventory_level;
DROP TABLE public.inventory_item;
DROP TABLE public.image;
DROP TABLE public.geo_zone;
DROP TABLE public.fulfillment_set;
DROP TABLE public.fulfillment_provider;
DROP TABLE public.fulfillment_label;
DROP TABLE public.fulfillment_item;
DROP TABLE public.fulfillment_address;
DROP TABLE public.fulfillment;
DROP TABLE public.customer_group_customer;
DROP TABLE public.customer_group;
DROP TABLE public.customer_address;
DROP TABLE public.customer_account_holder;
DROP TABLE public.customer;
DROP TABLE public.currency;
DROP TABLE public.credit_line;
DROP TABLE public.cart_shipping_method_tax_line;
DROP TABLE public.cart_shipping_method_adjustment;
DROP TABLE public.cart_shipping_method;
DROP TABLE public.cart_promotion;
DROP TABLE public.cart_payment_collection;
DROP TABLE public.cart_line_item_tax_line;
DROP TABLE public.cart_line_item_adjustment;
DROP TABLE public.cart_line_item;
DROP TABLE public.cart_address;
DROP TABLE public.cart;
DROP TABLE public.capture;
DROP TABLE public.auth_identity;
DROP TABLE public.application_method_target_rules;
DROP TABLE public.application_method_buy_rules;
DROP TABLE public.api_key;
DROP TABLE public.account_holder;
DROP TYPE public.return_status_enum;
DROP TYPE public.order_status_enum;
DROP TYPE public.order_claim_type_enum;
DROP TYPE public.claim_reason_enum;
--
-- Name: claim_reason_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.claim_reason_enum AS ENUM (
    'missing_item',
    'wrong_item',
    'production_failure',
    'other'
);


--
-- Name: order_claim_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.order_claim_type_enum AS ENUM (
    'refund',
    'replace'
);


--
-- Name: order_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.order_status_enum AS ENUM (
    'pending',
    'completed',
    'draft',
    'archived',
    'canceled',
    'requires_action'
);


--
-- Name: return_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.return_status_enum AS ENUM (
    'open',
    'requested',
    'received',
    'partially_received',
    'canceled'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_holder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.account_holder (
    id text NOT NULL,
    provider_id text NOT NULL,
    external_id text NOT NULL,
    email text,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: api_key; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_key (
    id text NOT NULL,
    token text NOT NULL,
    salt text NOT NULL,
    redacted text NOT NULL,
    title text NOT NULL,
    type text NOT NULL,
    last_used_at timestamp with time zone,
    created_by text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_by text,
    revoked_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT api_key_type_check CHECK ((type = ANY (ARRAY['publishable'::text, 'secret'::text])))
);


--
-- Name: application_method_buy_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.application_method_buy_rules (
    application_method_id text NOT NULL,
    promotion_rule_id text NOT NULL
);


--
-- Name: application_method_target_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.application_method_target_rules (
    application_method_id text NOT NULL,
    promotion_rule_id text NOT NULL
);


--
-- Name: auth_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_identity (
    id text NOT NULL,
    app_metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: capture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.capture (
    id text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    payment_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    created_by text,
    metadata jsonb
);


--
-- Name: cart; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart (
    id text NOT NULL,
    region_id text,
    customer_id text,
    sales_channel_id text,
    email text,
    currency_code text NOT NULL,
    shipping_address_id text,
    billing_address_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    completed_at timestamp with time zone,
    locale text
);


--
-- Name: cart_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_address (
    id text NOT NULL,
    customer_id text,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: cart_line_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_line_item (
    id text NOT NULL,
    cart_id text NOT NULL,
    title text NOT NULL,
    subtitle text,
    thumbnail text,
    quantity integer NOT NULL,
    variant_id text,
    product_id text,
    product_title text,
    product_description text,
    product_subtitle text,
    product_type text,
    product_collection text,
    product_handle text,
    variant_sku text,
    variant_barcode text,
    variant_title text,
    variant_option_values jsonb,
    requires_shipping boolean DEFAULT true NOT NULL,
    is_discountable boolean DEFAULT true NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    compare_at_unit_price numeric,
    raw_compare_at_unit_price jsonb,
    unit_price numeric NOT NULL,
    raw_unit_price jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    product_type_id text,
    is_custom_price boolean DEFAULT false NOT NULL,
    is_giftcard boolean DEFAULT false NOT NULL,
    CONSTRAINT cart_line_item_unit_price_check CHECK ((unit_price >= (0)::numeric))
);


--
-- Name: cart_line_item_adjustment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_line_item_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    item_id text,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    CONSTRAINT cart_line_item_adjustment_check CHECK ((amount >= (0)::numeric))
);


--
-- Name: cart_line_item_tax_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_line_item_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate real NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    item_id text
);


--
-- Name: cart_payment_collection; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_payment_collection (
    cart_id character varying(255) NOT NULL,
    payment_collection_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: cart_promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_promotion (
    cart_id character varying(255) NOT NULL,
    promotion_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: cart_shipping_method; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_shipping_method (
    id text NOT NULL,
    cart_id text NOT NULL,
    name text NOT NULL,
    description jsonb,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    shipping_option_id text,
    data jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT cart_shipping_method_check CHECK ((amount >= (0)::numeric))
);


--
-- Name: cart_shipping_method_adjustment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_shipping_method_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    shipping_method_id text
);


--
-- Name: cart_shipping_method_tax_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_shipping_method_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate real NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    shipping_method_id text
);


--
-- Name: credit_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credit_line (
    id text NOT NULL,
    cart_id text NOT NULL,
    reference text,
    reference_id text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: currency; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.currency (
    code text NOT NULL,
    symbol text NOT NULL,
    symbol_native text NOT NULL,
    decimal_digits integer DEFAULT 0 NOT NULL,
    rounding numeric DEFAULT 0 NOT NULL,
    raw_rounding jsonb NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    id text NOT NULL,
    company_name text,
    first_name text,
    last_name text,
    email text,
    phone text,
    has_account boolean DEFAULT false NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    created_by text
);


--
-- Name: customer_account_holder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_account_holder (
    customer_id character varying(255) NOT NULL,
    account_holder_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: customer_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_address (
    id text NOT NULL,
    customer_id text NOT NULL,
    address_name text,
    is_default_shipping boolean DEFAULT false NOT NULL,
    is_default_billing boolean DEFAULT false NOT NULL,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: customer_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_group (
    id text NOT NULL,
    name text NOT NULL,
    metadata jsonb,
    created_by text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: customer_group_customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_group_customer (
    id text NOT NULL,
    customer_id text NOT NULL,
    customer_group_id text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp with time zone
);


--
-- Name: fulfillment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fulfillment (
    id text NOT NULL,
    location_id text NOT NULL,
    packed_at timestamp with time zone,
    shipped_at timestamp with time zone,
    delivered_at timestamp with time zone,
    canceled_at timestamp with time zone,
    data jsonb,
    provider_id text,
    shipping_option_id text,
    metadata jsonb,
    delivery_address_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    marked_shipped_by text,
    created_by text,
    requires_shipping boolean DEFAULT true NOT NULL
);


--
-- Name: fulfillment_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fulfillment_address (
    id text NOT NULL,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: fulfillment_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fulfillment_item (
    id text NOT NULL,
    title text NOT NULL,
    sku text NOT NULL,
    barcode text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    line_item_id text,
    inventory_item_id text,
    fulfillment_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: fulfillment_label; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fulfillment_label (
    id text NOT NULL,
    tracking_number text NOT NULL,
    tracking_url text NOT NULL,
    label_url text NOT NULL,
    fulfillment_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: fulfillment_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fulfillment_provider (
    id text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: fulfillment_set; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fulfillment_set (
    id text NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: geo_zone; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.geo_zone (
    id text NOT NULL,
    type text DEFAULT 'country'::text NOT NULL,
    country_code text NOT NULL,
    province_code text,
    city text,
    service_zone_id text NOT NULL,
    postal_expression jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT geo_zone_type_check CHECK ((type = ANY (ARRAY['country'::text, 'province'::text, 'city'::text, 'zip'::text])))
);


--
-- Name: image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.image (
    id text NOT NULL,
    url text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    rank integer DEFAULT 0 NOT NULL,
    product_id text NOT NULL
);


--
-- Name: inventory_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_item (
    id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    sku text,
    origin_country text,
    hs_code text,
    mid_code text,
    material text,
    weight integer,
    length integer,
    height integer,
    width integer,
    requires_shipping boolean DEFAULT true NOT NULL,
    description text,
    title text,
    thumbnail text,
    metadata jsonb
);


--
-- Name: inventory_level; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_level (
    id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    inventory_item_id text NOT NULL,
    location_id text NOT NULL,
    stocked_quantity numeric DEFAULT 0 NOT NULL,
    reserved_quantity numeric DEFAULT 0 NOT NULL,
    incoming_quantity numeric DEFAULT 0 NOT NULL,
    metadata jsonb,
    raw_stocked_quantity jsonb,
    raw_reserved_quantity jsonb,
    raw_incoming_quantity jsonb
);


--
-- Name: invite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invite (
    id text NOT NULL,
    email text NOT NULL,
    accepted boolean DEFAULT false NOT NULL,
    token text NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: invite_rbac_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invite_rbac_role (
    invite_id character varying(255) NOT NULL,
    rbac_role_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: link_module_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.link_module_migrations (
    id integer NOT NULL,
    table_name character varying(255) NOT NULL,
    link_descriptor jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: link_module_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.link_module_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_module_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.link_module_migrations_id_seq OWNED BY public.link_module_migrations.id;


--
-- Name: location_fulfillment_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.location_fulfillment_provider (
    stock_location_id character varying(255) NOT NULL,
    fulfillment_provider_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: location_fulfillment_set; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.location_fulfillment_set (
    stock_location_id character varying(255) NOT NULL,
    fulfillment_set_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: mikro_orm_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mikro_orm_migrations (
    id integer NOT NULL,
    name character varying(255),
    executed_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: mikro_orm_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mikro_orm_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mikro_orm_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mikro_orm_migrations_id_seq OWNED BY public.mikro_orm_migrations.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification (
    id text NOT NULL,
    "to" text NOT NULL,
    channel text NOT NULL,
    template text,
    data jsonb,
    trigger_type text,
    resource_id text,
    resource_type text,
    receiver_id text,
    original_notification_id text,
    idempotency_key text,
    external_id text,
    provider_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    status text DEFAULT 'pending'::text NOT NULL,
    "from" text,
    provider_data jsonb,
    CONSTRAINT notification_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'success'::text, 'failure'::text])))
);


--
-- Name: notification_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_provider (
    id text NOT NULL,
    handle text NOT NULL,
    name text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    channels text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."order" (
    id text NOT NULL,
    region_id text,
    display_id integer,
    customer_id text,
    version integer DEFAULT 1 NOT NULL,
    sales_channel_id text,
    status public.order_status_enum DEFAULT 'pending'::public.order_status_enum NOT NULL,
    is_draft_order boolean DEFAULT false NOT NULL,
    email text,
    currency_code text NOT NULL,
    shipping_address_id text,
    billing_address_id text,
    no_notification boolean,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    canceled_at timestamp with time zone,
    custom_display_id text,
    locale text
);


--
-- Name: order_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_address (
    id text NOT NULL,
    customer_id text,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_cart; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_cart (
    order_id character varying(255) NOT NULL,
    cart_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_change; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_change (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer NOT NULL,
    description text,
    status text DEFAULT 'pending'::text NOT NULL,
    internal_note text,
    created_by text,
    requested_by text,
    requested_at timestamp with time zone,
    confirmed_by text,
    confirmed_at timestamp with time zone,
    declined_by text,
    declined_reason text,
    metadata jsonb,
    declined_at timestamp with time zone,
    canceled_by text,
    canceled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    change_type text,
    deleted_at timestamp with time zone,
    return_id text,
    claim_id text,
    exchange_id text,
    carry_over_promotions boolean,
    CONSTRAINT order_change_status_check CHECK ((status = ANY (ARRAY['confirmed'::text, 'declined'::text, 'requested'::text, 'pending'::text, 'canceled'::text])))
);


--
-- Name: order_change_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_change_action (
    id text NOT NULL,
    order_id text,
    version integer,
    ordering bigint NOT NULL,
    order_change_id text,
    reference text,
    reference_id text,
    action text NOT NULL,
    details jsonb,
    amount numeric,
    raw_amount jsonb,
    internal_note text,
    applied boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    return_id text,
    claim_id text,
    exchange_id text
);


--
-- Name: order_change_action_ordering_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_change_action_ordering_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_change_action_ordering_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_change_action_ordering_seq OWNED BY public.order_change_action.ordering;


--
-- Name: order_claim; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_claim (
    id text NOT NULL,
    order_id text NOT NULL,
    return_id text,
    order_version integer NOT NULL,
    display_id integer NOT NULL,
    type public.order_claim_type_enum NOT NULL,
    no_notification boolean,
    refund_amount numeric,
    raw_refund_amount jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    canceled_at timestamp with time zone,
    created_by text
);


--
-- Name: order_claim_display_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_claim_display_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_claim_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_claim_display_id_seq OWNED BY public.order_claim.display_id;


--
-- Name: order_claim_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_claim_item (
    id text NOT NULL,
    claim_id text NOT NULL,
    item_id text NOT NULL,
    is_additional_item boolean DEFAULT false NOT NULL,
    reason public.claim_reason_enum,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    note text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_claim_item_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_claim_item_image (
    id text NOT NULL,
    claim_item_id text NOT NULL,
    url text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_credit_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_credit_line (
    id text NOT NULL,
    order_id text NOT NULL,
    reference text,
    reference_id text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    version integer DEFAULT 1 NOT NULL
);


--
-- Name: order_display_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_display_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_display_id_seq OWNED BY public."order".display_id;


--
-- Name: order_exchange; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_exchange (
    id text NOT NULL,
    order_id text NOT NULL,
    return_id text,
    order_version integer NOT NULL,
    display_id integer NOT NULL,
    no_notification boolean,
    allow_backorder boolean DEFAULT false NOT NULL,
    difference_due numeric,
    raw_difference_due jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    canceled_at timestamp with time zone,
    created_by text
);


--
-- Name: order_exchange_display_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_exchange_display_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_exchange_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_exchange_display_id_seq OWNED BY public.order_exchange.display_id;


--
-- Name: order_exchange_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_exchange_item (
    id text NOT NULL,
    exchange_id text NOT NULL,
    item_id text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    note text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_fulfillment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_fulfillment (
    order_id character varying(255) NOT NULL,
    fulfillment_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_item (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer NOT NULL,
    item_id text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    fulfilled_quantity numeric NOT NULL,
    raw_fulfilled_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    shipped_quantity numeric NOT NULL,
    raw_shipped_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    return_requested_quantity numeric NOT NULL,
    raw_return_requested_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    return_received_quantity numeric NOT NULL,
    raw_return_received_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    return_dismissed_quantity numeric NOT NULL,
    raw_return_dismissed_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    written_off_quantity numeric NOT NULL,
    raw_written_off_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    delivered_quantity numeric DEFAULT 0 NOT NULL,
    raw_delivered_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    unit_price numeric,
    raw_unit_price jsonb,
    compare_at_unit_price numeric,
    raw_compare_at_unit_price jsonb
);


--
-- Name: order_line_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_line_item (
    id text NOT NULL,
    totals_id text,
    title text NOT NULL,
    subtitle text,
    thumbnail text,
    variant_id text,
    product_id text,
    product_title text,
    product_description text,
    product_subtitle text,
    product_type text,
    product_collection text,
    product_handle text,
    variant_sku text,
    variant_barcode text,
    variant_title text,
    variant_option_values jsonb,
    requires_shipping boolean DEFAULT true NOT NULL,
    is_discountable boolean DEFAULT true NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    compare_at_unit_price numeric,
    raw_compare_at_unit_price jsonb,
    unit_price numeric NOT NULL,
    raw_unit_price jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    is_custom_price boolean DEFAULT false NOT NULL,
    product_type_id text,
    is_giftcard boolean DEFAULT false NOT NULL
);


--
-- Name: order_line_item_adjustment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_line_item_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    item_id text NOT NULL,
    deleted_at timestamp with time zone,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    version integer DEFAULT 1 NOT NULL
);


--
-- Name: order_line_item_tax_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_line_item_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate numeric NOT NULL,
    raw_rate jsonb NOT NULL,
    provider_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    item_id text NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_payment_collection; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_payment_collection (
    order_id character varying(255) NOT NULL,
    payment_collection_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_promotion (
    order_id character varying(255) NOT NULL,
    promotion_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_shipping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_shipping (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer NOT NULL,
    shipping_method_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    return_id text,
    claim_id text,
    exchange_id text
);


--
-- Name: order_shipping_method; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_shipping_method (
    id text NOT NULL,
    name text NOT NULL,
    description jsonb,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    shipping_option_id text,
    data jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    is_custom_amount boolean DEFAULT false NOT NULL
);


--
-- Name: order_shipping_method_adjustment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_shipping_method_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    shipping_method_id text NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_shipping_method_tax_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_shipping_method_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate numeric NOT NULL,
    raw_rate jsonb NOT NULL,
    provider_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    shipping_method_id text NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_summary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_summary (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    totals jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_transaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_transaction (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    currency_code text NOT NULL,
    reference text,
    reference_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    return_id text,
    claim_id text,
    exchange_id text
);


--
-- Name: payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment (
    id text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    currency_code text NOT NULL,
    provider_id text CONSTRAINT payment_provider_id_not_null1 NOT NULL,
    data jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    captured_at timestamp with time zone,
    canceled_at timestamp with time zone,
    payment_collection_id text NOT NULL,
    payment_session_id text NOT NULL,
    metadata jsonb
);


--
-- Name: payment_collection; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_collection (
    id text NOT NULL,
    currency_code text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    authorized_amount numeric,
    raw_authorized_amount jsonb,
    captured_amount numeric,
    raw_captured_amount jsonb,
    refunded_amount numeric,
    raw_refunded_amount jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    completed_at timestamp with time zone,
    status text DEFAULT 'not_paid'::text NOT NULL,
    metadata jsonb,
    CONSTRAINT payment_collection_status_check CHECK ((status = ANY (ARRAY['not_paid'::text, 'awaiting'::text, 'authorized'::text, 'partially_authorized'::text, 'canceled'::text, 'failed'::text, 'partially_captured'::text, 'completed'::text])))
);


--
-- Name: payment_collection_payment_providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_collection_payment_providers (
    payment_collection_id text CONSTRAINT payment_collection_payment_provi_payment_collection_id_not_null NOT NULL,
    payment_provider_id text CONSTRAINT payment_collection_payment_provide_payment_provider_id_not_null NOT NULL
);


--
-- Name: payment_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_provider (
    id text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: payment_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_session (
    id text NOT NULL,
    currency_code text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    context jsonb,
    status text DEFAULT 'pending'::text NOT NULL,
    authorized_at timestamp with time zone,
    payment_collection_id text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT payment_session_status_check CHECK ((status = ANY (ARRAY['authorized'::text, 'captured'::text, 'pending'::text, 'requires_more'::text, 'error'::text, 'canceled'::text])))
);


--
-- Name: price; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price (
    id text NOT NULL,
    title text,
    price_set_id text NOT NULL,
    currency_code text CONSTRAINT price_money_amount_id_not_null NOT NULL,
    raw_amount jsonb NOT NULL,
    rules_count integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    price_list_id text,
    amount numeric NOT NULL,
    min_quantity numeric,
    max_quantity numeric,
    raw_min_quantity jsonb,
    raw_max_quantity jsonb
);


--
-- Name: price_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_list (
    id text NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    starts_at timestamp with time zone,
    ends_at timestamp with time zone,
    rules_count integer DEFAULT 0,
    title text NOT NULL,
    description text NOT NULL,
    type text DEFAULT 'sale'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT price_list_status_check CHECK ((status = ANY (ARRAY['active'::text, 'draft'::text]))),
    CONSTRAINT price_list_type_check CHECK ((type = ANY (ARRAY['sale'::text, 'override'::text])))
);


--
-- Name: price_list_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_list_rule (
    id text NOT NULL,
    price_list_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    value jsonb,
    attribute text DEFAULT ''::text NOT NULL
);


--
-- Name: price_preference; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_preference (
    id text NOT NULL,
    attribute text NOT NULL,
    value text,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: price_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_rule (
    id text NOT NULL,
    value text NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    price_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    attribute text DEFAULT ''::text NOT NULL,
    operator text DEFAULT 'eq'::text NOT NULL,
    CONSTRAINT price_rule_operator_check CHECK ((operator = ANY (ARRAY['gte'::text, 'lte'::text, 'gt'::text, 'lt'::text, 'eq'::text])))
);


--
-- Name: price_set; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_set (
    id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product (
    id text NOT NULL,
    title text NOT NULL,
    handle text NOT NULL,
    subtitle text,
    description text,
    is_giftcard boolean DEFAULT false NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    thumbnail text,
    weight text,
    length text,
    height text,
    width text,
    origin_country text,
    hs_code text,
    mid_code text,
    material text,
    collection_id text,
    type_id text,
    discountable boolean DEFAULT true NOT NULL,
    external_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    CONSTRAINT product_status_check CHECK ((status = ANY (ARRAY['draft'::text, 'proposed'::text, 'published'::text, 'rejected'::text])))
);


--
-- Name: product_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_category (
    id text NOT NULL,
    name text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    handle text NOT NULL,
    mpath text NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    is_internal boolean DEFAULT false NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    parent_category_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


--
-- Name: product_category_product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_category_product (
    product_id text NOT NULL,
    product_category_id text NOT NULL
);


--
-- Name: product_collection; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_collection (
    id text NOT NULL,
    title text NOT NULL,
    handle text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_option; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_option (
    id text NOT NULL,
    title text NOT NULL,
    product_id text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_option_value; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_option_value (
    id text NOT NULL,
    value text NOT NULL,
    option_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_sales_channel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_sales_channel (
    product_id character varying(255) NOT NULL,
    sales_channel_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_shipping_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_shipping_profile (
    product_id character varying(255) NOT NULL,
    shipping_profile_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_tag (
    id text NOT NULL,
    value text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_tags (
    product_id text NOT NULL,
    product_tag_id text NOT NULL
);


--
-- Name: product_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_type (
    id text NOT NULL,
    value text NOT NULL,
    metadata json,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_variant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variant (
    id text NOT NULL,
    title text NOT NULL,
    sku text,
    barcode text,
    ean text,
    upc text,
    allow_backorder boolean DEFAULT false NOT NULL,
    manage_inventory boolean DEFAULT true NOT NULL,
    hs_code text,
    origin_country text,
    mid_code text,
    material text,
    weight integer,
    length integer,
    height integer,
    width integer,
    metadata jsonb,
    variant_rank integer DEFAULT 0,
    product_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    thumbnail text
);


--
-- Name: product_variant_inventory_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variant_inventory_item (
    variant_id character varying(255) NOT NULL,
    inventory_item_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    required_quantity integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_variant_option; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variant_option (
    variant_id text NOT NULL,
    option_value_id text NOT NULL
);


--
-- Name: product_variant_price_set; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variant_price_set (
    variant_id character varying(255) NOT NULL,
    price_set_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: product_variant_product_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variant_product_image (
    id text NOT NULL,
    variant_id text NOT NULL,
    image_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion (
    id text NOT NULL,
    code text NOT NULL,
    campaign_id text,
    is_automatic boolean DEFAULT false NOT NULL,
    type text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    status text DEFAULT 'draft'::text NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    "limit" integer,
    used integer DEFAULT 0 NOT NULL,
    metadata jsonb,
    CONSTRAINT promotion_status_check CHECK ((status = ANY (ARRAY['draft'::text, 'active'::text, 'inactive'::text]))),
    CONSTRAINT promotion_type_check CHECK ((type = ANY (ARRAY['standard'::text, 'buyget'::text])))
);


--
-- Name: promotion_application_method; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion_application_method (
    id text NOT NULL,
    value numeric,
    raw_value jsonb,
    max_quantity integer,
    apply_to_quantity integer,
    buy_rules_min_quantity integer,
    type text NOT NULL,
    target_type text NOT NULL,
    allocation text,
    promotion_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    currency_code text,
    CONSTRAINT promotion_application_method_allocation_check CHECK ((allocation = ANY (ARRAY['each'::text, 'across'::text, 'once'::text]))),
    CONSTRAINT promotion_application_method_target_type_check CHECK ((target_type = ANY (ARRAY['order'::text, 'shipping_methods'::text, 'items'::text]))),
    CONSTRAINT promotion_application_method_type_check CHECK ((type = ANY (ARRAY['fixed'::text, 'percentage'::text])))
);


--
-- Name: promotion_campaign; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion_campaign (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    campaign_identifier text NOT NULL,
    starts_at timestamp with time zone,
    ends_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: promotion_campaign_budget; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion_campaign_budget (
    id text NOT NULL,
    type text NOT NULL,
    campaign_id text NOT NULL,
    "limit" numeric,
    raw_limit jsonb,
    used numeric DEFAULT 0 NOT NULL,
    raw_used jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    currency_code text,
    attribute text,
    CONSTRAINT promotion_campaign_budget_type_check CHECK ((type = ANY (ARRAY['spend'::text, 'usage'::text, 'use_by_attribute'::text, 'spend_by_attribute'::text])))
);


--
-- Name: promotion_campaign_budget_usage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion_campaign_budget_usage (
    id text NOT NULL,
    attribute_value text NOT NULL,
    used numeric DEFAULT 0 NOT NULL,
    budget_id text NOT NULL,
    raw_used jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: promotion_promotion_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion_promotion_rule (
    promotion_id text NOT NULL,
    promotion_rule_id text NOT NULL
);


--
-- Name: promotion_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion_rule (
    id text NOT NULL,
    description text,
    attribute text NOT NULL,
    operator text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT promotion_rule_operator_check CHECK ((operator = ANY (ARRAY['gte'::text, 'lte'::text, 'gt'::text, 'lt'::text, 'eq'::text, 'ne'::text, 'in'::text])))
);


--
-- Name: promotion_rule_value; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion_rule_value (
    id text NOT NULL,
    promotion_rule_id text NOT NULL,
    value text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: provider_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provider_identity (
    id text NOT NULL,
    entity_id text NOT NULL,
    provider text NOT NULL,
    auth_identity_id text NOT NULL,
    user_metadata jsonb,
    provider_metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: publishable_api_key_sales_channel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publishable_api_key_sales_channel (
    publishable_key_id character varying(255) NOT NULL,
    sales_channel_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: refund; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.refund (
    id text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    payment_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    created_by text,
    metadata jsonb,
    refund_reason_id text,
    note text
);


--
-- Name: refund_reason; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.refund_reason (
    id text NOT NULL,
    label text NOT NULL,
    description text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    code text NOT NULL
);


--
-- Name: region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.region (
    id text NOT NULL,
    name text NOT NULL,
    currency_code text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    automatic_taxes boolean DEFAULT true NOT NULL
);


--
-- Name: region_country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.region_country (
    iso_2 text NOT NULL,
    iso_3 text NOT NULL,
    num_code text NOT NULL,
    name text NOT NULL,
    display_name text NOT NULL,
    region_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: region_payment_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.region_payment_provider (
    region_id character varying(255) NOT NULL,
    payment_provider_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: reservation_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reservation_item (
    id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    line_item_id text,
    location_id text NOT NULL,
    quantity numeric NOT NULL,
    external_id text,
    description text,
    created_by text,
    metadata jsonb,
    inventory_item_id text NOT NULL,
    allow_backorder boolean DEFAULT false,
    raw_quantity jsonb
);


--
-- Name: return; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.return (
    id text NOT NULL,
    order_id text NOT NULL,
    claim_id text,
    exchange_id text,
    order_version integer NOT NULL,
    display_id integer NOT NULL,
    status public.return_status_enum DEFAULT 'open'::public.return_status_enum NOT NULL,
    no_notification boolean,
    refund_amount numeric,
    raw_refund_amount jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    received_at timestamp with time zone,
    canceled_at timestamp with time zone,
    location_id text,
    requested_at timestamp with time zone,
    created_by text
);


--
-- Name: return_display_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.return_display_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: return_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.return_display_id_seq OWNED BY public.return.display_id;


--
-- Name: return_fulfillment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.return_fulfillment (
    return_id character varying(255) NOT NULL,
    fulfillment_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: return_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.return_item (
    id text NOT NULL,
    return_id text NOT NULL,
    reason_id text,
    item_id text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    received_quantity numeric DEFAULT 0 NOT NULL,
    raw_received_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    note text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    damaged_quantity numeric DEFAULT 0 NOT NULL,
    raw_damaged_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL
);


--
-- Name: return_reason; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.return_reason (
    id character varying NOT NULL,
    value character varying NOT NULL,
    label character varying NOT NULL,
    description character varying,
    metadata jsonb,
    parent_return_reason_id character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: sales_channel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_channel (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    is_disabled boolean DEFAULT false NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: sales_channel_stock_location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_channel_stock_location (
    sales_channel_id character varying(255) NOT NULL,
    stock_location_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: script_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.script_migrations (
    id integer NOT NULL,
    script_name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    finished_at timestamp with time zone
);


--
-- Name: script_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.script_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: script_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.script_migrations_id_seq OWNED BY public.script_migrations.id;


--
-- Name: service_zone; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_zone (
    id text NOT NULL,
    name text NOT NULL,
    metadata jsonb,
    fulfillment_set_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: shipping_option; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_option (
    id text NOT NULL,
    name text NOT NULL,
    price_type text DEFAULT 'flat'::text NOT NULL,
    service_zone_id text NOT NULL,
    shipping_profile_id text,
    provider_id text,
    data jsonb,
    metadata jsonb,
    shipping_option_type_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT shipping_option_price_type_check CHECK ((price_type = ANY (ARRAY['calculated'::text, 'flat'::text])))
);


--
-- Name: shipping_option_price_set; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_option_price_set (
    shipping_option_id character varying(255) NOT NULL,
    price_set_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: shipping_option_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_option_rule (
    id text NOT NULL,
    attribute text NOT NULL,
    operator text NOT NULL,
    value jsonb,
    shipping_option_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT shipping_option_rule_operator_check CHECK ((operator = ANY (ARRAY['in'::text, 'eq'::text, 'ne'::text, 'gt'::text, 'gte'::text, 'lt'::text, 'lte'::text, 'nin'::text])))
);


--
-- Name: shipping_option_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_option_type (
    id text NOT NULL,
    label text NOT NULL,
    description text,
    code text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: shipping_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_profile (
    id text NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: stock_location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_location (
    id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    name text NOT NULL,
    address_id text,
    metadata jsonb
);


--
-- Name: stock_location_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_location_address (
    id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    address_1 text NOT NULL,
    address_2 text,
    company text,
    city text,
    country_code text NOT NULL,
    phone text,
    province text,
    postal_code text,
    metadata jsonb
);


--
-- Name: store; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store (
    id text NOT NULL,
    name text DEFAULT 'Medusa Store'::text NOT NULL,
    default_sales_channel_id text,
    default_region_id text,
    default_location_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: store_currency; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_currency (
    id text NOT NULL,
    currency_code text NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    store_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: store_locale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_locale (
    id text NOT NULL,
    locale_code text NOT NULL,
    store_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: tax_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_provider (
    id text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: tax_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_rate (
    id text NOT NULL,
    rate real,
    code text NOT NULL,
    name text NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    is_combinable boolean DEFAULT false NOT NULL,
    tax_region_id text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp with time zone
);


--
-- Name: tax_rate_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_rate_rule (
    id text NOT NULL,
    tax_rate_id text NOT NULL,
    reference_id text NOT NULL,
    reference text NOT NULL,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp with time zone
);


--
-- Name: tax_region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_region (
    id text NOT NULL,
    provider_id text,
    country_code text NOT NULL,
    province_code text,
    parent_id text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp with time zone,
    CONSTRAINT "CK_tax_region_country_top_level" CHECK (((parent_id IS NULL) OR (province_code IS NOT NULL))),
    CONSTRAINT "CK_tax_region_provider_top_level" CHECK (((parent_id IS NULL) OR (provider_id IS NULL)))
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id text NOT NULL,
    first_name text,
    last_name text,
    email text NOT NULL,
    avatar_url text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: user_preference; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_preference (
    id text NOT NULL,
    user_id text NOT NULL,
    key text NOT NULL,
    value jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: user_rbac_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_rbac_role (
    user_id character varying(255) NOT NULL,
    rbac_role_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: view_configuration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.view_configuration (
    id text NOT NULL,
    entity text NOT NULL,
    name text,
    user_id text,
    is_system_default boolean DEFAULT false NOT NULL,
    configuration jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: workflow_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_execution (
    id character varying NOT NULL,
    workflow_id character varying NOT NULL,
    transaction_id character varying NOT NULL,
    execution jsonb,
    context jsonb,
    state character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    retention_time integer,
    run_id text DEFAULT '01KPC3YXKPGHJ01ARG2RPN3WFZ'::text NOT NULL
);


--
-- Name: link_module_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_module_migrations ALTER COLUMN id SET DEFAULT nextval('public.link_module_migrations_id_seq'::regclass);


--
-- Name: mikro_orm_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mikro_orm_migrations ALTER COLUMN id SET DEFAULT nextval('public.mikro_orm_migrations_id_seq'::regclass);


--
-- Name: order display_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order" ALTER COLUMN display_id SET DEFAULT nextval('public.order_display_id_seq'::regclass);


--
-- Name: order_change_action ordering; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_change_action ALTER COLUMN ordering SET DEFAULT nextval('public.order_change_action_ordering_seq'::regclass);


--
-- Name: order_claim display_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_claim ALTER COLUMN display_id SET DEFAULT nextval('public.order_claim_display_id_seq'::regclass);


--
-- Name: order_exchange display_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_exchange ALTER COLUMN display_id SET DEFAULT nextval('public.order_exchange_display_id_seq'::regclass);


--
-- Name: return display_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.return ALTER COLUMN display_id SET DEFAULT nextval('public.return_display_id_seq'::regclass);


--
-- Name: script_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.script_migrations ALTER COLUMN id SET DEFAULT nextval('public.script_migrations_id_seq'::regclass);


--
-- Data for Name: account_holder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.account_holder (id, provider_id, external_id, email, data, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.api_key (id, token, salt, redacted, title, type, last_used_at, created_by, created_at, revoked_by, revoked_at, updated_at, deleted_at) FROM stdin;
apk_01KPC3ZE4AFSBX92QRCC147J91	pk_064df238affda70c81a72fcf01d8f2da8edf8e4136b95830ba5e4ebebc774b27		pk_064***b27	Default Publishable API Key	publishable	\N		2026-04-17 02:43:26.09+05	\N	\N	2026-04-17 02:43:26.09+05	\N
\.


--
-- Data for Name: application_method_buy_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.application_method_buy_rules (application_method_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: application_method_target_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.application_method_target_rules (application_method_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: auth_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_identity (id, app_metadata, created_at, updated_at, deleted_at) FROM stdin;
authid_01KPE8HZB6HWEQNHS43Q2J99SJ	{"user_id": "user_01KPE8HZ9CRAXYVDM1KCXH81FA"}	2026-04-17 22:41:56.71+05	2026-04-17 22:41:56.715+05	\N
authid_01KQ5TQ97GCABS75FE17P6D09K	{"user_id": "user_01KQ5TQ8VEDSYC1AR3KJQ4YDM4"}	2026-04-27 02:21:56.977+05	2026-04-27 02:21:57.007+05	\N
\.


--
-- Data for Name: capture; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.capture (id, amount, raw_amount, payment_id, created_at, updated_at, deleted_at, created_by, metadata) FROM stdin;
capt_01KPT6ANBB3865FDD4YCEZX2ER	378	{"value": "378", "precision": 20}	pay_01KPT69AF8JY8AA7CR48HS784W	2026-04-22 13:53:53.131+05	2026-04-22 13:53:53.131+05	\N	\N	\N
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart (id, region_id, customer_id, sales_channel_id, email, currency_code, shipping_address_id, billing_address_id, metadata, created_at, updated_at, deleted_at, completed_at, locale) FROM stdin;
cart_01KPDX1CXSX3V8FYD72HD2MX1N	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	cus_01KPDX1DTHCVZT4PAKC7NYXB40	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	test@dentauae.com	aed	caaddr_01KPDX1DTX7WPGKGFCV6V5PTCX	\N	\N	2026-04-17 19:20:39.226+05	2026-04-17 19:20:42.526+05	\N	2026-04-17 19:20:42.472+05	\N
cart_01KPHB2MCA7D4RW8QPX19MYEAA	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	\N	aed	\N	\N	\N	2026-04-19 03:23:42.987+05	2026-04-19 03:23:42.987+05	\N	\N	\N
cart_01KPHB2MG070PGW744JSNB03GE	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	\N	aed	\N	\N	\N	2026-04-19 03:23:43.104+05	2026-04-19 03:23:43.104+05	\N	\N	\N
cart_01KPHB2MC9PQG2PKE6PW5FQCRZ	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	cus_01KPHBEQ8GW57TKN2C824BS4FH	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	test@example.com	aed	caaddr_01KPHBEQ9A1XQ80KFYC7MTEKR9	caaddr_01KPHBEQ9A6YQQ7S4KKEJS2P9A	\N	2026-04-19 03:23:42.985+05	2026-04-19 03:30:19.18+05	\N	\N	\N
cart_01KPHB2M598PASVWWHE75YZMEJ	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	cus_01KPT69820YQ6YCJHC4SD5V9W7	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	shaheryarahmed.awan@gmail.com	aed	caaddr_01KPT698330DEDW5HF313ZNZJ4	caaddr_01KPT69833WGH4EVFWKK095ZEW	\N	2026-04-19 03:23:42.764+05	2026-04-22 13:53:09.093+05	\N	2026-04-22 13:53:09.064+05	\N
cart_01KPTE5BZ50ZW6HZSH82VFS5HD	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	\N	aed	\N	\N	\N	2026-04-22 16:10:48.294+05	2026-04-22 16:10:48.294+05	\N	\N	\N
cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	\N	aed	\N	\N	\N	2026-04-22 16:10:48.376+05	2026-04-22 16:10:48.376+05	\N	\N	\N
\.


--
-- Data for Name: cart_address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_address (id, customer_id, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
caaddr_01KPDX1DTX7WPGKGFCV6V5PTCX	\N	\N	Test	User	Al Barsha 1	\N	Dubai	ae	\N	\N	0501234567	\N	2026-04-17 19:20:40.157+05	2026-04-17 19:20:40.157+05	\N
caaddr_01KPHBEQ9A6YQQ7S4KKEJS2P9A	\N	\N	Test	User	Test Street 123	\N	Dubai	ae	Dubai	\N	0501234567	\N	2026-04-19 03:30:19.179+05	2026-04-19 03:30:19.179+05	\N
caaddr_01KPHBEQ9A1XQ80KFYC7MTEKR9	\N	\N	Test	User	Test Street 123	\N	Dubai	ae	Dubai	\N	0501234567	\N	2026-04-19 03:30:19.179+05	2026-04-19 03:30:19.179+05	\N
caaddr_01KPT69833WGH4EVFWKK095ZEW	\N	\N	Sharyar 	Ahmed	House 12 	\N	Dubai	ae	Dubai	\N	+923342626544	\N	2026-04-22 13:53:06.787+05	2026-04-22 13:53:06.787+05	\N
caaddr_01KPT698330DEDW5HF313ZNZJ4	\N	\N	Sharyar 	Ahmed	House 12 	\N	Dubai	ae	Dubai	\N	+923342626544	\N	2026-04-22 13:53:06.787+05	2026-04-22 13:53:06.787+05	\N
\.


--
-- Data for Name: cart_line_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_line_item (id, cart_id, title, subtitle, thumbnail, quantity, variant_id, product_id, product_title, product_description, product_subtitle, product_type, product_collection, product_handle, variant_sku, variant_barcode, variant_title, variant_option_values, requires_shipping, is_discountable, is_tax_inclusive, compare_at_unit_price, raw_compare_at_unit_price, unit_price, raw_unit_price, metadata, created_at, updated_at, deleted_at, product_type_id, is_custom_price, is_giftcard) FROM stdin;
cali_01KPDX1DJN8JMG5AQTX9XTZ5PT	cart_01KPDX1CXSX3V8FYD72HD2MX1N	Oral-B iO Series 9	Rose Quartz	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	1	variant_01KPC3ZEA11CRT67TA4020FQ1Z	prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	\N	\N	\N	io-9	IO-9-PNK	\N	Rose Quartz	\N	t	t	f	\N	\N	899	{"value": "899", "precision": 20}	{}	2026-04-17 19:20:39.895+05	2026-04-17 19:20:39.895+05	\N	\N	f	f
cali_01KPHBBGRZX0N0WTKZ34F7VFB3	cart_01KPHB2MC9PQG2PKE6PW5FQCRZ	Oral-B iO Series 9	Rose Quartz	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	1	variant_01KPC3ZEA11CRT67TA4020FQ1Z	prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	\N	\N	\N	io-9	IO-9-PNK	\N	Rose Quartz	\N	t	t	f	\N	\N	899	{"value": "899", "precision": 20}	{}	2026-04-19 03:28:34.207+05	2026-04-19 03:28:34.207+05	\N	\N	f	f
cali_01KPT67QX5K0A06XAD43T0QNGB	cart_01KPHB2M598PASVWWHE75YZMEJ	Nikai 130L Gross / 90L Net, Single Door Mini Refrigerator, Chiller & Veg. Compartment, 2 Glass Shelves & Bottle Storage Racks, Compact Small Size Beverage Fridge, For Home, Office, Bedroom - NRF130SS1	Default	https://m.media-amazon.com/images/I/71Bu7r4vkWL.jpg	1	variant_01KPT5GB7B7C91YF1Z2MKGGAB1	prod_01KPT5GB487QQMWCYV852JCV72	Nikai 130L Gross / 90L Net, Single Door Mini Refrigerator, Chiller & Veg. Compartment, 2 Glass Shelves & Bottle Storage Racks, Compact Small Size Beverage Fridge, For Home, Office, Bedroom - NRF130SS1	𝐄𝐧𝐯𝐢𝐫𝐨𝐧𝐦𝐞𝐧𝐭-𝐟𝐫𝐢𝐞𝐧𝐝𝐥𝐲 𝐑𝐞𝐟𝐫𝐢𝐠𝐞𝐫𝐚𝐧𝐭 : This NIKAI Ref NRF130 uses R600a for cooling, owing to its superior thermodynamic performance and low environmental impact. This Refrigerator is also free of chlorofluorocarbons (CFC) which can cause harm to the environment.\n𝐒𝐮𝐩𝐞𝐫 𝐒𝐢𝐥𝐞𝐧𝐭 & 𝐄𝐧𝐞𝐫𝐠𝐲 𝐄𝐟𝐟𝐢𝐜𝐢𝐞𝐧𝐭 𝐂𝐨𝐦𝐩𝐫𝐞𝐬𝐬𝐨𝐫 : A silent/quiet compressor is designed especially; for quiet operation and is fully automated and virtually noiseless. This compressor combines machine reliability, additional noise insulation, and efficient lubrication to absorb most noise produced to live comfortably in the surroundings.\n𝐓𝐞𝐦𝐩𝐞𝐫𝐚𝐭𝐮𝐫𝐞 𝐂𝐨𝐧𝐭𝐫𝐨𝐥 & 𝐈𝐧𝐭𝐞𝐫𝐢𝐨𝐫 𝐋𝐢𝐠𝐡𝐭 : Temperature Control: Adjust the knob from 1 to max to control the refrigerator temperature. A medium setting is the most recommended setting for general operation. Set the thermostat in max position only when ice cubes or frozen food is in the freezing compartment.\n𝐃𝐞𝐟𝐫𝐨𝐬𝐭𝐢𝐧𝐠 : Defrost the freezing compartment whenever the ice layer reaches 3-4mm on the evaporator. During the defrosting method, remove all foods and ice cubes trays. Then, Place the drip tray to collect melted water to start defrosting, set the thermostat at 0 positions, and do not forget to keep the door open.\n𝐆𝐫𝐨𝐬𝐬 & 𝐍𝐞𝐭 𝐂𝐚𝐩𝐚𝐜𝐢𝐭𝐲 : The Gross Capacity of Nikai - NRF130SS1 is 125Ltr & the net capacity of this mini refrigerator is 90Ltr. It is a perfect fit for small Kitchens, Bedrooms, Student dormitories, Offices, Hotel rooms. It is suitable for refrigerating foods like fruits, vegetables, Chocolates and Beverages.\n𝐂𝐡𝐢𝐥𝐝 𝐋𝐨𝐜𝐤 & 𝐊𝐞𝐲 𝐅𝐮𝐧𝐜𝐭𝐢𝐨𝐧 : To secure your kids when you are not around, Nikai Refrigerator comes with a lock & key feature for security	Imported from Amazon	\N	\N	amz-b07n156drr	AMZ-B07N156DRR	\N	Default	\N	f	t	f	\N	\N	358	{"value": "358", "precision": 20}	{}	2026-04-22 13:52:17.445+05	2026-04-22 13:52:17.445+05	\N	\N	f	f
cali_01KPT6VSP9NZZV49AHHA8B6S4M	cart_01KPHB2MC9PQG2PKE6PW5FQCRZ	Nikai 130L Gross / 90L Net, Single Door Mini Refrigerator, Chiller & Veg. Compartment, 2 Glass Shelves & Bottle Storage Racks, Compact Small Size Beverage Fridge, For Home, Office, Bedroom - NRF130SS1	Default	https://m.media-amazon.com/images/I/71Bu7r4vkWL.jpg	1	variant_01KPT5GB7B7C91YF1Z2MKGGAB1	prod_01KPT5GB487QQMWCYV852JCV72	Nikai 130L Gross / 90L Net, Single Door Mini Refrigerator, Chiller & Veg. Compartment, 2 Glass Shelves & Bottle Storage Racks, Compact Small Size Beverage Fridge, For Home, Office, Bedroom - NRF130SS1	𝐄𝐧𝐯𝐢𝐫𝐨𝐧𝐦𝐞𝐧𝐭-𝐟𝐫𝐢𝐞𝐧𝐝𝐥𝐲 𝐑𝐞𝐟𝐫𝐢𝐠𝐞𝐫𝐚𝐧𝐭 : This NIKAI Ref NRF130 uses R600a for cooling, owing to its superior thermodynamic performance and low environmental impact. This Refrigerator is also free of chlorofluorocarbons (CFC) which can cause harm to the environment.\n𝐒𝐮𝐩𝐞𝐫 𝐒𝐢𝐥𝐞𝐧𝐭 & 𝐄𝐧𝐞𝐫𝐠𝐲 𝐄𝐟𝐟𝐢𝐜𝐢𝐞𝐧𝐭 𝐂𝐨𝐦𝐩𝐫𝐞𝐬𝐬𝐨𝐫 : A silent/quiet compressor is designed especially; for quiet operation and is fully automated and virtually noiseless. This compressor combines machine reliability, additional noise insulation, and efficient lubrication to absorb most noise produced to live comfortably in the surroundings.\n𝐓𝐞𝐦𝐩𝐞𝐫𝐚𝐭𝐮𝐫𝐞 𝐂𝐨𝐧𝐭𝐫𝐨𝐥 & 𝐈𝐧𝐭𝐞𝐫𝐢𝐨𝐫 𝐋𝐢𝐠𝐡𝐭 : Temperature Control: Adjust the knob from 1 to max to control the refrigerator temperature. A medium setting is the most recommended setting for general operation. Set the thermostat in max position only when ice cubes or frozen food is in the freezing compartment.\n𝐃𝐞𝐟𝐫𝐨𝐬𝐭𝐢𝐧𝐠 : Defrost the freezing compartment whenever the ice layer reaches 3-4mm on the evaporator. During the defrosting method, remove all foods and ice cubes trays. Then, Place the drip tray to collect melted water to start defrosting, set the thermostat at 0 positions, and do not forget to keep the door open.\n𝐆𝐫𝐨𝐬𝐬 & 𝐍𝐞𝐭 𝐂𝐚𝐩𝐚𝐜𝐢𝐭𝐲 : The Gross Capacity of Nikai - NRF130SS1 is 125Ltr & the net capacity of this mini refrigerator is 90Ltr. It is a perfect fit for small Kitchens, Bedrooms, Student dormitories, Offices, Hotel rooms. It is suitable for refrigerating foods like fruits, vegetables, Chocolates and Beverages.\n𝐂𝐡𝐢𝐥𝐝 𝐋𝐨𝐜𝐤 & 𝐊𝐞𝐲 𝐅𝐮𝐧𝐜𝐭𝐢𝐨𝐧 : To secure your kids when you are not around, Nikai Refrigerator comes with a lock & key feature for security	Imported from Amazon	\N	\N	amz-b07n156drr	AMZ-B07N156DRR	\N	Default	\N	f	t	f	\N	\N	358	{"value": "358", "precision": 20}	{}	2026-04-22 14:03:14.634+05	2026-04-22 14:03:14.634+05	\N	\N	f	f
cali_01KPTE0AXM2TZP87KV7QCT20X9	cart_01KPHB2MC9PQG2PKE6PW5FQCRZ	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Default	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	1	variant_01KPT58G2M3NX84CNAZ6PE2WTD	prod_01KPT58FZ1W2CEPTR24NG0MPMX	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Oral-B’s BEST EVER CLEAN with REVOLUTIONARY MAGNETIC iO TECHNOLOGY for a professional clean feeling & gentle brushing experience\n3D Teeth Tracking with A.I to monitor your brushing across the front, top and back surfaces of your teeth; guiding you to the most thorough possible clean\n7 SMART MODES to personalise your brushing: Daily Clean, Sensitive, Gum Care, Intense Clean, Whitening, Tongue Cleaner, Super Sensitive\nCombines the unique round brush head from Oral-B with gentle micro-vibrations for 100% healthier gums in one week\nINTERACTIVE COLOR DISPLAY signals vital information: Including brushing modes and head replacement reminder, greets you as you power up and gives you a smile for a job well done	Imported from Amazon	\N	\N	amz-b09h7ltx4c	AMZ-B09H7LTX4C	\N	Default	\N	f	t	f	\N	\N	969	{"value": "969", "precision": 20}	{}	2026-04-22 16:08:03.381+05	2026-04-22 16:08:03.381+05	\N	\N	f	f
cali_01KPTEB1XNMCBJ08PARFPBZGTS	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO Series 9	Rose Quartz	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	1	variant_01KPC3ZEA11CRT67TA4020FQ1Z	prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	\N	\N	\N	io-9	IO-9-PNK	\N	Rose Quartz	\N	t	t	f	\N	\N	899	{"value": "899", "precision": 20}	{}	2026-04-22 16:13:54.613+05	2026-04-22 16:14:10.51+05	2026-04-22 16:14:10.509+05	\N	f	f
cali_01KPTEC4WQFAAG3C5GN7S6MPD6	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO Series 9	Rose Quartz	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	1	variant_01KPC3ZEA11CRT67TA4020FQ1Z	prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	\N	\N	\N	io-9	IO-9-PNK	\N	Rose Quartz	\N	t	t	f	\N	\N	899	{"value": "899", "precision": 20}	{}	2026-04-22 16:14:30.423+05	2026-04-22 16:14:40.323+05	2026-04-22 16:14:40.323+05	\N	f	f
cali_01KPTECTVHAQHJD8JKG11JHS1Z	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO Series 9	Rose Quartz	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	2	variant_01KPC3ZEA11CRT67TA4020FQ1Z	prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	\N	\N	\N	io-9	IO-9-PNK	\N	Rose Quartz	\N	t	t	f	\N	\N	899	{"value": "899", "precision": 20}	{}	2026-04-22 16:14:52.913+05	2026-04-22 16:30:51.396+05	2026-04-22 16:30:51.394+05	\N	f	f
cali_01KPTFBZEZAHGDDV5Q24NGKPC4	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Default	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	1	variant_01KPT58G2M3NX84CNAZ6PE2WTD	prod_01KPT58FZ1W2CEPTR24NG0MPMX	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Oral-B’s BEST EVER CLEAN with REVOLUTIONARY MAGNETIC iO TECHNOLOGY for a professional clean feeling & gentle brushing experience\n3D Teeth Tracking with A.I to monitor your brushing across the front, top and back surfaces of your teeth; guiding you to the most thorough possible clean\n7 SMART MODES to personalise your brushing: Daily Clean, Sensitive, Gum Care, Intense Clean, Whitening, Tongue Cleaner, Super Sensitive\nCombines the unique round brush head from Oral-B with gentle micro-vibrations for 100% healthier gums in one week\nINTERACTIVE COLOR DISPLAY signals vital information: Including brushing modes and head replacement reminder, greets you as you power up and gives you a smile for a job well done	Imported from Amazon	\N	\N	amz-b09h7ltx4c	AMZ-B09H7LTX4C	\N	Default	\N	f	t	f	\N	\N	969	{"value": "969", "precision": 20}	{}	2026-04-22 16:31:53.44+05	2026-04-22 16:31:56.24+05	2026-04-22 16:31:56.239+05	\N	f	f
cali_01KPTFE1QQFQ8EQZH5FR1KQP9V	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO Series 9	Rose Quartz	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	3	variant_01KPC3ZEA11CRT67TA4020FQ1Z	prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	\N	\N	\N	io-9	IO-9-PNK	\N	Rose Quartz	\N	t	t	f	\N	\N	899	{"value": "899", "precision": 20}	{}	2026-04-22 16:33:01.303+05	2026-04-22 16:33:12.943+05	2026-04-22 16:33:12.942+05	\N	f	f
cali_01KPTFE70N9K6FH8D2S1PKTVB3	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	iO Gentle Care Heads (4ct)	4 Count Pack	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	1	variant_01KPC3ZEA16JV8WNKTX37DPBDB	prod_01KPC3ZE91QKARBVHWZWTMHG6R	iO Gentle Care Heads (4ct)	Gentle cleaning for sensitive gums. Compatible with all iO handles.	\N	\N	\N	io-heads	IO-HEADS-4CT	\N	4 Count Pack	\N	t	t	f	\N	\N	185	{"value": "185", "precision": 20}	{}	2026-04-22 16:33:06.709+05	2026-04-22 16:33:13.814+05	2026-04-22 16:33:13.813+05	\N	f	f
cali_01KPTFKAKYHQA7VHFGRY2GXS51	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Default	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	1	variant_01KPT58G2M3NX84CNAZ6PE2WTD	prod_01KPT58FZ1W2CEPTR24NG0MPMX	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Oral-B’s BEST EVER CLEAN with REVOLUTIONARY MAGNETIC iO TECHNOLOGY for a professional clean feeling & gentle brushing experience\n3D Teeth Tracking with A.I to monitor your brushing across the front, top and back surfaces of your teeth; guiding you to the most thorough possible clean\n7 SMART MODES to personalise your brushing: Daily Clean, Sensitive, Gum Care, Intense Clean, Whitening, Tongue Cleaner, Super Sensitive\nCombines the unique round brush head from Oral-B with gentle micro-vibrations for 100% healthier gums in one week\nINTERACTIVE COLOR DISPLAY signals vital information: Including brushing modes and head replacement reminder, greets you as you power up and gives you a smile for a job well done	Imported from Amazon	\N	\N	amz-b09h7ltx4c	AMZ-B09H7LTX4C	\N	Default	\N	f	t	f	\N	\N	969	{"value": "969", "precision": 20}	{}	2026-04-22 16:35:54.238+05	2026-04-22 16:35:56.592+05	2026-04-22 16:35:56.591+05	\N	f	f
cali_01KPTFNMDP3K2K5P8BHP0YFHGB	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B Pro 1-1000 Rechargeable Toothbrush 1+1 Bundle - 3D Cleaning, Pressure Sensor, Electric Toothbrush with CrossAction brush head - White	Default	https://m.media-amazon.com/images/I/712zxPvIHxL.jpg	2	variant_01KPTFND8MZ55H0SB3CJ87JJ64	prod_01KPTFND37SAFPP8RPPGTAG7CP	Oral-B Pro 1-1000 Rechargeable Toothbrush 1+1 Bundle - 3D Cleaning, Pressure Sensor, Electric Toothbrush with CrossAction brush head - White	- SUPERIOR CLEANING: Round Head Cross Action brush head surrounds each tooth for superior cleaning.\n- CLINICALLY PROVEN 3D CLEANING: Clinically proven superior 3D cleaning oscillates and pulsates to break up and remove up to 300% more plaque along the gum line compared to a manual toothbrush.\n- TIME COACHING FEATURE: Time Coaching feature helps you brush for the dentist-recommended 2 minutes.\n- PRESSURE SENSOR: The pressure sensor stops the pulsation movement if you brush too hard.\n- RECHARGEABLE: Rechargeable power toothbrush for convenience.\n- WARRANTY: Comes with a 2-year warranty.	Brand       Oral-B	\N	\N	amz-b0cypcdnwq	AMZ-B0CYPCDNWQ-DEF	\N	Default	\N	f	t	f	\N	\N	349	{"value": "349", "precision": 20}	{}	2026-04-22 16:37:09.815+05	2026-04-22 16:51:17.53+05	\N	\N	f	f
cali_01KPTFKH6J66R7ZWMBBZKK3DZ6	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Default	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	1	variant_01KPT58G2M3NX84CNAZ6PE2WTD	prod_01KPT58FZ1W2CEPTR24NG0MPMX	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Oral-B’s BEST EVER CLEAN with REVOLUTIONARY MAGNETIC iO TECHNOLOGY for a professional clean feeling & gentle brushing experience\n3D Teeth Tracking with A.I to monitor your brushing across the front, top and back surfaces of your teeth; guiding you to the most thorough possible clean\n7 SMART MODES to personalise your brushing: Daily Clean, Sensitive, Gum Care, Intense Clean, Whitening, Tongue Cleaner, Super Sensitive\nCombines the unique round brush head from Oral-B with gentle micro-vibrations for 100% healthier gums in one week\nINTERACTIVE COLOR DISPLAY signals vital information: Including brushing modes and head replacement reminder, greets you as you power up and gives you a smile for a job well done	Imported from Amazon	\N	\N	amz-b09h7ltx4c	AMZ-B09H7LTX4C	\N	Default	\N	f	t	f	\N	\N	969	{"value": "969", "precision": 20}	{}	2026-04-22 16:36:00.978+05	2026-04-22 16:36:03.805+05	2026-04-22 16:36:03.804+05	\N	f	f
cali_01KPTFKSPFPD2PHTTE9QAC25M9	cart_01KPTE5C1RBJWRNT0Q3SQRVGS2	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Default	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	1	variant_01KPT58G2M3NX84CNAZ6PE2WTD	prod_01KPT58FZ1W2CEPTR24NG0MPMX	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Oral-B’s BEST EVER CLEAN with REVOLUTIONARY MAGNETIC iO TECHNOLOGY for a professional clean feeling & gentle brushing experience\n3D Teeth Tracking with A.I to monitor your brushing across the front, top and back surfaces of your teeth; guiding you to the most thorough possible clean\n7 SMART MODES to personalise your brushing: Daily Clean, Sensitive, Gum Care, Intense Clean, Whitening, Tongue Cleaner, Super Sensitive\nCombines the unique round brush head from Oral-B with gentle micro-vibrations for 100% healthier gums in one week\nINTERACTIVE COLOR DISPLAY signals vital information: Including brushing modes and head replacement reminder, greets you as you power up and gives you a smile for a job well done	Imported from Amazon	\N	\N	amz-b09h7ltx4c	AMZ-B09H7LTX4C	\N	Default	\N	f	t	f	\N	\N	969	{"value": "969", "precision": 20}	{}	2026-04-22 16:36:09.679+05	2026-04-22 16:36:09.679+05	\N	\N	f	f
cali_01KPTJ92KYT6RV26ZM9TSWPGXQ	cart_01KPTE5BZ50ZW6HZSH82VFS5HD	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Default	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	1	variant_01KPT58G2M3NX84CNAZ6PE2WTD	prod_01KPT58FZ1W2CEPTR24NG0MPMX	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	Oral-B’s BEST EVER CLEAN with REVOLUTIONARY MAGNETIC iO TECHNOLOGY for a professional clean feeling & gentle brushing experience\n3D Teeth Tracking with A.I to monitor your brushing across the front, top and back surfaces of your teeth; guiding you to the most thorough possible clean\n7 SMART MODES to personalise your brushing: Daily Clean, Sensitive, Gum Care, Intense Clean, Whitening, Tongue Cleaner, Super Sensitive\nCombines the unique round brush head from Oral-B with gentle micro-vibrations for 100% healthier gums in one week\nINTERACTIVE COLOR DISPLAY signals vital information: Including brushing modes and head replacement reminder, greets you as you power up and gives you a smile for a job well done	Imported from Amazon	\N	\N	amz-b09h7ltx4c	AMZ-B09H7LTX4C	\N	Default	\N	f	t	f	\N	\N	969	{"value": "969", "precision": 20}	{}	2026-04-22 17:22:44.095+05	2026-04-22 17:22:44.095+05	\N	\N	f	f
\.


--
-- Data for Name: cart_line_item_adjustment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_line_item_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, metadata, created_at, updated_at, deleted_at, item_id, is_tax_inclusive) FROM stdin;
\.


--
-- Data for Name: cart_line_item_tax_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_line_item_tax_line (id, description, tax_rate_id, code, rate, provider_id, metadata, created_at, updated_at, deleted_at, item_id) FROM stdin;
\.


--
-- Data for Name: cart_payment_collection; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_payment_collection (cart_id, payment_collection_id, id, created_at, updated_at, deleted_at) FROM stdin;
cart_01KPDX1CXSX3V8FYD72HD2MX1N	pay_col_01KPDX1FN3RNDADM6MRRFG1THW	capaycol_01KPDX1FN9KTJVR74FT7P6R10W	2026-04-17 19:20:42.025571+05	2026-04-17 19:20:42.025571+05	\N
cart_01KPHB2MC9PQG2PKE6PW5FQCRZ	pay_col_01KPHBERPAZE115RV7E3RVGYVC	capaycol_01KPHBERPVRQ2RV28MWP86GDV2	2026-04-19 03:30:20.634712+05	2026-04-19 03:30:20.634712+05	\N
cart_01KPHB2M598PASVWWHE75YZMEJ	pay_col_01KPT699TFTPN0WCK3SXGBNAMB	capaycol_01KPT699V22ZBYXV6BT9D07TCB	2026-04-22 13:53:08.578017+05	2026-04-22 13:53:08.578017+05	\N
\.


--
-- Data for Name: cart_promotion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_promotion (cart_id, promotion_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: cart_shipping_method; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_shipping_method (id, cart_id, name, description, amount, raw_amount, is_tax_inclusive, shipping_option_id, data, metadata, created_at, updated_at, deleted_at) FROM stdin;
casm_01KPDX1ESWDBR2Y0MQ4X4NN5XW	cart_01KPDX1CXSX3V8FYD72HD2MX1N	Standard Shipping	\N	20	{"value": "20", "precision": 20}	f	so_01KPC3ZE792AK7TCQSYKEQ2G5S	{}	\N	2026-04-17 19:20:41.148+05	2026-04-17 19:20:41.149+05	\N
casm_01KPHBER8EQ8CV72NF1C0S1PFJ	cart_01KPHB2MC9PQG2PKE6PW5FQCRZ	Standard Shipping	\N	20	{"value": "20", "precision": 20}	f	so_01KPC3ZE792AK7TCQSYKEQ2G5S	{}	\N	2026-04-19 03:30:20.174+05	2026-04-19 03:30:20.174+05	\N
casm_01KPT6995ENHK7PX7ABZZQWWPW	cart_01KPHB2M598PASVWWHE75YZMEJ	Standard Shipping	\N	20	{"value": "20", "precision": 20}	f	so_01KPC3ZE792AK7TCQSYKEQ2G5S	{}	\N	2026-04-22 13:53:07.886+05	2026-04-22 13:53:07.886+05	\N
\.


--
-- Data for Name: cart_shipping_method_adjustment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_shipping_method_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, metadata, created_at, updated_at, deleted_at, shipping_method_id) FROM stdin;
\.


--
-- Data for Name: cart_shipping_method_tax_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_shipping_method_tax_line (id, description, tax_rate_id, code, rate, provider_id, metadata, created_at, updated_at, deleted_at, shipping_method_id) FROM stdin;
\.


--
-- Data for Name: credit_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credit_line (id, cart_id, reference, reference_id, amount, raw_amount, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.currency (code, symbol, symbol_native, decimal_digits, rounding, raw_rounding, name, created_at, updated_at, deleted_at) FROM stdin;
usd	$	$	2	0	{"value": "0", "precision": 20}	US Dollar	2026-04-17 02:43:11.988+05	2026-04-17 02:43:11.988+05	\N
cad	CA$	$	2	0	{"value": "0", "precision": 20}	Canadian Dollar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
eur	€	€	2	0	{"value": "0", "precision": 20}	Euro	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
aed	AED	د.إ.‏	2	0	{"value": "0", "precision": 20}	United Arab Emirates Dirham	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
afn	Af	؋	0	0	{"value": "0", "precision": 20}	Afghan Afghani	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
all	ALL	Lek	0	0	{"value": "0", "precision": 20}	Albanian Lek	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
amd	AMD	դր.	0	0	{"value": "0", "precision": 20}	Armenian Dram	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
ars	AR$	$	2	0	{"value": "0", "precision": 20}	Argentine Peso	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
aud	AU$	$	2	0	{"value": "0", "precision": 20}	Australian Dollar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
azn	man.	ман.	2	0	{"value": "0", "precision": 20}	Azerbaijani Manat	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bam	KM	KM	2	0	{"value": "0", "precision": 20}	Bosnia-Herzegovina Convertible Mark	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bdt	Tk	৳	2	0	{"value": "0", "precision": 20}	Bangladeshi Taka	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bgn	BGN	лв.	2	0	{"value": "0", "precision": 20}	Bulgarian Lev	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bhd	BD	د.ب.‏	3	0	{"value": "0", "precision": 20}	Bahraini Dinar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bif	FBu	FBu	0	0	{"value": "0", "precision": 20}	Burundian Franc	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bnd	BN$	$	2	0	{"value": "0", "precision": 20}	Brunei Dollar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bob	Bs	Bs	2	0	{"value": "0", "precision": 20}	Bolivian Boliviano	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
brl	R$	R$	2	0	{"value": "0", "precision": 20}	Brazilian Real	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bwp	BWP	P	2	0	{"value": "0", "precision": 20}	Botswanan Pula	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
byn	Br	руб.	2	0	{"value": "0", "precision": 20}	Belarusian Ruble	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
bzd	BZ$	$	2	0	{"value": "0", "precision": 20}	Belize Dollar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
cdf	CDF	FrCD	2	0	{"value": "0", "precision": 20}	Congolese Franc	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
chf	CHF	CHF	2	0.05	{"value": "0.05", "precision": 20}	Swiss Franc	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
clp	CL$	$	0	0	{"value": "0", "precision": 20}	Chilean Peso	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
cny	CN¥	CN¥	2	0	{"value": "0", "precision": 20}	Chinese Yuan	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
cop	CO$	$	0	0	{"value": "0", "precision": 20}	Colombian Peso	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
crc	₡	₡	0	0	{"value": "0", "precision": 20}	Costa Rican Colón	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
cve	CV$	CV$	2	0	{"value": "0", "precision": 20}	Cape Verdean Escudo	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
czk	Kč	Kč	2	0	{"value": "0", "precision": 20}	Czech Republic Koruna	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
djf	Fdj	Fdj	0	0	{"value": "0", "precision": 20}	Djiboutian Franc	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
dkk	Dkr	kr	2	0	{"value": "0", "precision": 20}	Danish Krone	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
dop	RD$	RD$	2	0	{"value": "0", "precision": 20}	Dominican Peso	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
dzd	DA	د.ج.‏	2	0	{"value": "0", "precision": 20}	Algerian Dinar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
eek	Ekr	kr	2	0	{"value": "0", "precision": 20}	Estonian Kroon	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
egp	EGP	ج.م.‏	2	0	{"value": "0", "precision": 20}	Egyptian Pound	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
ern	Nfk	Nfk	2	0	{"value": "0", "precision": 20}	Eritrean Nakfa	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
etb	Br	Br	2	0	{"value": "0", "precision": 20}	Ethiopian Birr	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
gbp	£	£	2	0	{"value": "0", "precision": 20}	British Pound Sterling	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
gel	GEL	GEL	2	0	{"value": "0", "precision": 20}	Georgian Lari	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
ghs	GH₵	GH₵	2	0	{"value": "0", "precision": 20}	Ghanaian Cedi	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
gnf	FG	FG	0	0	{"value": "0", "precision": 20}	Guinean Franc	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
gtq	GTQ	Q	2	0	{"value": "0", "precision": 20}	Guatemalan Quetzal	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
hkd	HK$	$	2	0	{"value": "0", "precision": 20}	Hong Kong Dollar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
hnl	HNL	L	2	0	{"value": "0", "precision": 20}	Honduran Lempira	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
hrk	kn	kn	2	0	{"value": "0", "precision": 20}	Croatian Kuna	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
huf	Ft	Ft	0	0	{"value": "0", "precision": 20}	Hungarian Forint	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
idr	Rp	Rp	0	0	{"value": "0", "precision": 20}	Indonesian Rupiah	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
ils	₪	₪	2	0	{"value": "0", "precision": 20}	Israeli New Sheqel	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
inr	Rs	₹	2	0	{"value": "0", "precision": 20}	Indian Rupee	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
iqd	IQD	د.ع.‏	0	0	{"value": "0", "precision": 20}	Iraqi Dinar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
irr	IRR	﷼	0	0	{"value": "0", "precision": 20}	Iranian Rial	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
isk	Ikr	kr	0	0	{"value": "0", "precision": 20}	Icelandic Króna	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
jmd	J$	$	2	0	{"value": "0", "precision": 20}	Jamaican Dollar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
jod	JD	د.أ.‏	3	0	{"value": "0", "precision": 20}	Jordanian Dinar	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
jpy	¥	￥	0	0	{"value": "0", "precision": 20}	Japanese Yen	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
kes	Ksh	Ksh	2	0	{"value": "0", "precision": 20}	Kenyan Shilling	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
khr	KHR	៛	2	0	{"value": "0", "precision": 20}	Cambodian Riel	2026-04-17 02:43:11.989+05	2026-04-17 02:43:11.989+05	\N
kmf	CF	FC	0	0	{"value": "0", "precision": 20}	Comorian Franc	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
krw	₩	₩	0	0	{"value": "0", "precision": 20}	South Korean Won	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
kwd	KD	د.ك.‏	3	0	{"value": "0", "precision": 20}	Kuwaiti Dinar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
kzt	KZT	тңг.	2	0	{"value": "0", "precision": 20}	Kazakhstani Tenge	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
lbp	LB£	ل.ل.‏	0	0	{"value": "0", "precision": 20}	Lebanese Pound	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
lkr	SLRs	SL Re	2	0	{"value": "0", "precision": 20}	Sri Lankan Rupee	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
ltl	Lt	Lt	2	0	{"value": "0", "precision": 20}	Lithuanian Litas	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
lvl	Ls	Ls	2	0	{"value": "0", "precision": 20}	Latvian Lats	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
lyd	LD	د.ل.‏	3	0	{"value": "0", "precision": 20}	Libyan Dinar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mad	MAD	د.م.‏	2	0	{"value": "0", "precision": 20}	Moroccan Dirham	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mdl	MDL	MDL	2	0	{"value": "0", "precision": 20}	Moldovan Leu	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mga	MGA	MGA	0	0	{"value": "0", "precision": 20}	Malagasy Ariary	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mkd	MKD	MKD	2	0	{"value": "0", "precision": 20}	Macedonian Denar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mmk	MMK	K	0	0	{"value": "0", "precision": 20}	Myanma Kyat	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mnt	MNT	₮	0	0	{"value": "0", "precision": 20}	Mongolian Tugrig	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mop	MOP$	MOP$	2	0	{"value": "0", "precision": 20}	Macanese Pataca	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mur	MURs	MURs	0	0	{"value": "0", "precision": 20}	Mauritian Rupee	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mwk	K	K	2	0	{"value": "0", "precision": 20}	Malawian Kwacha	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mxn	MX$	$	2	0	{"value": "0", "precision": 20}	Mexican Peso	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
myr	RM	RM	2	0	{"value": "0", "precision": 20}	Malaysian Ringgit	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
mzn	MTn	MTn	2	0	{"value": "0", "precision": 20}	Mozambican Metical	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
nad	N$	N$	2	0	{"value": "0", "precision": 20}	Namibian Dollar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
ngn	₦	₦	2	0	{"value": "0", "precision": 20}	Nigerian Naira	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
nio	C$	C$	2	0	{"value": "0", "precision": 20}	Nicaraguan Córdoba	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
nok	Nkr	kr	2	0	{"value": "0", "precision": 20}	Norwegian Krone	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
npr	NPRs	नेरू	2	0	{"value": "0", "precision": 20}	Nepalese Rupee	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
nzd	NZ$	$	2	0	{"value": "0", "precision": 20}	New Zealand Dollar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
omr	OMR	ر.ع.‏	3	0	{"value": "0", "precision": 20}	Omani Rial	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
pab	B/.	B/.	2	0	{"value": "0", "precision": 20}	Panamanian Balboa	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
pen	S/.	S/.	2	0	{"value": "0", "precision": 20}	Peruvian Nuevo Sol	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
php	₱	₱	2	0	{"value": "0", "precision": 20}	Philippine Peso	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
pkr	PKRs	₨	0	0	{"value": "0", "precision": 20}	Pakistani Rupee	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
pln	zł	zł	2	0	{"value": "0", "precision": 20}	Polish Zloty	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
pyg	₲	₲	0	0	{"value": "0", "precision": 20}	Paraguayan Guarani	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
qar	QR	ر.ق.‏	2	0	{"value": "0", "precision": 20}	Qatari Rial	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
ron	RON	RON	2	0	{"value": "0", "precision": 20}	Romanian Leu	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
rsd	din.	дин.	0	0	{"value": "0", "precision": 20}	Serbian Dinar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
rub	RUB	₽.	2	0	{"value": "0", "precision": 20}	Russian Ruble	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
rwf	RWF	FR	0	0	{"value": "0", "precision": 20}	Rwandan Franc	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
sar	SR	ر.س.‏	2	0	{"value": "0", "precision": 20}	Saudi Riyal	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
sdg	SDG	SDG	2	0	{"value": "0", "precision": 20}	Sudanese Pound	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
sek	Skr	kr	2	0	{"value": "0", "precision": 20}	Swedish Krona	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
sgd	S$	$	2	0	{"value": "0", "precision": 20}	Singapore Dollar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
sos	Ssh	Ssh	0	0	{"value": "0", "precision": 20}	Somali Shilling	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
syp	SY£	ل.س.‏	0	0	{"value": "0", "precision": 20}	Syrian Pound	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
thb	฿	฿	2	0	{"value": "0", "precision": 20}	Thai Baht	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
tnd	DT	د.ت.‏	3	0	{"value": "0", "precision": 20}	Tunisian Dinar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
top	T$	T$	2	0	{"value": "0", "precision": 20}	Tongan Paʻanga	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
tjs	TJS	с.	2	0	{"value": "0", "precision": 20}	Tajikistani Somoni	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
try	₺	₺	2	0	{"value": "0", "precision": 20}	Turkish Lira	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
ttd	TT$	$	2	0	{"value": "0", "precision": 20}	Trinidad and Tobago Dollar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
twd	NT$	NT$	2	0	{"value": "0", "precision": 20}	New Taiwan Dollar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
tzs	TSh	TSh	0	0	{"value": "0", "precision": 20}	Tanzanian Shilling	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
uah	₴	₴	2	0	{"value": "0", "precision": 20}	Ukrainian Hryvnia	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
ugx	USh	USh	0	0	{"value": "0", "precision": 20}	Ugandan Shilling	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
uyu	$U	$	2	0	{"value": "0", "precision": 20}	Uruguayan Peso	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
uzs	UZS	UZS	0	0	{"value": "0", "precision": 20}	Uzbekistan Som	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
vef	Bs.F.	Bs.F.	2	0	{"value": "0", "precision": 20}	Venezuelan Bolívar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
vnd	₫	₫	0	0	{"value": "0", "precision": 20}	Vietnamese Dong	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
xaf	FCFA	FCFA	0	0	{"value": "0", "precision": 20}	CFA Franc BEAC	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
xof	CFA	CFA	0	0	{"value": "0", "precision": 20}	CFA Franc BCEAO	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
xpf	₣	₣	0	0	{"value": "0", "precision": 20}	CFP Franc	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
yer	YR	ر.ي.‏	0	0	{"value": "0", "precision": 20}	Yemeni Rial	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
zar	R	R	2	0	{"value": "0", "precision": 20}	South African Rand	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
zmk	ZK	ZK	0	0	{"value": "0", "precision": 20}	Zambian Kwacha	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
zwl	ZWL$	ZWL$	0	0	{"value": "0", "precision": 20}	Zimbabwean Dollar	2026-04-17 02:43:11.99+05	2026-04-17 02:43:11.99+05	\N
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer (id, company_name, first_name, last_name, email, phone, has_account, metadata, created_at, updated_at, deleted_at, created_by) FROM stdin;
cus_01KPDX1DTHCVZT4PAKC7NYXB40	\N	\N	\N	test@dentauae.com	\N	f	\N	2026-04-17 19:20:40.145+05	2026-04-17 19:20:40.145+05	\N	\N
cus_01KPHBEQ8GW57TKN2C824BS4FH	\N	\N	\N	test@example.com	\N	f	\N	2026-04-19 03:30:19.153+05	2026-04-19 03:30:19.153+05	\N	\N
cus_01KPT69820YQ6YCJHC4SD5V9W7	\N	\N	\N	shaheryarahmed.awan@gmail.com	\N	f	\N	2026-04-22 13:53:06.753+05	2026-04-22 13:53:06.753+05	\N	\N
\.


--
-- Data for Name: customer_account_holder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_account_holder (customer_id, account_holder_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: customer_address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_address (id, customer_id, address_name, is_default_shipping, is_default_billing, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: customer_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_group (id, name, metadata, created_by, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: customer_group_customer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_group_customer (id, customer_id, customer_group_id, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
\.


--
-- Data for Name: fulfillment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fulfillment (id, location_id, packed_at, shipped_at, delivered_at, canceled_at, data, provider_id, shipping_option_id, metadata, delivery_address_id, created_at, updated_at, deleted_at, marked_shipped_by, created_by, requires_shipping) FROM stdin;
ful_01KPT7M1MAC2KPFRC11B15Q2MB	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	2026-04-22 14:16:29.173+05	\N	\N	\N	{}	manual_manual	so_01KPC3ZE79FE9YYM62X80JWK3Y	\N	fuladdr_01KPT7M1MAFF6VC5RC8RE53ZKQ	2026-04-22 14:16:29.196+05	2026-04-22 14:16:29.248+05	\N	\N	\N	f
ful_01KPT7W5MD2FRXJWVVS1KXGQ2P	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	2026-04-22 14:20:55.422+05	2026-04-22 14:21:39.469+05	\N	\N	{}	manual_manual	so_01KPC3ZE79FE9YYM62X80JWK3Y	\N	fuladdr_01KPT7W5MDH9C1YFKG3CAJQE07	2026-04-22 14:20:55.438+05	2026-04-22 14:21:39.546+05	\N	user_01KPE8HZ9CRAXYVDM1KCXH81FA	\N	t
\.


--
-- Data for Name: fulfillment_address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fulfillment_address (id, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
fuladdr_01KPT7M1MAFF6VC5RC8RE53ZKQ	\N	Sharyar 	Ahmed	House 12 	\N	Dubai	ae	Dubai	\N	+923342626544	\N	2026-04-22 13:53:06.787+05	2026-04-22 13:53:06.787+05	\N
fuladdr_01KPT7W5MDH9C1YFKG3CAJQE07	\N	Test	User	Al Barsha 1	\N	Dubai	ae	\N	\N	0501234567	\N	2026-04-17 19:20:40.157+05	2026-04-17 19:20:40.157+05	\N
\.


--
-- Data for Name: fulfillment_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fulfillment_item (id, title, sku, barcode, quantity, raw_quantity, line_item_id, inventory_item_id, fulfillment_id, created_at, updated_at, deleted_at) FROM stdin;
fulit_01KPT7M1M9C5WHBBHK24YWGTNB	Default	AMZ-B07N156DRR		1	{"value": "1", "precision": 20}	ordli_01KPT69A6VRNH4RJF2QZQXS1HR	\N	ful_01KPT7M1MAC2KPFRC11B15Q2MB	2026-04-22 14:16:29.198+05	2026-04-22 14:16:29.198+05	\N
fulit_01KPT7W5MDWMNTGKEF2P28PW9K	Rose Quartz	IO-9-PNK		1	{"value": "1", "precision": 20}	ordli_01KPDX1FWC759XFJSST1FQEH7Z	iitem_01KPC3ZEA9MBQEZ6QBXVGSYX0Z	ful_01KPT7W5MD2FRXJWVVS1KXGQ2P	2026-04-22 14:20:55.438+05	2026-04-22 14:20:55.438+05	\N
\.


--
-- Data for Name: fulfillment_label; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fulfillment_label (id, tracking_number, tracking_url, label_url, fulfillment_id, created_at, updated_at, deleted_at) FROM stdin;
fulla_01KPT7XGPQD6PDV6PCVG0TJ383	GC10456503AE	https://gulfexpress.org/	#	ful_01KPT7W5MD2FRXJWVVS1KXGQ2P	2026-04-22 14:21:39.545+05	2026-04-22 14:21:39.545+05	\N
\.


--
-- Data for Name: fulfillment_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fulfillment_provider (id, is_enabled, created_at, updated_at, deleted_at) FROM stdin;
manual_manual	t	2026-04-17 02:43:12.003+05	2026-04-17 02:43:12.003+05	\N
\.


--
-- Data for Name: fulfillment_set; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fulfillment_set (id, name, type, metadata, created_at, updated_at, deleted_at) FROM stdin;
fuset_01KPC3ZE6FSESSQFDB1EFEPDAG	Dubai Warehouse delivery	shipping	\N	2026-04-17 02:43:26.159+05	2026-04-17 02:43:26.159+05	\N
\.


--
-- Data for Name: geo_zone; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.geo_zone (id, type, country_code, province_code, city, service_zone_id, postal_expression, metadata, created_at, updated_at, deleted_at) FROM stdin;
fgz_01KPTGD8Y8ZBEEFC32ZFRXWMEB	country	ae	\N	\N	serzo_01KPC3ZE6FT7D99MYFQ5BJEQJX	\N	\N	2026-04-22 16:50:04.489+05	2026-04-22 16:50:04.489+05	\N
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.image (id, url, metadata, created_at, updated_at, deleted_at, rank, product_id) FROM stdin;
img_01KPC3ZE938FSZMNZJK7QVYT4T	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N	0	prod_01KPC3ZE917A0KGB12XG5Z6TQG
img_01KPC3ZE931W3AKVYR95YCGJPG	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N	0	prod_01KPC3ZE91W4Y0QDGKEJJYACZG
img_01KPC3ZE9377GFAGC1PWCBE36F	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N	0	prod_01KPC3ZE91QKARBVHWZWTMHG6R
img_01KPT27Q356X3C8D1SS4QHTEA9	https://lh3.googleusercontent.com/aida/ADBb0ujhg6XcViiOJWfNFXFt5ZK8drfuYHWrTxxr8mmggNIPI09rya-gnHhaQGz_-K0IZ4pp6wb84V_NBcIh2g96fHzroIXWd3xCNhmD4kv9jU3eCJEwfFIFG1V0LCqlb5l3kDNK7PKdVpMcjW_Vvxe58gDmjrcp_gzbyCqN6J44VuumTRu1G041LBfWx30Sk3Za6K_-MGX5tvsYkcHzASBO6dVzE_aSLE_Plw2OQPq1NfyNLzGmITJhZl25H19G	\N	2026-04-22 12:42:22.31+05	2026-04-22 12:42:22.31+05	\N	0	prod_01KPT27Q338HRS1NZ5HMZ9P44B
img_01KPT44AA9GEFHZ23KFY0KF66Q	https://m.media-amazon.com/images/I/718Ip2hbsXL._AC_SY355_.jpg	\N	2026-04-22 13:15:28.075+05	2026-04-22 13:15:28.075+05	\N	0	prod_01KPT44AA6GHYWKNFYBVMHG852
img_01KPT4CRZP4E1EK699066Y6FJT	https://m.media-amazon.com/images/I/71CdAA9Fc4L._AC_SY355_.jpg	\N	2026-04-22 13:20:05.238+05	2026-04-22 13:20:05.238+05	\N	0	prod_01KPT4CRZN34GMYQJPRHY1J7CT
img_01KPT58FZ8E6VRD23ZB5J8CQVZ	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	0	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT58FZ89SMWC3CYF35EVAFR	https://m.media-amazon.com/images/I/412QChEbY6L.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	1	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT58FZ8FREH953791AP9SKT	https://m.media-amazon.com/images/I/61HM2jwMJpL.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	2	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT58FZ8MSXXRMZJA03KYCF2	https://m.media-amazon.com/images/I/41zTA36a32L.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	3	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT58FZ8NAVVTCF5KJCZH9VS	https://m.media-amazon.com/images/I/41-dFQxgclL.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	4	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT58FZ8Q4PB5D6QH1M6AEN9	https://m.media-amazon.com/images/I/41zIGkYz93L.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	5	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT58FZ8DZQNR84NRZQP20B0	https://m.media-amazon.com/images/I/41SxvmUE2gL.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	6	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT58FZ88K723PZ8B59DGE7Y	https://m.media-amazon.com/images/I/5149UThzLBL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N	7	prod_01KPT58FZ1W2CEPTR24NG0MPMX
img_01KPT5ERQ3VXYMKZ4SM5RDCGKY	https://m.media-amazon.com/images/I/612EPqaPzwL.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	0	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5ERQ39AANYT0Q23M763J7	https://m.media-amazon.com/images/I/41yUdKNYu8L.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	1	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5ERQ34XA60QWX5H1V68ZR	https://m.media-amazon.com/images/I/41clYgjw4pL.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	2	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5ERQ347NFX2RMB5H4PBA8	https://m.media-amazon.com/images/I/41-Go5MdeOL.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	3	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5ERQ341DH927XM3SGCM74	https://m.media-amazon.com/images/I/41BgdUmXFuL.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	4	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5ERQ3CW8H5HJ375GE4PV7	https://m.media-amazon.com/images/I/41srlaMumaL.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	5	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5ERQ35WQC2MHRMNEWG0VB	https://m.media-amazon.com/images/I/416xcf+0jxL.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	6	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5ERQ3VD1HFB1HQN7ND5Q4	https://m.media-amazon.com/images/I/71Z2QS8Xq1L.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	7	prod_01KPT5ERQ0G3S23FS9FC1S2NX4
img_01KPT5GB4AYYHVXJTXWWYJ33NG	https://m.media-amazon.com/images/I/71Bu7r4vkWL.jpg	\N	2026-04-22 13:39:30.699+05	2026-04-22 13:39:30.699+05	\N	0	prod_01KPT5GB487QQMWCYV852JCV72
img_01KPT5GB4A5NSR3D4B1CESV93T	https://m.media-amazon.com/images/I/415NMNgZuVL.jpg	\N	2026-04-22 13:39:30.7+05	2026-04-22 13:39:30.7+05	\N	1	prod_01KPT5GB487QQMWCYV852JCV72
img_01KPT5GB4ATKR5VT5PEBW5E9R2	https://m.media-amazon.com/images/I/51uQg1x1cvL.jpg	\N	2026-04-22 13:39:30.7+05	2026-04-22 13:39:30.7+05	\N	2	prod_01KPT5GB487QQMWCYV852JCV72
img_01KPT5GB4BRY72GTCT382BZVJ8	https://m.media-amazon.com/images/I/41vro21j9bL.jpg	\N	2026-04-22 13:39:30.7+05	2026-04-22 13:39:30.7+05	\N	3	prod_01KPT5GB487QQMWCYV852JCV72
img_01KPT5GB4BJVSMN9NPRS2SY4NB	https://m.media-amazon.com/images/I/41oOxyhoRFL.jpg	\N	2026-04-22 13:39:30.7+05	2026-04-22 13:39:30.7+05	\N	4	prod_01KPT5GB487QQMWCYV852JCV72
img_01KPT5GB4BM8Z2MKB6M6HKBG1Y	https://m.media-amazon.com/images/I/51JFXxpddHL.jpg	\N	2026-04-22 13:39:30.7+05	2026-04-22 13:39:30.7+05	\N	5	prod_01KPT5GB487QQMWCYV852JCV72
img_01KPT5GB4BD94FDC4T4WACGR1J	https://m.media-amazon.com/images/I/41tGSFz1hWL.jpg	\N	2026-04-22 13:39:30.7+05	2026-04-22 13:39:30.7+05	\N	6	prod_01KPT5GB487QQMWCYV852JCV72
img_01KPTEEHQ8BXG4X25CXNCS0WS5	https://m.media-amazon.com/images/I/61PoBuu-9NL.jpg	\N	2026-04-22 16:15:49.097+05	2026-04-22 16:15:49.097+05	\N	0	prod_01KPTEEHQ69G0EP1YYS8GCDMM1
img_01KPTFND3Q05HV7WWP0GMGBARP	https://m.media-amazon.com/images/I/712zxPvIHxL.jpg	\N	2026-04-22 16:37:02.33+05	2026-04-22 16:37:02.33+05	\N	0	prod_01KPTFND37SAFPP8RPPGTAG7CP
\.


--
-- Data for Name: inventory_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_item (id, created_at, updated_at, deleted_at, sku, origin_country, hs_code, mid_code, material, weight, length, height, width, requires_shipping, description, title, thumbnail, metadata) FROM stdin;
iitem_01KPC3ZEA93QVC0PZXNJZ89G6T	2026-04-17 02:43:26.281+05	2026-04-17 02:43:26.281+05	\N	IO-9-BLK	\N	\N	\N	\N	\N	\N	\N	\N	t	Onyx Black	Onyx Black	\N	\N
iitem_01KPC3ZEA9MBQEZ6QBXVGSYX0Z	2026-04-17 02:43:26.281+05	2026-04-17 02:43:26.281+05	\N	IO-9-PNK	\N	\N	\N	\N	\N	\N	\N	\N	t	Rose Quartz	Rose Quartz	\N	\N
iitem_01KPC3ZEA9K59ECR0YC8RHYFQ1	2026-04-17 02:43:26.281+05	2026-04-17 02:43:26.281+05	\N	IO-9-WHT	\N	\N	\N	\N	\N	\N	\N	\N	t	Alabaster White	Alabaster White	\N	\N
iitem_01KPC3ZEA91VFC4PPTD99BRHWJ	2026-04-17 02:43:26.281+05	2026-04-17 02:43:26.281+05	\N	IO-7-WHT	\N	\N	\N	\N	\N	\N	\N	\N	t	White	White	\N	\N
iitem_01KPC3ZEA9Y3X7A601MCGP3EEN	2026-04-17 02:43:26.281+05	2026-04-17 02:43:26.281+05	\N	IO-HEADS-4CT	\N	\N	\N	\N	\N	\N	\N	\N	t	4 Count Pack	4 Count Pack	\N	\N
\.


--
-- Data for Name: inventory_level; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_level (id, created_at, updated_at, deleted_at, inventory_item_id, location_id, stocked_quantity, reserved_quantity, incoming_quantity, metadata, raw_stocked_quantity, raw_reserved_quantity, raw_incoming_quantity) FROM stdin;
ilev_01KPC3ZEB8455TFPX29NB9A7V1	2026-04-17 02:43:26.313+05	2026-04-17 02:43:26.313+05	\N	iitem_01KPC3ZEA91VFC4PPTD99BRHWJ	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	100	0	0	\N	{"value": "100", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01KPC3ZEB89W75824B6Q48GNFV	2026-04-17 02:43:26.313+05	2026-04-17 02:43:26.313+05	\N	iitem_01KPC3ZEA93QVC0PZXNJZ89G6T	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	100	0	0	\N	{"value": "100", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01KPC3ZEB8BT7541R8ECP5C6WE	2026-04-17 02:43:26.313+05	2026-04-17 02:43:26.313+05	\N	iitem_01KPC3ZEA9K59ECR0YC8RHYFQ1	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	100	0	0	\N	{"value": "100", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01KPC3ZEB9ACS1ADS3YT826MZX	2026-04-17 02:43:26.313+05	2026-04-17 02:43:26.313+05	\N	iitem_01KPC3ZEA9Y3X7A601MCGP3EEN	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	100	0	0	\N	{"value": "100", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01KPC3ZEB9X82KXJJDRE7JH5HM	2026-04-17 02:43:26.313+05	2026-04-22 14:20:55.52+05	\N	iitem_01KPC3ZEA9MBQEZ6QBXVGSYX0Z	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	99	0	0	\N	{"value": "99", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
\.


--
-- Data for Name: invite; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invite (id, email, accepted, token, expires_at, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: invite_rbac_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invite_rbac_role (invite_id, rbac_role_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: link_module_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.link_module_migrations (id, table_name, link_descriptor, created_at) FROM stdin;
1	cart_payment_collection	{"toModel": "payment_collection", "toModule": "payment", "fromModel": "cart", "fromModule": "cart"}	2026-04-17 02:43:09.791727
2	cart_promotion	{"toModel": "promotions", "toModule": "promotion", "fromModel": "cart", "fromModule": "cart"}	2026-04-17 02:43:09.798411
3	customer_account_holder	{"toModel": "account_holder", "toModule": "payment", "fromModel": "customer", "fromModule": "customer"}	2026-04-17 02:43:09.802344
4	location_fulfillment_provider	{"toModel": "fulfillment_provider", "toModule": "fulfillment", "fromModel": "location", "fromModule": "stock_location"}	2026-04-17 02:43:09.806655
5	location_fulfillment_set	{"toModel": "fulfillment_set", "toModule": "fulfillment", "fromModel": "location", "fromModule": "stock_location"}	2026-04-17 02:43:09.810842
6	invite_rbac_role	{"toModel": "rbac_role", "toModule": "rbac", "fromModel": "invite", "fromModule": "user"}	2026-04-17 02:43:09.814565
7	order_cart	{"toModel": "cart", "toModule": "cart", "fromModel": "order", "fromModule": "order"}	2026-04-17 02:43:09.818482
8	order_fulfillment	{"toModel": "fulfillments", "toModule": "fulfillment", "fromModel": "order", "fromModule": "order"}	2026-04-17 02:43:09.822118
9	order_payment_collection	{"toModel": "payment_collection", "toModule": "payment", "fromModel": "order", "fromModule": "order"}	2026-04-17 02:43:09.825697
10	order_promotion	{"toModel": "promotions", "toModule": "promotion", "fromModel": "order", "fromModule": "order"}	2026-04-17 02:43:09.829101
11	return_fulfillment	{"toModel": "fulfillments", "toModule": "fulfillment", "fromModel": "return", "fromModule": "order"}	2026-04-17 02:43:09.833113
12	product_sales_channel	{"toModel": "sales_channel", "toModule": "sales_channel", "fromModel": "product", "fromModule": "product"}	2026-04-17 02:43:09.836941
13	product_shipping_profile	{"toModel": "shipping_profile", "toModule": "fulfillment", "fromModel": "product", "fromModule": "product"}	2026-04-17 02:43:09.840902
14	product_variant_inventory_item	{"toModel": "inventory", "toModule": "inventory", "fromModel": "variant", "fromModule": "product"}	2026-04-17 02:43:09.844817
15	product_variant_price_set	{"toModel": "price_set", "toModule": "pricing", "fromModel": "variant", "fromModule": "product"}	2026-04-17 02:43:09.848629
16	publishable_api_key_sales_channel	{"toModel": "sales_channel", "toModule": "sales_channel", "fromModel": "api_key", "fromModule": "api_key"}	2026-04-17 02:43:09.85274
17	region_payment_provider	{"toModel": "payment_provider", "toModule": "payment", "fromModel": "region", "fromModule": "region"}	2026-04-17 02:43:09.85619
18	sales_channel_stock_location	{"toModel": "location", "toModule": "stock_location", "fromModel": "sales_channel", "fromModule": "sales_channel"}	2026-04-17 02:43:09.860149
19	shipping_option_price_set	{"toModel": "price_set", "toModule": "pricing", "fromModel": "shipping_option", "fromModule": "fulfillment"}	2026-04-17 02:43:09.864656
20	user_rbac_role	{"toModel": "rbac_role", "toModule": "rbac", "fromModel": "user", "fromModule": "user"}	2026-04-17 02:43:09.868277
\.


--
-- Data for Name: location_fulfillment_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.location_fulfillment_provider (stock_location_id, fulfillment_provider_id, id, created_at, updated_at, deleted_at) FROM stdin;
sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	manual_manual	locfp_01KPC3ZE6865E885421Z2ZWJB0	2026-04-17 02:43:26.152567+05	2026-04-17 02:43:26.152567+05	\N
\.


--
-- Data for Name: location_fulfillment_set; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.location_fulfillment_set (stock_location_id, fulfillment_set_id, id, created_at, updated_at, deleted_at) FROM stdin;
sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	fuset_01KPC3ZE6FSESSQFDB1EFEPDAG	locfs_01KPC3ZE6P0WFF3Z6WZ0Y8GYQF	2026-04-17 02:43:26.167262+05	2026-04-17 02:43:26.167262+05	\N
\.


--
-- Data for Name: mikro_orm_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.mikro_orm_migrations (id, name, executed_at) FROM stdin;
1	Migration20240307161216	2026-04-17 02:43:04.719648+05
2	Migration20241210073813	2026-04-17 02:43:04.719648+05
3	Migration20250106142624	2026-04-17 02:43:04.719648+05
4	Migration20250120110820	2026-04-17 02:43:04.719648+05
5	Migration20240307132720	2026-04-17 02:43:04.92253+05
6	Migration20240719123015	2026-04-17 02:43:04.92253+05
7	Migration20241213063611	2026-04-17 02:43:04.92253+05
8	Migration20251010131115	2026-04-17 02:43:04.92253+05
9	InitialSetup20240401153642	2026-04-17 02:43:05.049588+05
10	Migration20240601111544	2026-04-17 02:43:05.049588+05
11	Migration202408271511	2026-04-17 02:43:05.049588+05
12	Migration20241122120331	2026-04-17 02:43:05.049588+05
13	Migration20241125090957	2026-04-17 02:43:05.049588+05
14	Migration20250411073236	2026-04-17 02:43:05.049588+05
15	Migration20250516081326	2026-04-17 02:43:05.049588+05
16	Migration20250910154539	2026-04-17 02:43:05.049588+05
17	Migration20250911092221	2026-04-17 02:43:05.049588+05
18	Migration20250929204438	2026-04-17 02:43:05.049588+05
19	Migration20251008132218	2026-04-17 02:43:05.049588+05
20	Migration20251011090511	2026-04-17 02:43:05.049588+05
21	Migration20230929122253	2026-04-17 02:43:05.365274+05
22	Migration20240322094407	2026-04-17 02:43:05.365274+05
23	Migration20240322113359	2026-04-17 02:43:05.365274+05
24	Migration20240322120125	2026-04-17 02:43:05.365274+05
25	Migration20240626133555	2026-04-17 02:43:05.365274+05
26	Migration20240704094505	2026-04-17 02:43:05.365274+05
27	Migration20241127114534	2026-04-17 02:43:05.365274+05
28	Migration20241127223829	2026-04-17 02:43:05.365274+05
29	Migration20241128055359	2026-04-17 02:43:05.365274+05
30	Migration20241212190401	2026-04-17 02:43:05.365274+05
31	Migration20250408145122	2026-04-17 02:43:05.365274+05
32	Migration20250409122219	2026-04-17 02:43:05.365274+05
33	Migration20251009110625	2026-04-17 02:43:05.365274+05
34	Migration20251112192723	2026-04-17 02:43:05.365274+05
35	Migration20240227120221	2026-04-17 02:43:05.5617+05
36	Migration20240617102917	2026-04-17 02:43:05.5617+05
37	Migration20240624153824	2026-04-17 02:43:05.5617+05
38	Migration20241211061114	2026-04-17 02:43:05.5617+05
39	Migration20250113094144	2026-04-17 02:43:05.5617+05
40	Migration20250120110700	2026-04-17 02:43:05.5617+05
41	Migration20250226130616	2026-04-17 02:43:05.5617+05
42	Migration20250508081510	2026-04-17 02:43:05.5617+05
43	Migration20250828075407	2026-04-17 02:43:05.5617+05
44	Migration20250909083125	2026-04-17 02:43:05.5617+05
45	Migration20250916120552	2026-04-17 02:43:05.5617+05
46	Migration20250917143818	2026-04-17 02:43:05.5617+05
47	Migration20250919122137	2026-04-17 02:43:05.5617+05
48	Migration20251006000000	2026-04-17 02:43:05.5617+05
49	Migration20251015113934	2026-04-17 02:43:05.5617+05
50	Migration20251107050148	2026-04-17 02:43:05.5617+05
51	Migration20240124154000	2026-04-17 02:43:05.749006+05
52	Migration20240524123112	2026-04-17 02:43:05.749006+05
53	Migration20240602110946	2026-04-17 02:43:05.749006+05
54	Migration20241211074630	2026-04-17 02:43:05.749006+05
55	Migration20251010130829	2026-04-17 02:43:05.749006+05
56	Migration20240115152146	2026-04-17 02:43:05.851314+05
57	Migration20240222170223	2026-04-17 02:43:06.007637+05
58	Migration20240831125857	2026-04-17 02:43:06.007637+05
59	Migration20241106085918	2026-04-17 02:43:06.007637+05
60	Migration20241205095237	2026-04-17 02:43:06.007637+05
61	Migration20241216183049	2026-04-17 02:43:06.007637+05
62	Migration20241218091938	2026-04-17 02:43:06.007637+05
63	Migration20250120115059	2026-04-17 02:43:06.007637+05
64	Migration20250212131240	2026-04-17 02:43:06.007637+05
65	Migration20250326151602	2026-04-17 02:43:06.007637+05
66	Migration20250508081553	2026-04-17 02:43:06.007637+05
67	Migration20251017153909	2026-04-17 02:43:06.007637+05
68	Migration20251208130704	2026-04-17 02:43:06.007637+05
69	Migration20240205173216	2026-04-17 02:43:06.285144+05
70	Migration20240624200006	2026-04-17 02:43:06.285144+05
71	Migration20250120110744	2026-04-17 02:43:06.285144+05
72	InitialSetup20240221144943	2026-04-17 02:43:06.487528+05
73	Migration20240604080145	2026-04-17 02:43:06.487528+05
74	Migration20241205122700	2026-04-17 02:43:06.487528+05
75	Migration20251015123842	2026-04-17 02:43:06.487528+05
76	InitialSetup20240227075933	2026-04-17 02:43:06.704225+05
77	Migration20240621145944	2026-04-17 02:43:06.704225+05
78	Migration20241206083313	2026-04-17 02:43:06.704225+05
79	Migration20251202184737	2026-04-17 02:43:06.704225+05
80	Migration20251212161429	2026-04-17 02:43:06.704225+05
81	Migration20240227090331	2026-04-17 02:43:06.903197+05
82	Migration20240710135844	2026-04-17 02:43:06.903197+05
83	Migration20240924114005	2026-04-17 02:43:06.903197+05
84	Migration20241212052837	2026-04-17 02:43:06.903197+05
85	InitialSetup20240228133303	2026-04-17 02:43:07.104904+05
86	Migration20240624082354	2026-04-17 02:43:07.104904+05
87	Migration20240225134525	2026-04-17 02:43:07.378327+05
88	Migration20240806072619	2026-04-17 02:43:07.378327+05
89	Migration20241211151053	2026-04-17 02:43:07.378327+05
90	Migration20250115160517	2026-04-17 02:43:07.378327+05
91	Migration20250120110552	2026-04-17 02:43:07.378327+05
92	Migration20250123122334	2026-04-17 02:43:07.378327+05
93	Migration20250206105639	2026-04-17 02:43:07.378327+05
94	Migration20250207132723	2026-04-17 02:43:07.378327+05
95	Migration20250625084134	2026-04-17 02:43:07.378327+05
96	Migration20250924135437	2026-04-17 02:43:07.378327+05
97	Migration20250929124701	2026-04-17 02:43:07.378327+05
98	Migration20240219102530	2026-04-17 02:43:07.529971+05
99	Migration20240604100512	2026-04-17 02:43:07.529971+05
100	Migration20240715102100	2026-04-17 02:43:07.529971+05
101	Migration20240715174100	2026-04-17 02:43:07.529971+05
102	Migration20240716081800	2026-04-17 02:43:07.529971+05
103	Migration20240801085921	2026-04-17 02:43:07.529971+05
104	Migration20240821164505	2026-04-17 02:43:07.529971+05
105	Migration20240821170920	2026-04-17 02:43:07.529971+05
106	Migration20240827133639	2026-04-17 02:43:07.529971+05
107	Migration20240902195921	2026-04-17 02:43:07.529971+05
108	Migration20240913092514	2026-04-17 02:43:07.529971+05
109	Migration20240930122627	2026-04-17 02:43:07.529971+05
110	Migration20241014142943	2026-04-17 02:43:07.529971+05
111	Migration20241106085223	2026-04-17 02:43:07.529971+05
112	Migration20241129124827	2026-04-17 02:43:07.529971+05
113	Migration20241217162224	2026-04-17 02:43:07.529971+05
114	Migration20250326151554	2026-04-17 02:43:07.529971+05
115	Migration20250522181137	2026-04-17 02:43:07.529971+05
116	Migration20250702095353	2026-04-17 02:43:07.529971+05
117	Migration20250704120229	2026-04-17 02:43:07.529971+05
118	Migration20250910130000	2026-04-17 02:43:07.529971+05
119	Migration20251016160403	2026-04-17 02:43:07.529971+05
120	Migration20251016182939	2026-04-17 02:43:07.529971+05
121	Migration20251017155709	2026-04-17 02:43:07.529971+05
122	Migration20251114100559	2026-04-17 02:43:07.529971+05
123	Migration20251125164002	2026-04-17 02:43:07.529971+05
124	Migration20251210112909	2026-04-17 02:43:07.529971+05
125	Migration20251210112924	2026-04-17 02:43:07.529971+05
126	Migration20251225120947	2026-04-17 02:43:07.529971+05
127	Migration20250717162007	2026-04-17 02:43:07.882939+05
128	Migration20240205025928	2026-04-17 02:43:08.006801+05
129	Migration20240529080336	2026-04-17 02:43:08.006801+05
130	Migration20241202100304	2026-04-17 02:43:08.006801+05
131	Migration20240214033943	2026-04-17 02:43:08.372327+05
132	Migration20240703095850	2026-04-17 02:43:08.372327+05
133	Migration20241202103352	2026-04-17 02:43:08.372327+05
134	Migration20240311145700_InitialSetupMigration	2026-04-17 02:43:08.498757+05
135	Migration20240821170957	2026-04-17 02:43:08.498757+05
136	Migration20240917161003	2026-04-17 02:43:08.498757+05
137	Migration20241217110416	2026-04-17 02:43:08.498757+05
138	Migration20250113122235	2026-04-17 02:43:08.498757+05
139	Migration20250120115002	2026-04-17 02:43:08.498757+05
140	Migration20250822130931	2026-04-17 02:43:08.498757+05
141	Migration20250825132614	2026-04-17 02:43:08.498757+05
142	Migration20251114133146	2026-04-17 02:43:08.498757+05
143	Migration20240509083918_InitialSetupMigration	2026-04-17 02:43:08.858578+05
144	Migration20240628075401	2026-04-17 02:43:08.858578+05
145	Migration20240830094712	2026-04-17 02:43:08.858578+05
146	Migration20250120110514	2026-04-17 02:43:08.858578+05
147	Migration20251028172715	2026-04-17 02:43:08.858578+05
148	Migration20251121123942	2026-04-17 02:43:08.858578+05
149	Migration20251121150408	2026-04-17 02:43:08.858578+05
150	Migration20231228143900	2026-04-17 02:43:09.153185+05
151	Migration20241206101446	2026-04-17 02:43:09.153185+05
152	Migration20250128174331	2026-04-17 02:43:09.153185+05
153	Migration20250505092459	2026-04-17 02:43:09.153185+05
154	Migration20250819104213	2026-04-17 02:43:09.153185+05
155	Migration20250819110924	2026-04-17 02:43:09.153185+05
156	Migration20250908080305	2026-04-17 02:43:09.153185+05
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notification (id, "to", channel, template, data, trigger_type, resource_id, resource_type, receiver_id, original_notification_id, idempotency_key, external_id, provider_id, created_at, updated_at, deleted_at, status, "from", provider_data) FROM stdin;
\.


--
-- Data for Name: notification_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notification_provider (id, handle, name, is_enabled, channels, created_at, updated_at, deleted_at) FROM stdin;
local	local	local	t	{feed}	2026-04-17 02:43:12.009+05	2026-04-17 02:43:12.009+05	\N
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."order" (id, region_id, display_id, customer_id, version, sales_channel_id, status, is_draft_order, email, currency_code, shipping_address_id, billing_address_id, no_notification, metadata, created_at, updated_at, deleted_at, canceled_at, custom_display_id, locale) FROM stdin;
order_01KPT69A6SRHA530Y8QB7FX9PP	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	2	cus_01KPT69820YQ6YCJHC4SD5V9W7	2	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	pending	f	shaheryarahmed.awan@gmail.com	aed	ordaddr_01KPT69A6JCV0JSC5AFBQP49TQ	ordaddr_01KPT69A6J6A7QBGBJMV7FBBBV	f	\N	2026-04-22 13:53:08.958+05	2026-04-22 14:16:29.362+05	\N	\N	\N	\N
order_01KPDX1FW78K9YAEYX6CSWRKFB	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	1	cus_01KPDX1DTHCVZT4PAKC7NYXB40	3	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	pending	f	test@dentauae.com	aed	ordaddr_01KPDX1FVPMMGPE5BA5S9DC85Y	\N	f	\N	2026-04-17 19:20:42.259+05	2026-04-22 14:21:39.685+05	\N	\N	\N	\N
\.


--
-- Data for Name: order_address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_address (id, customer_id, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
ordaddr_01KPDX1FVPMMGPE5BA5S9DC85Y	\N	\N	Test	User	Al Barsha 1	\N	Dubai	ae	\N	\N	0501234567	\N	2026-04-17 19:20:40.157+05	2026-04-17 19:20:40.157+05	\N
ordaddr_01KPT69A6J6A7QBGBJMV7FBBBV	\N	\N	Sharyar 	Ahmed	House 12 	\N	Dubai	ae	Dubai	\N	+923342626544	\N	2026-04-22 13:53:06.787+05	2026-04-22 13:53:06.787+05	\N
ordaddr_01KPT69A6JCV0JSC5AFBQP49TQ	\N	\N	Sharyar 	Ahmed	House 12 	\N	Dubai	ae	Dubai	\N	+923342626544	\N	2026-04-22 13:53:06.787+05	2026-04-22 13:53:06.787+05	\N
\.


--
-- Data for Name: order_cart; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_cart (order_id, cart_id, id, created_at, updated_at, deleted_at) FROM stdin;
order_01KPDX1FW78K9YAEYX6CSWRKFB	cart_01KPDX1CXSX3V8FYD72HD2MX1N	ordercart_01KPDX1G4SFMPF4HDVKSM8FD3Q	2026-04-17 19:20:42.513578+05	2026-04-17 19:20:42.513578+05	\N
order_01KPT69A6SRHA530Y8QB7FX9PP	cart_01KPHB2M598PASVWWHE75YZMEJ	ordercart_01KPT69AB8NTY458KYBVPMJ0E1	2026-04-22 13:53:09.096348+05	2026-04-22 13:53:09.096348+05	\N
\.


--
-- Data for Name: order_change; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_change (id, order_id, version, description, status, internal_note, created_by, requested_by, requested_at, confirmed_by, confirmed_at, declined_by, declined_reason, metadata, declined_at, canceled_by, canceled_at, created_at, updated_at, change_type, deleted_at, return_id, claim_id, exchange_id, carry_over_promotions) FROM stdin;
ordch_01KPT7M1Q4H5D9HTPQ6J91S922	order_01KPT69A6SRHA530Y8QB7FX9PP	2	\N	confirmed	\N	\N	\N	\N	\N	2026-04-22 14:16:29.307+05	\N	\N	\N	\N	\N	\N	2026-04-22 14:16:29.285+05	2026-04-22 14:16:29.311+05	\N	\N	\N	\N	\N	\N
ordch_01KPT7W5P608F0JCR0B5BRDDXG	order_01KPDX1FW78K9YAEYX6CSWRKFB	2	\N	confirmed	\N	\N	\N	\N	\N	2026-04-22 14:20:55.525+05	\N	\N	\N	\N	\N	\N	2026-04-22 14:20:55.494+05	2026-04-22 14:20:55.532+05	\N	\N	\N	\N	\N	\N
ordch_01KPT7XGN9FYCYV2WVR2S7DDC9	order_01KPDX1FW78K9YAEYX6CSWRKFB	3	\N	confirmed	\N	user_01KPE8HZ9CRAXYVDM1KCXH81FA	\N	\N	\N	2026-04-22 14:21:39.556+05	\N	\N	\N	\N	\N	\N	2026-04-22 14:21:39.498+05	2026-04-22 14:21:39.569+05	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: order_change_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_change_action (id, order_id, version, ordering, order_change_id, reference, reference_id, action, details, amount, raw_amount, internal_note, applied, created_at, updated_at, deleted_at, return_id, claim_id, exchange_id) FROM stdin;
ordchact_01KPT7M1Q471YJDQZDK8HA8W94	order_01KPT69A6SRHA530Y8QB7FX9PP	2	1	ordch_01KPT7M1Q4H5D9HTPQ6J91S922	fulfillment	ful_01KPT7M1MAC2KPFRC11B15Q2MB	FULFILL_ITEM	{"quantity": 1, "reference_id": "ordli_01KPT69A6VRNH4RJF2QZQXS1HR"}	\N	\N	\N	t	2026-04-22 14:16:29.285+05	2026-04-22 14:16:29.363+05	\N	\N	\N	\N
ordchact_01KPT7W5P525V2SNTANZR1FVCD	order_01KPDX1FW78K9YAEYX6CSWRKFB	2	2	ordch_01KPT7W5P608F0JCR0B5BRDDXG	fulfillment	ful_01KPT7W5MD2FRXJWVVS1KXGQ2P	FULFILL_ITEM	{"quantity": 1, "reference_id": "ordli_01KPDX1FWC759XFJSST1FQEH7Z"}	\N	\N	\N	t	2026-04-22 14:20:55.495+05	2026-04-22 14:20:55.586+05	\N	\N	\N	\N
ordchact_01KPT7XGN8GZQTY9TWSNY772TC	order_01KPDX1FW78K9YAEYX6CSWRKFB	3	3	ordch_01KPT7XGN9FYCYV2WVR2S7DDC9	fulfillment	ful_01KPT7W5MD2FRXJWVVS1KXGQ2P	SHIP_ITEM	{"quantity": "1", "reference_id": "ordli_01KPDX1FWC759XFJSST1FQEH7Z"}	\N	\N	\N	t	2026-04-22 14:21:39.498+05	2026-04-22 14:21:39.686+05	\N	\N	\N	\N
\.


--
-- Data for Name: order_claim; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_claim (id, order_id, return_id, order_version, display_id, type, no_notification, refund_amount, raw_refund_amount, metadata, created_at, updated_at, deleted_at, canceled_at, created_by) FROM stdin;
\.


--
-- Data for Name: order_claim_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_claim_item (id, claim_id, item_id, is_additional_item, reason, quantity, raw_quantity, note, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_claim_item_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_claim_item_image (id, claim_item_id, url, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_credit_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_credit_line (id, order_id, reference, reference_id, amount, raw_amount, metadata, created_at, updated_at, deleted_at, version) FROM stdin;
\.


--
-- Data for Name: order_exchange; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_exchange (id, order_id, return_id, order_version, display_id, no_notification, allow_backorder, difference_due, raw_difference_due, metadata, created_at, updated_at, deleted_at, canceled_at, created_by) FROM stdin;
\.


--
-- Data for Name: order_exchange_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_exchange_item (id, exchange_id, item_id, quantity, raw_quantity, note, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_fulfillment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_fulfillment (order_id, fulfillment_id, id, created_at, updated_at, deleted_at) FROM stdin;
order_01KPT69A6SRHA530Y8QB7FX9PP	ful_01KPT7M1MAC2KPFRC11B15Q2MB	ordful_01KPT7M1PVTV7PZMTW6VYBRRYF	2026-04-22 14:16:29.270439+05	2026-04-22 14:16:29.270439+05	\N
order_01KPDX1FW78K9YAEYX6CSWRKFB	ful_01KPT7W5MD2FRXJWVVS1KXGQ2P	ordful_01KPT7W5NZRVH94225T1A7EP8J	2026-04-22 14:20:55.485264+05	2026-04-22 14:20:55.485264+05	\N
\.


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_item (id, order_id, version, item_id, quantity, raw_quantity, fulfilled_quantity, raw_fulfilled_quantity, shipped_quantity, raw_shipped_quantity, return_requested_quantity, raw_return_requested_quantity, return_received_quantity, raw_return_received_quantity, return_dismissed_quantity, raw_return_dismissed_quantity, written_off_quantity, raw_written_off_quantity, metadata, created_at, updated_at, deleted_at, delivered_quantity, raw_delivered_quantity, unit_price, raw_unit_price, compare_at_unit_price, raw_compare_at_unit_price) FROM stdin;
orditem_01KPDX1FWFFWKJ9QWWBE7N8231	order_01KPDX1FW78K9YAEYX6CSWRKFB	1	ordli_01KPDX1FWC759XFJSST1FQEH7Z	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-04-17 19:20:42.261+05	2026-04-17 19:20:42.261+05	\N	0	{"value": "0", "precision": 20}	\N	\N	\N	\N
orditem_01KPT69A6WNEK7N08KSC28ZTX5	order_01KPT69A6SRHA530Y8QB7FX9PP	1	ordli_01KPT69A6VRNH4RJF2QZQXS1HR	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-04-22 13:53:08.959+05	2026-04-22 13:53:08.959+05	\N	0	{"value": "0", "precision": 20}	\N	\N	\N	\N
orditem_01KPT7M1SBF01BV5M7FS5RGWB4	order_01KPT69A6SRHA530Y8QB7FX9PP	2	ordli_01KPT69A6VRNH4RJF2QZQXS1HR	1	{"value": "1", "precision": 20}	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-04-22 14:16:29.362+05	2026-04-22 14:16:29.362+05	\N	0	{"value": "0", "precision": 20}	358	{"value": "358", "precision": 20}	\N	\N
orditem_01KPT7W5RW1DYS3KSYGZNPVMWF	order_01KPDX1FW78K9YAEYX6CSWRKFB	2	ordli_01KPDX1FWC759XFJSST1FQEH7Z	1	{"value": "1", "precision": 20}	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-04-22 14:20:55.585+05	2026-04-22 14:20:55.585+05	\N	0	{"value": "0", "precision": 20}	899	{"value": "899", "precision": 20}	\N	\N
orditem_01KPT7XGTD7R7XX4SKR3Z54BNS	order_01KPDX1FW78K9YAEYX6CSWRKFB	3	ordli_01KPDX1FWC759XFJSST1FQEH7Z	1	{"value": "1", "precision": 20}	1	{"value": "1", "precision": 20}	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-04-22 14:21:39.683+05	2026-04-22 14:21:39.683+05	\N	0	{"value": "0", "precision": 20}	899	{"value": "899", "precision": 20}	\N	\N
\.


--
-- Data for Name: order_line_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_line_item (id, totals_id, title, subtitle, thumbnail, variant_id, product_id, product_title, product_description, product_subtitle, product_type, product_collection, product_handle, variant_sku, variant_barcode, variant_title, variant_option_values, requires_shipping, is_discountable, is_tax_inclusive, compare_at_unit_price, raw_compare_at_unit_price, unit_price, raw_unit_price, metadata, created_at, updated_at, deleted_at, is_custom_price, product_type_id, is_giftcard) FROM stdin;
ordli_01KPDX1FWC759XFJSST1FQEH7Z	\N	Oral-B iO Series 9	Rose Quartz	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	variant_01KPC3ZEA11CRT67TA4020FQ1Z	prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	\N	\N	\N	io-9	IO-9-PNK	\N	Rose Quartz	\N	t	t	f	\N	\N	899	{"value": "899", "precision": 20}	{}	2026-04-17 19:20:42.26+05	2026-04-17 19:20:42.26+05	\N	f	\N	f
ordli_01KPT69A6VRNH4RJF2QZQXS1HR	\N	Nikai 130L Gross / 90L Net, Single Door Mini Refrigerator, Chiller & Veg. Compartment, 2 Glass Shelves & Bottle Storage Racks, Compact Small Size Beverage Fridge, For Home, Office, Bedroom - NRF130SS1	Default	https://m.media-amazon.com/images/I/71Bu7r4vkWL.jpg	variant_01KPT5GB7B7C91YF1Z2MKGGAB1	prod_01KPT5GB487QQMWCYV852JCV72	Nikai 130L Gross / 90L Net, Single Door Mini Refrigerator, Chiller & Veg. Compartment, 2 Glass Shelves & Bottle Storage Racks, Compact Small Size Beverage Fridge, For Home, Office, Bedroom - NRF130SS1	𝐄𝐧𝐯𝐢𝐫𝐨𝐧𝐦𝐞𝐧𝐭-𝐟𝐫𝐢𝐞𝐧𝐝𝐥𝐲 𝐑𝐞𝐟𝐫𝐢𝐠𝐞𝐫𝐚𝐧𝐭 : This NIKAI Ref NRF130 uses R600a for cooling, owing to its superior thermodynamic performance and low environmental impact. This Refrigerator is also free of chlorofluorocarbons (CFC) which can cause harm to the environment.\n𝐒𝐮𝐩𝐞𝐫 𝐒𝐢𝐥𝐞𝐧𝐭 & 𝐄𝐧𝐞𝐫𝐠𝐲 𝐄𝐟𝐟𝐢𝐜𝐢𝐞𝐧𝐭 𝐂𝐨𝐦𝐩𝐫𝐞𝐬𝐬𝐨𝐫 : A silent/quiet compressor is designed especially; for quiet operation and is fully automated and virtually noiseless. This compressor combines machine reliability, additional noise insulation, and efficient lubrication to absorb most noise produced to live comfortably in the surroundings.\n𝐓𝐞𝐦𝐩𝐞𝐫𝐚𝐭𝐮𝐫𝐞 𝐂𝐨𝐧𝐭𝐫𝐨𝐥 & 𝐈𝐧𝐭𝐞𝐫𝐢𝐨𝐫 𝐋𝐢𝐠𝐡𝐭 : Temperature Control: Adjust the knob from 1 to max to control the refrigerator temperature. A medium setting is the most recommended setting for general operation. Set the thermostat in max position only when ice cubes or frozen food is in the freezing compartment.\n𝐃𝐞𝐟𝐫𝐨𝐬𝐭𝐢𝐧𝐠 : Defrost the freezing compartment whenever the ice layer reaches 3-4mm on the evaporator. During the defrosting method, remove all foods and ice cubes trays. Then, Place the drip tray to collect melted water to start defrosting, set the thermostat at 0 positions, and do not forget to keep the door open.\n𝐆𝐫𝐨𝐬𝐬 & 𝐍𝐞𝐭 𝐂𝐚𝐩𝐚𝐜𝐢𝐭𝐲 : The Gross Capacity of Nikai - NRF130SS1 is 125Ltr & the net capacity of this mini refrigerator is 90Ltr. It is a perfect fit for small Kitchens, Bedrooms, Student dormitories, Offices, Hotel rooms. It is suitable for refrigerating foods like fruits, vegetables, Chocolates and Beverages.\n𝐂𝐡𝐢𝐥𝐝 𝐋𝐨𝐜𝐤 & 𝐊𝐞𝐲 𝐅𝐮𝐧𝐜𝐭𝐢𝐨𝐧 : To secure your kids when you are not around, Nikai Refrigerator comes with a lock & key feature for security	Imported from Amazon	\N	\N	amz-b07n156drr	AMZ-B07N156DRR	\N	Default	\N	f	t	f	\N	\N	358	{"value": "358", "precision": 20}	{}	2026-04-22 13:53:08.958+05	2026-04-22 13:53:08.958+05	\N	f	\N	f
\.


--
-- Data for Name: order_line_item_adjustment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_line_item_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, created_at, updated_at, item_id, deleted_at, is_tax_inclusive, version) FROM stdin;
\.


--
-- Data for Name: order_line_item_tax_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_line_item_tax_line (id, description, tax_rate_id, code, rate, raw_rate, provider_id, created_at, updated_at, item_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_payment_collection; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_payment_collection (order_id, payment_collection_id, id, created_at, updated_at, deleted_at) FROM stdin;
order_01KPDX1FW78K9YAEYX6CSWRKFB	pay_col_01KPDX1FN3RNDADM6MRRFG1THW	ordpay_01KPDX1G53KHSNTBJ4ST6KWG3C	2026-04-17 19:20:42.513717+05	2026-04-17 19:20:42.513717+05	\N
order_01KPT69A6SRHA530Y8QB7FX9PP	pay_col_01KPT699TFTPN0WCK3SXGBNAMB	ordpay_01KPT69ABCZ8E7BGEA88XEKDVC	2026-04-22 13:53:09.096183+05	2026-04-22 13:53:09.096183+05	\N
\.


--
-- Data for Name: order_promotion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_promotion (order_id, promotion_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_shipping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_shipping (id, order_id, version, shipping_method_id, created_at, updated_at, deleted_at, return_id, claim_id, exchange_id) FROM stdin;
ordspmv_01KPDX1FW6H01ZNFEQDRANJ26W	order_01KPDX1FW78K9YAEYX6CSWRKFB	1	ordsm_01KPDX1FW65KXR6DMDQ3EK1Q0R	2026-04-17 19:20:42.263+05	2026-04-17 19:20:42.263+05	\N	\N	\N	\N
ordspmv_01KPT69A6SVBVN5SAX0B080RQD	order_01KPT69A6SRHA530Y8QB7FX9PP	1	ordsm_01KPT69A6R101W12R4CTV86YTE	2026-04-22 13:53:08.96+05	2026-04-22 13:53:08.96+05	\N	\N	\N	\N
ordspmv_01KPT7M1SBC7E5V0HE4SQ8G543	order_01KPT69A6SRHA530Y8QB7FX9PP	2	ordsm_01KPT69A6R101W12R4CTV86YTE	2026-04-22 13:53:08.96+05	2026-04-22 13:53:08.96+05	\N	\N	\N	\N
ordspmv_01KPT7W5RWGZ5QBQHDV2MCCX7J	order_01KPDX1FW78K9YAEYX6CSWRKFB	2	ordsm_01KPDX1FW65KXR6DMDQ3EK1Q0R	2026-04-17 19:20:42.263+05	2026-04-17 19:20:42.263+05	\N	\N	\N	\N
ordspmv_01KPT7XGTGV4C6VZGR4HRWT7KQ	order_01KPDX1FW78K9YAEYX6CSWRKFB	3	ordsm_01KPDX1FW65KXR6DMDQ3EK1Q0R	2026-04-17 19:20:42.263+05	2026-04-17 19:20:42.263+05	\N	\N	\N	\N
\.


--
-- Data for Name: order_shipping_method; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_shipping_method (id, name, description, amount, raw_amount, is_tax_inclusive, shipping_option_id, data, metadata, created_at, updated_at, deleted_at, is_custom_amount) FROM stdin;
ordsm_01KPDX1FW65KXR6DMDQ3EK1Q0R	Standard Shipping	\N	20	{"value": "20", "precision": 20}	f	so_01KPC3ZE792AK7TCQSYKEQ2G5S	{}	\N	2026-04-17 19:20:42.263+05	2026-04-17 19:20:42.263+05	\N	f
ordsm_01KPT69A6R101W12R4CTV86YTE	Standard Shipping	\N	20	{"value": "20", "precision": 20}	f	so_01KPC3ZE792AK7TCQSYKEQ2G5S	{}	\N	2026-04-22 13:53:08.959+05	2026-04-22 13:53:08.959+05	\N	f
\.


--
-- Data for Name: order_shipping_method_adjustment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_shipping_method_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, created_at, updated_at, shipping_method_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_shipping_method_tax_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_shipping_method_tax_line (id, description, tax_rate_id, code, rate, raw_rate, provider_id, created_at, updated_at, shipping_method_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_summary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_summary (id, order_id, version, totals, created_at, updated_at, deleted_at) FROM stdin;
ordsum_01KPDX1FW4JHWFWAV12YQMDQKR	order_01KPDX1FW78K9YAEYX6CSWRKFB	1	{"paid_total": 0, "raw_paid_total": {"value": "0", "precision": 20}, "refunded_total": 0, "accounting_total": 919, "credit_line_total": 0, "transaction_total": 0, "pending_difference": 919, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 919, "original_order_total": 919, "raw_accounting_total": {"value": "919", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "0", "precision": 20}, "raw_pending_difference": {"value": "919", "precision": 20}, "raw_current_order_total": {"value": "919", "precision": 20}, "raw_original_order_total": {"value": "919", "precision": 20}}	2026-04-17 19:20:42.262+05	2026-04-17 19:20:42.262+05	\N
ordsum_01KPT69A6QBHXHW64REXHK7C6E	order_01KPT69A6SRHA530Y8QB7FX9PP	1	{"paid_total": 378, "raw_paid_total": {"value": "378", "precision": 20}, "refunded_total": 0, "accounting_total": 378, "credit_line_total": 0, "transaction_total": 378, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 378, "original_order_total": 378, "raw_accounting_total": {"value": "378", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "378", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "378", "precision": 20}, "raw_original_order_total": {"value": "378", "precision": 20}}	2026-04-22 13:53:08.959+05	2026-04-22 13:53:53.209+05	\N
ordsum_01KPT7M1SB3F9G4M132Y9NPBAA	order_01KPT69A6SRHA530Y8QB7FX9PP	2	{"paid_total": 378, "raw_paid_total": {"value": "378", "precision": 20}, "refunded_total": 0, "accounting_total": 378, "credit_line_total": 0, "transaction_total": 378, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 378, "original_order_total": 378, "raw_accounting_total": {"value": "378", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "378", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "378", "precision": 20}, "raw_original_order_total": {"value": "378", "precision": 20}}	2026-04-22 14:16:29.362+05	2026-04-22 14:16:29.362+05	\N
ordsum_01KPT7W5RWRVZVYW5V1FFNVS4N	order_01KPDX1FW78K9YAEYX6CSWRKFB	2	{"paid_total": 0, "raw_paid_total": {"value": "0", "precision": 20}, "refunded_total": 0, "accounting_total": 919, "credit_line_total": 0, "transaction_total": 0, "pending_difference": 919, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 919, "original_order_total": 919, "raw_accounting_total": {"value": "919", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "0", "precision": 20}, "raw_pending_difference": {"value": "919", "precision": 20}, "raw_current_order_total": {"value": "919", "precision": 20}, "raw_original_order_total": {"value": "919", "precision": 20}}	2026-04-22 14:20:55.585+05	2026-04-22 14:20:55.585+05	\N
ordsum_01KPT7XGTFJGCP9EFB1M09BBHP	order_01KPDX1FW78K9YAEYX6CSWRKFB	3	{"paid_total": 0, "raw_paid_total": {"value": "0", "precision": 20}, "refunded_total": 0, "accounting_total": 919, "credit_line_total": 0, "transaction_total": 0, "pending_difference": 919, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 919, "original_order_total": 919, "raw_accounting_total": {"value": "919", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "0", "precision": 20}, "raw_pending_difference": {"value": "919", "precision": 20}, "raw_current_order_total": {"value": "919", "precision": 20}, "raw_original_order_total": {"value": "919", "precision": 20}}	2026-04-22 14:21:39.684+05	2026-04-22 14:21:39.684+05	\N
\.


--
-- Data for Name: order_transaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_transaction (id, order_id, version, amount, raw_amount, currency_code, reference, reference_id, created_at, updated_at, deleted_at, return_id, claim_id, exchange_id) FROM stdin;
ordtrx_01KPT6ANDFBVQAZX327G7TF4J6	order_01KPT69A6SRHA530Y8QB7FX9PP	1	378	{"value": "378", "precision": 20}	aed	capture	capt_01KPT6ANBB3865FDD4YCEZX2ER	2026-04-22 13:53:53.209+05	2026-04-22 13:53:53.209+05	\N	\N	\N	\N
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment (id, amount, raw_amount, currency_code, provider_id, data, created_at, updated_at, deleted_at, captured_at, canceled_at, payment_collection_id, payment_session_id, metadata) FROM stdin;
pay_01KPDX1G6YXWB9V54PNY1JZK5E	919	{"value": "919", "precision": 20}	aed	pp_system_default	{}	2026-04-17 19:20:42.592+05	2026-04-17 19:20:42.592+05	\N	\N	\N	pay_col_01KPDX1FN3RNDADM6MRRFG1THW	payses_01KPDX1FP8TR1EAR2HB4RYHWMB	\N
pay_01KPT69AF8JY8AA7CR48HS784W	378	{"value": "378", "precision": 20}	aed	pp_system_default	{}	2026-04-22 13:53:09.225+05	2026-04-22 13:53:53.149+05	\N	2026-04-22 13:53:53.143+05	\N	pay_col_01KPT699TFTPN0WCK3SXGBNAMB	payses_01KPT699Z2BM15TNQPBSZ5NNZ8	\N
\.


--
-- Data for Name: payment_collection; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_collection (id, currency_code, amount, raw_amount, authorized_amount, raw_authorized_amount, captured_amount, raw_captured_amount, refunded_amount, raw_refunded_amount, created_at, updated_at, deleted_at, completed_at, status, metadata) FROM stdin;
pay_col_01KPDX1FN3RNDADM6MRRFG1THW	aed	919	{"value": "919", "precision": 20}	919	{"value": "919", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	2026-04-17 19:20:42.019+05	2026-04-17 19:20:42.654+05	\N	\N	authorized	\N
pay_col_01KPT699TFTPN0WCK3SXGBNAMB	aed	378	{"value": "378", "precision": 20}	378	{"value": "378", "precision": 20}	378	{"value": "378", "precision": 20}	0	{"value": "0", "precision": 20}	2026-04-22 13:53:08.56+05	2026-04-22 13:53:53.171+05	\N	2026-04-22 13:53:53.166+05	completed	\N
pay_col_01KPHBERPAZE115RV7E3RVGYVC	aed	2246	{"value": "2246", "precision": 20}	\N	\N	\N	\N	\N	\N	2026-04-19 03:30:20.618+05	2026-04-22 16:08:04.113+05	\N	\N	not_paid	\N
\.


--
-- Data for Name: payment_collection_payment_providers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_collection_payment_providers (payment_collection_id, payment_provider_id) FROM stdin;
\.


--
-- Data for Name: payment_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_provider (id, is_enabled, created_at, updated_at, deleted_at) FROM stdin;
pp_system_default	t	2026-04-17 02:43:12.006+05	2026-04-17 02:43:12.006+05	\N
pp_stripe-oxxo_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
pp_stripe-promptpay_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
pp_stripe-przelewy24_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
pp_stripe_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
pp_stripe-ideal_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
pp_stripe-giropay_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
pp_stripe-blik_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
pp_stripe-bancontact_stripe	t	2026-04-19 03:17:11.247+05	2026-04-19 03:17:11.247+05	\N
\.


--
-- Data for Name: payment_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_session (id, currency_code, amount, raw_amount, provider_id, data, context, status, authorized_at, payment_collection_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
payses_01KPDX1FP8TR1EAR2HB4RYHWMB	aed	919	{"value": "919", "precision": 20}	pp_system_default	{}	{}	authorized	2026-04-17 19:20:42.582+05	pay_col_01KPDX1FN3RNDADM6MRRFG1THW	{}	2026-04-17 19:20:42.056+05	2026-04-17 19:20:42.594+05	\N
payses_01KPT699Z2BM15TNQPBSZ5NNZ8	aed	378	{"value": "378", "precision": 20}	pp_system_default	{}	{}	authorized	2026-04-22 13:53:09.216+05	pay_col_01KPT699TFTPN0WCK3SXGBNAMB	{}	2026-04-22 13:53:08.706+05	2026-04-22 13:53:09.225+05	\N
\.


--
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price (id, title, price_set_id, currency_code, raw_amount, rules_count, created_at, updated_at, deleted_at, price_list_id, amount, min_quantity, max_quantity, raw_min_quantity, raw_max_quantity) FROM stdin;
price_01KPC3ZE7MHA5WAJ2RD448W3WG	\N	pset_01KPC3ZE7MZJ1CDEQY1CTHQH0Y	aed	{"value": "0", "precision": 20}	0	2026-04-17 02:43:26.197+05	2026-04-17 02:43:26.197+05	\N	\N	0	\N	\N	\N	\N
price_01KPC3ZE7MD73WXRMJMBAHH77Z	\N	pset_01KPC3ZE7MZJ1CDEQY1CTHQH0Y	aed	{"value": "0", "precision": 20}	1	2026-04-17 02:43:26.197+05	2026-04-17 02:43:26.197+05	\N	\N	0	\N	\N	\N	\N
price_01KPC3ZEANCFEAEZND2Y7KSJAT	\N	pset_01KPC3ZEANZ3H2476H3NV93CVT	aed	{"value": "899", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	899	\N	\N	\N	\N
price_01KPC3ZEANYFB62A2CG5R21XDG	\N	pset_01KPC3ZEANZ3H2476H3NV93CVT	usd	{"value": "245", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	245	\N	\N	\N	\N
price_01KPC3ZEAN4JT94QEZMYD2BBW3	\N	pset_01KPC3ZEANY4MMJY3V832XR46W	aed	{"value": "899", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	899	\N	\N	\N	\N
price_01KPC3ZEANE2FRBQ6WYDZA8KNE	\N	pset_01KPC3ZEANY4MMJY3V832XR46W	usd	{"value": "245", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	245	\N	\N	\N	\N
price_01KPC3ZEANC12NHB6Z8GTV63SN	\N	pset_01KPC3ZEAPJ3XNA97TKPKCMYZK	aed	{"value": "899", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	899	\N	\N	\N	\N
price_01KPC3ZEAP4FMHZKAWARMNFVPK	\N	pset_01KPC3ZEAPJ3XNA97TKPKCMYZK	usd	{"value": "245", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	245	\N	\N	\N	\N
price_01KPC3ZEAPF06BBGKYRBC2KR2V	\N	pset_01KPC3ZEAP82E39PR5QVZSM915	aed	{"value": "649", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	649	\N	\N	\N	\N
price_01KPC3ZEAP8XJ25TA8YZN5R02D	\N	pset_01KPC3ZEAP82E39PR5QVZSM915	usd	{"value": "175", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	175	\N	\N	\N	\N
price_01KPC3ZEAPE43SN8TWVWFF6Z6P	\N	pset_01KPC3ZEAP02R5QQSA4AEH6CD0	aed	{"value": "185", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	185	\N	\N	\N	\N
price_01KPC3ZEAP889HP2KVN2W6V4XE	\N	pset_01KPC3ZEAP02R5QQSA4AEH6CD0	usd	{"value": "50", "precision": 20}	0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N	\N	50	\N	\N	\N	\N
price_01KPT27Q4QB8W0N7VD6SFMKBPR	\N	pset_01KPT27Q4Q7C9DZ2NJXMMDTKQF	aed	{"value": "1349", "precision": 20}	0	2026-04-22 12:42:22.359+05	2026-04-22 12:42:22.359+05	\N	\N	1349	\N	\N	\N	\N
price_01KPT44AD9PG6V413YRVTWXXQ5	\N	pset_01KPT44ADA3PTTQDBJ4HY6KHP4	aed	{"value": "144", "precision": 20}	0	2026-04-22 13:15:28.17+05	2026-04-22 13:15:28.17+05	\N	\N	144	\N	\N	\N	\N
price_01KPT4CS137492WVWGM8J410HN	\N	pset_01KPT4CS13TXGP73WTW09AA6Q4	aed	{"value": "169", "precision": 20}	0	2026-04-22 13:20:05.283+05	2026-04-22 13:20:05.283+05	\N	\N	169	\N	\N	\N	\N
price_01KPT58G4BEJ6YVM1BJHP58DPF	\N	pset_01KPT58G4C1XYRSCJEXGKP2SNP	aed	{"value": "969", "precision": 20}	0	2026-04-22 13:35:13.676+05	2026-04-22 13:35:13.676+05	\N	\N	969	\N	\N	\N	\N
price_01KPT5ERVS014X8ACYW4SHHT11	\N	pset_01KPT5ERVS4304YYG4MAX07TM0	aed	{"value": "53", "precision": 20}	0	2026-04-22 13:38:39.225+05	2026-04-22 13:38:39.225+05	\N	\N	53	\N	\N	\N	\N
price_01KPT5GB8NSBQBQZTE2D5E31GY	\N	pset_01KPT5GB8NEZVQ9VGMB6PRQFH2	aed	{"value": "358", "precision": 20}	0	2026-04-22 13:39:30.837+05	2026-04-22 13:39:30.837+05	\N	\N	358	\N	\N	\N	\N
price_01KPTEEHSG6AY11B95FP2Y3P91	\N	pset_01KPTEEHSG6ZBH5HHF634SVKNR	aed	{"value": "279", "precision": 20}	0	2026-04-22 16:15:49.168+05	2026-04-22 16:15:49.168+05	\N	\N	279	\N	\N	\N	\N
price_01KPTFNDBA2MQKW9BVJR8PYCTH	\N	pset_01KPTFNDBBB16DEP07Z903S9RK	aed	{"value": "349", "precision": 20}	0	2026-04-22 16:37:02.574+05	2026-04-22 16:37:02.574+05	\N	\N	349	\N	\N	\N	\N
price_01KPTGE1WPAK0VA5WRH5D9FF6W	\N	pset_01KPC3ZE7M7VXREN0JKVEW8KWW	aed	{"value": "50", "precision": 20}	1	2026-04-22 16:50:30.043+05	2026-04-22 16:50:30.043+05	\N	\N	50	\N	\N	\N	\N
price_01KPC3ZE7MZD6QYR8AA58SR7ZA	\N	pset_01KPC3ZE7M7VXREN0JKVEW8KWW	aed	{"value": "15", "precision": 20}	0	2026-04-17 02:43:26.197+05	2026-04-22 16:50:30.122+05	\N	\N	15	\N	\N	\N	\N
price_01KPC3ZE7KAAQAJW2TQRKKGVXN	\N	pset_01KPC3ZE7MWKSGTC852HF7ECK6	aed	{"value": "5", "precision": 20}	0	2026-04-17 02:43:26.196+05	2026-04-22 16:50:49.809+05	\N	\N	5	\N	\N	\N	\N
price_01KPTGF0MKYEFKWF4EASTDJANT	\N	pset_01KPC3ZE7MWKSGTC852HF7ECK6	aed	{"value": "5", "precision": 20}	1	2026-04-22 16:51:01.524+05	2026-04-22 16:51:01.524+05	\N	\N	5	\N	\N	\N	\N
\.


--
-- Data for Name: price_list; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price_list (id, status, starts_at, ends_at, rules_count, title, description, type, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: price_list_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price_list_rule (id, price_list_id, created_at, updated_at, deleted_at, value, attribute) FROM stdin;
\.


--
-- Data for Name: price_preference; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price_preference (id, attribute, value, is_tax_inclusive, created_at, updated_at, deleted_at) FROM stdin;
prpref_01KPC3ZE41TP1SHJP48SF2AAH0	currency_code	eur	f	2026-04-17 02:43:26.081+05	2026-04-17 02:43:26.081+05	\N
prpref_01KPC3ZE5M0KW946JTP4Q5T4RQ	region_id	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	f	2026-04-17 02:43:26.132+05	2026-04-17 02:43:26.132+05	\N
\.


--
-- Data for Name: price_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price_rule (id, value, priority, price_id, created_at, updated_at, deleted_at, attribute, operator) FROM stdin;
prule_01KPC3ZE7M96TEY79NP0GRE0A9	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	0	price_01KPC3ZE7MD73WXRMJMBAHH77Z	2026-04-17 02:43:26.197+05	2026-04-17 02:43:26.197+05	\N	region_id	eq
prule_01KPTGE1WNZC3MHJ53DJR2V31H	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	0	price_01KPTGE1WPAK0VA5WRH5D9FF6W	2026-04-22 16:50:30.044+05	2026-04-22 16:50:30.044+05	\N	region_id	eq
prule_01KPTGF0MKF0Q9BC3JKN4S273Y	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	0	price_01KPTGF0MKYEFKWF4EASTDJANT	2026-04-22 16:51:01.524+05	2026-04-22 16:51:01.524+05	\N	region_id	eq
\.


--
-- Data for Name: price_set; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price_set (id, created_at, updated_at, deleted_at) FROM stdin;
pset_01KPC3ZE7MWKSGTC852HF7ECK6	2026-04-17 02:43:26.196+05	2026-04-17 02:43:26.196+05	\N
pset_01KPC3ZE7M7VXREN0JKVEW8KWW	2026-04-17 02:43:26.196+05	2026-04-17 02:43:26.196+05	\N
pset_01KPC3ZE7MZJ1CDEQY1CTHQH0Y	2026-04-17 02:43:26.196+05	2026-04-17 02:43:26.196+05	\N
pset_01KPC3ZEANZ3H2476H3NV93CVT	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N
pset_01KPC3ZEANY4MMJY3V832XR46W	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N
pset_01KPC3ZEAPJ3XNA97TKPKCMYZK	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N
pset_01KPC3ZEAP82E39PR5QVZSM915	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N
pset_01KPC3ZEAP02R5QQSA4AEH6CD0	2026-04-17 02:43:26.294+05	2026-04-17 02:43:26.294+05	\N
pset_01KPT27Q4Q7C9DZ2NJXMMDTKQF	2026-04-22 12:42:22.359+05	2026-04-22 12:42:22.359+05	\N
pset_01KPT44ADA3PTTQDBJ4HY6KHP4	2026-04-22 13:15:28.17+05	2026-04-22 13:15:28.17+05	\N
pset_01KPT4CS13TXGP73WTW09AA6Q4	2026-04-22 13:20:05.283+05	2026-04-22 13:20:05.283+05	\N
pset_01KPT58G4C1XYRSCJEXGKP2SNP	2026-04-22 13:35:13.676+05	2026-04-22 13:35:13.676+05	\N
pset_01KPT5ERVS4304YYG4MAX07TM0	2026-04-22 13:38:39.225+05	2026-04-22 13:38:39.225+05	\N
pset_01KPT5GB8NEZVQ9VGMB6PRQFH2	2026-04-22 13:39:30.837+05	2026-04-22 13:39:30.837+05	\N
pset_01KPTEEHSG6ZBH5HHF634SVKNR	2026-04-22 16:15:49.168+05	2026-04-22 16:15:49.168+05	\N
pset_01KPTFNDBBB16DEP07Z903S9RK	2026-04-22 16:37:02.572+05	2026-04-22 16:37:02.572+05	\N
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product (id, title, handle, subtitle, description, is_giftcard, status, thumbnail, weight, length, height, width, origin_country, hs_code, mid_code, material, collection_id, type_id, discountable, external_id, created_at, updated_at, deleted_at, metadata) FROM stdin;
prod_01KPC3ZE917A0KGB12XG5Z6TQG	Oral-B iO Series 9	io-9	\N	The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.	f	published	https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD	400	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N	\N
prod_01KPC3ZE91W4Y0QDGKEJJYACZG	iO Series 7 White	io-7	\N	Advanced clean with interactive display. Features 5 Smart Modes and a Pressure Sensor.	f	published	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	350	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N	\N
prod_01KPC3ZE91QKARBVHWZWTMHG6R	iO Gentle Care Heads (4ct)	io-heads	\N	Gentle cleaning for sensitive gums. Compatible with all iO handles.	f	published	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	100	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N	\N
prod_01KPT27Q338HRS1NZ5HMZ9P44B	Sonicare Prestige 9900	sonicare-9900	Philips Sonicare	Our most advanced electric toothbrush yet. Senses your brushing style and adapts in real-time.	f	published	https://lh3.googleusercontent.com/aida/ADBb0ujhg6XcViiOJWfNFXFt5ZK8drfuYHWrTxxr8mmggNIPI09rya-gnHhaQGz_-K0IZ4pp6wb84V_NBcIh2g96fHzroIXWd3xCNhmD4kv9jU3eCJEwfFIFG1V0LCqlb5l3kDNK7PKdVpMcjW_Vvxe58gDmjrcp_gzbyCqN6J44VuumTRu1G041LBfWx30Sk3Za6K_-MGX5tvsYkcHzASBO6dVzE_aSLE_Plw2OQPq1NfyNLzGmITJhZl25H19G	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-22 12:42:22.309+05	2026-04-22 12:42:22.309+05	\N	\N
prod_01KPT44AA6GHYWKNFYBVMHG852	Oral B Vitality 300 Rechargeable Toothbrush with CrossAction Brush Head, 3 Cleaning Modes & 2 Minutes Built-in Timer D103.413.3 Black	amz-b0cfyc38yk	Imported from Amazon	3 CLEANING MODES:Daily clean, sensitive, sensitive plus\n2 MINUTES TIMER: Rechargeable Toothbrush with Waterproof Handle\nBRUSH HEAD & COMPATIBILITY: Comes with CrossAction brush head and the Handle compatible with these Oral B brush heads: EB 20, EB 25, EB 18, EB 60, EB 50\nMOST USED BRAND WORLDWIDE: Brand preferred by dentists globally German technology, Made in Hungary\nENHANCED PLAQUE REMOVAL: Removes up to 100% more plaque vs manual toothbrush, Protects gums	f	published	https://m.media-amazon.com/images/I/718Ip2hbsXL._AC_SY355_.jpg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-22 13:15:28.074+05	2026-04-22 13:15:28.074+05	\N	\N
prod_01KPT4CRZN34GMYQJPRHY1J7CT	Oral-B Vitality D100 Black and White 1+1 Free Bundle Electric Rechargeable Toothbrush, 2 Minutes Timer, Cross Action Brush Head, with UAE 3 pin plug	amz-b0cgj5w2sx	Imported from Amazon	VITALITY D100 MODERN DESIGN: Elegant, ergonomic design adds a touch of modernity to your oral care routine\nEXTENDED BATTERY LIFE: Enjoy 8 days of usage on a single charge, surpassing the 5 day standard\nQUADRANT TIMER FUNCTIONALITY: Efficiently brush each quadrant with the 30-second interval timer\nCONVENIENT CHARGING STATION: Rechargeable toothbrush comes with a practical charging station for easy power replenishment\nCROSS ACTION BRUSH HEAD: Equipped with a Cross Action brush head for thorough and effective cleaning\nDENTIST-RECOMMENDED BRAND: Being the brand recommended by dentists worldwide, trust in your oral care is assured	f	published	https://m.media-amazon.com/images/I/71CdAA9Fc4L._AC_SY355_.jpg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-22 13:20:05.238+05	2026-04-22 13:20:05.238+05	\N	\N
prod_01KPT58FZ1W2CEPTR24NG0MPMX	Oral-B iO9 Electric Rechargeable Toothbrush, 1 Black handle with revolutionary magnetic technology, Color Display, 7 Modes, 1 Premium Travel Case (UAE)	amz-b09h7ltx4c	Imported from Amazon	Oral-B’s BEST EVER CLEAN with REVOLUTIONARY MAGNETIC iO TECHNOLOGY for a professional clean feeling & gentle brushing experience\n3D Teeth Tracking with A.I to monitor your brushing across the front, top and back surfaces of your teeth; guiding you to the most thorough possible clean\n7 SMART MODES to personalise your brushing: Daily Clean, Sensitive, Gum Care, Intense Clean, Whitening, Tongue Cleaner, Super Sensitive\nCombines the unique round brush head from Oral-B with gentle micro-vibrations for 100% healthier gums in one week\nINTERACTIVE COLOR DISPLAY signals vital information: Including brushing modes and head replacement reminder, greets you as you power up and gives you a smile for a job well done	f	published	https://m.media-amazon.com/images/I/81U92kMFQRL.jpg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-22 13:35:13.513+05	2026-04-22 13:35:13.513+05	\N	\N
prod_01KPT5ERQ0G3S23FS9FC1S2NX4	Oral-B EB 25-2 Floss Action Replacement Brush Head, Pack of 2	amz-b003u9v7pa	Imported from Amazon	2-pack of Floss Action replacement toothbrush heads with micro-pulse bristles that penetrate deep between teeth for a floss-like clean and maximum freshness\nRemove twice as much plaque as an ordinary manual toothbrush\nWith dentist recommended oscillate and rotate technology for maximum cleaning\nDentists recommend changing your brush head every 3 months to keep that dentist feeling of clean\nBrush heads are interchangeable with all Oral-B handles (excluding Pulsonic/Sonic)	f	published	https://m.media-amazon.com/images/I/612EPqaPzwL.jpg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N	\N
prod_01KPT5GB487QQMWCYV852JCV72	Nikai 130L Gross / 90L Net, Single Door Mini Refrigerator, Chiller & Veg. Compartment, 2 Glass Shelves & Bottle Storage Racks, Compact Small Size Beverage Fridge, For Home, Office, Bedroom - NRF130SS1	amz-b07n156drr	Imported from Amazon	𝐄𝐧𝐯𝐢𝐫𝐨𝐧𝐦𝐞𝐧𝐭-𝐟𝐫𝐢𝐞𝐧𝐝𝐥𝐲 𝐑𝐞𝐟𝐫𝐢𝐠𝐞𝐫𝐚𝐧𝐭 : This NIKAI Ref NRF130 uses R600a for cooling, owing to its superior thermodynamic performance and low environmental impact. This Refrigerator is also free of chlorofluorocarbons (CFC) which can cause harm to the environment.\n𝐒𝐮𝐩𝐞𝐫 𝐒𝐢𝐥𝐞𝐧𝐭 & 𝐄𝐧𝐞𝐫𝐠𝐲 𝐄𝐟𝐟𝐢𝐜𝐢𝐞𝐧𝐭 𝐂𝐨𝐦𝐩𝐫𝐞𝐬𝐬𝐨𝐫 : A silent/quiet compressor is designed especially; for quiet operation and is fully automated and virtually noiseless. This compressor combines machine reliability, additional noise insulation, and efficient lubrication to absorb most noise produced to live comfortably in the surroundings.\n𝐓𝐞𝐦𝐩𝐞𝐫𝐚𝐭𝐮𝐫𝐞 𝐂𝐨𝐧𝐭𝐫𝐨𝐥 & 𝐈𝐧𝐭𝐞𝐫𝐢𝐨𝐫 𝐋𝐢𝐠𝐡𝐭 : Temperature Control: Adjust the knob from 1 to max to control the refrigerator temperature. A medium setting is the most recommended setting for general operation. Set the thermostat in max position only when ice cubes or frozen food is in the freezing compartment.\n𝐃𝐞𝐟𝐫𝐨𝐬𝐭𝐢𝐧𝐠 : Defrost the freezing compartment whenever the ice layer reaches 3-4mm on the evaporator. During the defrosting method, remove all foods and ice cubes trays. Then, Place the drip tray to collect melted water to start defrosting, set the thermostat at 0 positions, and do not forget to keep the door open.\n𝐆𝐫𝐨𝐬𝐬 & 𝐍𝐞𝐭 𝐂𝐚𝐩𝐚𝐜𝐢𝐭𝐲 : The Gross Capacity of Nikai - NRF130SS1 is 125Ltr & the net capacity of this mini refrigerator is 90Ltr. It is a perfect fit for small Kitchens, Bedrooms, Student dormitories, Offices, Hotel rooms. It is suitable for refrigerating foods like fruits, vegetables, Chocolates and Beverages.\n𝐂𝐡𝐢𝐥𝐝 𝐋𝐨𝐜𝐤 & 𝐊𝐞𝐲 𝐅𝐮𝐧𝐜𝐭𝐢𝐨𝐧 : To secure your kids when you are not around, Nikai Refrigerator comes with a lock & key feature for security	f	published	https://m.media-amazon.com/images/I/71Bu7r4vkWL.jpg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-22 13:39:30.699+05	2026-04-22 13:39:30.699+05	\N	\N
prod_01KPTEEHQ69G0EP1YYS8GCDMM1	Oral B iO2 Series 2 Rechargeable Electric Toothbrush, 3 Smart Modes, iO Technology, Pressure Sensor, Adaptive Micro Pulsations, With Travel Case - IOS2.IC9.1K - Pink	amz-b0flwkl7j5	Imported from Amazon	ADAPTIVE MICROPULSATIONS: Bristles adapt to the contours of each tooth for deeper reach and superior cleaning (vs. a manual toothbrush).\nSMART PRESSURE SENSOR: Displays red light when brushing too hard and green when pressure is optimal, protecting gums.\n3 SMART MODES: Choose from Daily Clean, Whitening, and Sensitive modes for a personalized brushing experience.\niO BRUSH HEAD WITH SOFT BRISTLES: 4,000 densely packed soft bristles designed to clean sensitive teeth and gums effectively.\nGUM PROTECTION: Monitors brushing pressure to prevent overbrushing and maintain gum health.\nROUND BRUSH HEAD DESIGN: Surrounds each tooth for up to 100% cleaner teeth and healthier gums compared to a manual brush.\nTIMER FUNCTION: Built-in timer ensures you brush for the dentist-recommended 2 minutes.\nWARRANTY: Comes with a 2-year warranty; manufactured in Germany for premium quality.	f	published	https://m.media-amazon.com/images/I/61PoBuu-9NL.jpg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2026-04-22 16:15:49.097+05	2026-04-22 16:15:49.097+05	\N	{"promos": [], "coupon_timer": null}
prod_01KPTFND37SAFPP8RPPGTAG7CP	Oral-B Pro 1-1000 Rechargeable Toothbrush 1+1 Bundle - 3D Cleaning, Pressure Sensor, Electric Toothbrush with CrossAction brush head - White	amz-b0cypcdnwq	Brand       Oral-B	- SUPERIOR CLEANING: Round Head Cross Action brush head surrounds each tooth for superior cleaning.\n- CLINICALLY PROVEN 3D CLEANING: Clinically proven superior 3D cleaning oscillates and pulsates to break up and remove up to 300% more plaque along the gum line compared to a manual toothbrush.\n- TIME COACHING FEATURE: Time Coaching feature helps you brush for the dentist-recommended 2 minutes.\n- PRESSURE SENSOR: The pressure sensor stops the pulsation movement if you brush too hard.\n- RECHARGEABLE: Rechargeable power toothbrush for convenience.\n- WARRANTY: Comes with a 2-year warranty.	f	published	https://m.media-amazon.com/images/I/712zxPvIHxL.jpg	\N	\N	\N	\N	gb			\N	pcol_01KPT2NGCXCX78V8BJ9R02JQQF	\N	t	\N	2026-04-22 16:37:02.329+05	2026-04-22 16:48:10.331+05	\N	{"promos": [], "tech_specs": {"Brand": "Brand       Oral-B", "Power source": "Power source       Battery Powered", "Special features": "Special features       Pressure Sensor", "Age range (description)": "Age range (description)       Adult", "Item firmness description": "Item firmness description       Hard"}, "coupon_timer": null}
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_category (id, name, description, handle, mpath, is_active, is_internal, rank, parent_category_id, created_at, updated_at, deleted_at, metadata) FROM stdin;
pcat_01KPC3ZE8WZPETXNKSJ2CT0187	Electric Brushes		electric-brushes	pcat_01KPC3ZE8WZPETXNKSJ2CT0187	t	f	0	\N	2026-04-17 02:43:26.237+05	2026-04-17 02:43:26.237+05	\N	\N
pcat_01KPC3ZE8W7FD5682QVQMMMCVC	Replacement Heads		replacement-heads	pcat_01KPC3ZE8W7FD5682QVQMMMCVC	t	f	1	\N	2026-04-17 02:43:26.237+05	2026-04-17 02:43:26.237+05	\N	\N
pcat_01KPC3ZE8XY9G36NM3QRBBHZYR	Floss & Interdental		floss-&-interdental	pcat_01KPC3ZE8XY9G36NM3QRBBHZYR	t	f	2	\N	2026-04-17 02:43:26.237+05	2026-04-17 02:43:26.237+05	\N	\N
\.


--
-- Data for Name: product_category_product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_category_product (product_id, product_category_id) FROM stdin;
prod_01KPC3ZE917A0KGB12XG5Z6TQG	pcat_01KPC3ZE8WZPETXNKSJ2CT0187
prod_01KPC3ZE91W4Y0QDGKEJJYACZG	pcat_01KPC3ZE8WZPETXNKSJ2CT0187
prod_01KPC3ZE91QKARBVHWZWTMHG6R	pcat_01KPC3ZE8W7FD5682QVQMMMCVC
prod_01KPTFND37SAFPP8RPPGTAG7CP	pcat_01KPC3ZE8WZPETXNKSJ2CT0187
\.


--
-- Data for Name: product_collection; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_collection (id, title, handle, metadata, created_at, updated_at, deleted_at) FROM stdin;
pcol_01KPT2NGCXCX78V8BJ9R02JQQF	Home Page	home-page	\N	2026-04-22 12:49:54.203377+05	2026-04-22 12:49:54.203377+05	\N
\.


--
-- Data for Name: product_option; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_option (id, title, product_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
opt_01KPC3ZE936C8RTJ7ZC24301FY	Color	prod_01KPC3ZE917A0KGB12XG5Z6TQG	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
opt_01KPC3ZE93NDF74DG0FN6PB6SN	Color	prod_01KPC3ZE91W4Y0QDGKEJJYACZG	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
opt_01KPC3ZE93ATXTEJQW81XVHNHH	Pack Size	prod_01KPC3ZE91QKARBVHWZWTMHG6R	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
opt_01KPT27Q355CJW4G0BDYD3MZKG	Color	prod_01KPT27Q338HRS1NZ5HMZ9P44B	\N	2026-04-22 12:42:22.309+05	2026-04-22 12:42:22.309+05	\N
opt_01KPT44AA8N0HVRZ8CSTX5650A	Default	prod_01KPT44AA6GHYWKNFYBVMHG852	\N	2026-04-22 13:15:28.074+05	2026-04-22 13:15:28.074+05	\N
opt_01KPT4CRZPAHAT5BY0K2GXE4A4	Default	prod_01KPT4CRZN34GMYQJPRHY1J7CT	\N	2026-04-22 13:20:05.238+05	2026-04-22 13:20:05.238+05	\N
opt_01KPT58FZ7M7KW2NNCAGESVSDE	Default	prod_01KPT58FZ1W2CEPTR24NG0MPMX	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N
opt_01KPT5ERQ21G430K0XJV3MTXRW	Default	prod_01KPT5ERQ0G3S23FS9FC1S2NX4	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N
opt_01KPT5GB4AZVJXHRKB4TMZ0CBV	Default	prod_01KPT5GB487QQMWCYV852JCV72	\N	2026-04-22 13:39:30.699+05	2026-04-22 13:39:30.699+05	\N
opt_01KPTEEHQ8D8GJNA84E3GMPH4E	Selection	prod_01KPTEEHQ69G0EP1YYS8GCDMM1	\N	2026-04-22 16:15:49.097+05	2026-04-22 16:15:49.097+05	\N
opt_01KPTFND3KT70HQTJ1XDES3YSZ	Selection	prod_01KPTFND37SAFPP8RPPGTAG7CP	\N	2026-04-22 16:37:02.33+05	2026-04-22 16:37:02.33+05	\N
\.


--
-- Data for Name: product_option_value; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_option_value (id, value, option_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
optval_01KPC3ZE92C3PFR16BNBN0EW69	Onyx Black	opt_01KPC3ZE936C8RTJ7ZC24301FY	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
optval_01KPC3ZE9235HFZTQMFH1TNE60	Rose Quartz	opt_01KPC3ZE936C8RTJ7ZC24301FY	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
optval_01KPC3ZE92JGTE334VSGDTSMR9	Alabaster White	opt_01KPC3ZE936C8RTJ7ZC24301FY	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
optval_01KPC3ZE9371X6WD81YVB466JA	White	opt_01KPC3ZE93NDF74DG0FN6PB6SN	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
optval_01KPC3ZE93RATERAZE80GQYDJ1	4 Count	opt_01KPC3ZE93ATXTEJQW81XVHNHH	\N	2026-04-17 02:43:26.244+05	2026-04-17 02:43:26.244+05	\N
optval_01KPT27Q34JF9QFS581SMBFASK	Midnight Blue	opt_01KPT27Q355CJW4G0BDYD3MZKG	\N	2026-04-22 12:42:22.31+05	2026-04-22 12:42:22.31+05	\N
optval_01KPT44AA84PQ9GF01721XJG9P	Default	opt_01KPT44AA8N0HVRZ8CSTX5650A	\N	2026-04-22 13:15:28.075+05	2026-04-22 13:15:28.075+05	\N
optval_01KPT4CRZN18M632G16FJ5CVFM	Default	opt_01KPT4CRZPAHAT5BY0K2GXE4A4	\N	2026-04-22 13:20:05.238+05	2026-04-22 13:20:05.238+05	\N
optval_01KPT58FZ63G2JN1JE8MEMD0B3	Default	opt_01KPT58FZ7M7KW2NNCAGESVSDE	\N	2026-04-22 13:35:13.514+05	2026-04-22 13:35:13.514+05	\N
optval_01KPT5ERQ2GZV7VDPV6MAJ7S8F	Default	opt_01KPT5ERQ21G430K0XJV3MTXRW	\N	2026-04-22 13:38:39.076+05	2026-04-22 13:38:39.076+05	\N
optval_01KPT5GB4AKW30PBS2Y5PZWH8J	Default	opt_01KPT5GB4AZVJXHRKB4TMZ0CBV	\N	2026-04-22 13:39:30.699+05	2026-04-22 13:39:30.699+05	\N
optval_01KPTEEHQ74RCK3JJME0ZPT514	Default	opt_01KPTEEHQ8D8GJNA84E3GMPH4E	\N	2026-04-22 16:15:49.097+05	2026-04-22 16:15:49.097+05	\N
optval_01KPTG4Y3GEHB0VA5Q2AKZZDG9	White	opt_01KPTFND3KT70HQTJ1XDES3YSZ	\N	2026-04-22 16:45:31.241923+05	2026-04-22 16:45:31.241923+05	\N
\.


--
-- Data for Name: product_sales_channel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_sales_channel (product_id, sales_channel_id, id, created_at, updated_at, deleted_at) FROM stdin;
prod_01KPC3ZE917A0KGB12XG5Z6TQG	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPC3ZE9GPYKNRDVJ3NZBK46Q	2026-04-17 02:43:26.256801+05	2026-04-17 02:43:26.256801+05	\N
prod_01KPC3ZE91W4Y0QDGKEJJYACZG	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPC3ZE9GDBG594VCXT5JB5A6	2026-04-17 02:43:26.256801+05	2026-04-17 02:43:26.256801+05	\N
prod_01KPC3ZE91QKARBVHWZWTMHG6R	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPC3ZE9G4HK21AJJAPEJ1RXH	2026-04-17 02:43:26.256801+05	2026-04-17 02:43:26.256801+05	\N
prod_01KPT27Q338HRS1NZ5HMZ9P44B	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPT27Q3N512DXVY9BFNF02EW	2026-04-22 12:42:22.326892+05	2026-04-22 12:42:22.326892+05	\N
prod_01KPT44AA6GHYWKNFYBVMHG852	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPT44ABCBQWAG8YJRBQ2HZWR	2026-04-22 13:15:28.107398+05	2026-04-22 13:15:28.107398+05	\N
prod_01KPT4CRZN34GMYQJPRHY1J7CT	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPT4CS00QQDTWWREQ2J6KTZQ	2026-04-22 13:20:05.248538+05	2026-04-22 13:20:05.248538+05	\N
prod_01KPT58FZ1W2CEPTR24NG0MPMX	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPT58G0WWYNCQSH5NNMFWBVQ	2026-04-22 13:35:13.559943+05	2026-04-22 13:35:13.559943+05	\N
prod_01KPT5ERQ0G3S23FS9FC1S2NX4	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPT5ERRHBDC6QZ3FK4P12B9H	2026-04-22 13:38:39.114569+05	2026-04-22 13:38:39.114569+05	\N
prod_01KPT5GB487QQMWCYV852JCV72	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPT5GB6DZRDNH7TYWQX42N3A	2026-04-22 13:39:30.762484+05	2026-04-22 13:39:30.762484+05	\N
prod_01KPTEEHQ69G0EP1YYS8GCDMM1	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPTEEHRBSQ0DCEFRSMGM0F5W	2026-04-22 16:15:49.130507+05	2026-04-22 16:15:49.130507+05	\N
prod_01KPTFND37SAFPP8RPPGTAG7CP	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	prodsc_01KPTFND5EEAM4VW15E9ZGXB5V	2026-04-22 16:37:02.381109+05	2026-04-22 16:37:02.381109+05	\N
\.


--
-- Data for Name: product_shipping_profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_shipping_profile (product_id, shipping_profile_id, id, created_at, updated_at, deleted_at) FROM stdin;
prod_01KPC3ZE917A0KGB12XG5Z6TQG	sp_01KPC3Z160DVNK4DXC50661TEG	prodsp_01KPC3ZE9PPE6CK9PCA9G1VB95	2026-04-17 02:43:26.262551+05	2026-04-17 02:43:26.262551+05	\N
prod_01KPC3ZE91W4Y0QDGKEJJYACZG	sp_01KPC3Z160DVNK4DXC50661TEG	prodsp_01KPC3ZE9P70EFMQ6R3TB0VAD7	2026-04-17 02:43:26.262551+05	2026-04-17 02:43:26.262551+05	\N
prod_01KPC3ZE91QKARBVHWZWTMHG6R	sp_01KPC3Z160DVNK4DXC50661TEG	prodsp_01KPC3ZE9PPJGCN5P1YD4ABF41	2026-04-17 02:43:26.262551+05	2026-04-17 02:43:26.262551+05	\N
prod_01KPTFND37SAFPP8RPPGTAG7CP	sp_01KPC3Z160DVNK4DXC50661TEG	prodsp_01KPTG8SZPDQQ5RBG7EP6D6YRF	2026-04-22 16:47:38.102526+05	2026-04-22 16:47:38.102526+05	\N
\.


--
-- Data for Name: product_tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_tag (id, value, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: product_tags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_tags (product_id, product_tag_id) FROM stdin;
\.


--
-- Data for Name: product_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_type (id, value, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: product_variant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variant (id, title, sku, barcode, ean, upc, allow_backorder, manage_inventory, hs_code, origin_country, mid_code, material, weight, length, height, width, metadata, variant_rank, product_id, created_at, updated_at, deleted_at, thumbnail) FROM stdin;
variant_01KPC3ZEA1SZ2Z03KP170C0QFS	Onyx Black	IO-9-BLK	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPC3ZE917A0KGB12XG5Z6TQG	2026-04-17 02:43:26.273+05	2026-04-17 02:43:26.273+05	\N	\N
variant_01KPC3ZEA11CRT67TA4020FQ1Z	Rose Quartz	IO-9-PNK	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPC3ZE917A0KGB12XG5Z6TQG	2026-04-17 02:43:26.273+05	2026-04-17 02:43:26.273+05	\N	\N
variant_01KPC3ZEA1MAMW0BFCKFFTNE3Q	Alabaster White	IO-9-WHT	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPC3ZE917A0KGB12XG5Z6TQG	2026-04-17 02:43:26.273+05	2026-04-17 02:43:26.273+05	\N	\N
variant_01KPC3ZEA1Q1SS9YB0JD4M9SK9	White	IO-7-WHT	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPC3ZE91W4Y0QDGKEJJYACZG	2026-04-17 02:43:26.273+05	2026-04-17 02:43:26.273+05	\N	\N
variant_01KPC3ZEA16JV8WNKTX37DPBDB	4 Count Pack	IO-HEADS-4CT	\N	\N	\N	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPC3ZE91QKARBVHWZWTMHG6R	2026-04-17 02:43:26.273+05	2026-04-17 02:43:26.273+05	\N	\N
variant_01KPT27Q4ACXSM633A2V2VVJVT	Midnight Blue	SONICARE-9900-BLU	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPT27Q338HRS1NZ5HMZ9P44B	2026-04-22 12:42:22.346+05	2026-04-22 12:42:22.346+05	\N	\N
variant_01KPT44ACMNS9RWB3B0QAB6KHW	Default	AMZ-B0CFYC38YK	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPT44AA6GHYWKNFYBVMHG852	2026-04-22 13:15:28.149+05	2026-04-22 13:15:28.149+05	\N	\N
variant_01KPT4CS0JHT4SWFKV2WSQFZ60	Default	AMZ-B0CGJ5W2SX	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPT4CRZN34GMYQJPRHY1J7CT	2026-04-22 13:20:05.266+05	2026-04-22 13:20:05.266+05	\N	\N
variant_01KPT58G2M3NX84CNAZ6PE2WTD	Default	AMZ-B09H7LTX4C	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPT58FZ1W2CEPTR24NG0MPMX	2026-04-22 13:35:13.621+05	2026-04-22 13:35:13.621+05	\N	\N
variant_01KPT5ERT0856C7NKG4Y1CMJP1	Default	AMZ-B003U9V7PA	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPT5ERQ0G3S23FS9FC1S2NX4	2026-04-22 13:38:39.168+05	2026-04-22 13:38:39.168+05	\N	\N
variant_01KPT5GB7B7C91YF1Z2MKGGAB1	Default	AMZ-B07N156DRR	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPT5GB487QQMWCYV852JCV72	2026-04-22 13:39:30.795+05	2026-04-22 13:39:30.795+05	\N	\N
variant_01KPTEEHRV73V30DH2PMA8GDM7	Default	AMZ-B0FLWKL7J5-DEF	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPTEEHQ69G0EP1YYS8GCDMM1	2026-04-22 16:15:49.148+05	2026-04-22 16:15:49.148+05	\N	\N
variant_01KPTFND8MZ55H0SB3CJ87JJ64	White	B0CYPCDNWQ	\N	\N	\N	f	t	\N	gb	\N	\N	\N	\N	\N	\N	\N	0	prod_01KPTFND37SAFPP8RPPGTAG7CP	2026-04-22 16:37:02.486+05	2026-04-22 16:37:02.486+05	\N	\N
\.


--
-- Data for Name: product_variant_inventory_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variant_inventory_item (variant_id, inventory_item_id, id, required_quantity, created_at, updated_at, deleted_at) FROM stdin;
variant_01KPC3ZEA1SZ2Z03KP170C0QFS	iitem_01KPC3ZEA93QVC0PZXNJZ89G6T	pvitem_01KPC3ZEAG61SFEM9KAV4FH6H8	1	2026-04-17 02:43:26.288789+05	2026-04-17 02:43:26.288789+05	\N
variant_01KPC3ZEA11CRT67TA4020FQ1Z	iitem_01KPC3ZEA9MBQEZ6QBXVGSYX0Z	pvitem_01KPC3ZEAG5RK1K9HKNV9EANJV	1	2026-04-17 02:43:26.288789+05	2026-04-17 02:43:26.288789+05	\N
variant_01KPC3ZEA1MAMW0BFCKFFTNE3Q	iitem_01KPC3ZEA9K59ECR0YC8RHYFQ1	pvitem_01KPC3ZEAG61VWF6JY7JAQC0WK	1	2026-04-17 02:43:26.288789+05	2026-04-17 02:43:26.288789+05	\N
variant_01KPC3ZEA1Q1SS9YB0JD4M9SK9	iitem_01KPC3ZEA91VFC4PPTD99BRHWJ	pvitem_01KPC3ZEAGVZPZFR34CKJT7P9W	1	2026-04-17 02:43:26.288789+05	2026-04-17 02:43:26.288789+05	\N
variant_01KPC3ZEA16JV8WNKTX37DPBDB	iitem_01KPC3ZEA9Y3X7A601MCGP3EEN	pvitem_01KPC3ZEAHQQF4M59B9MBN67WK	1	2026-04-17 02:43:26.288789+05	2026-04-17 02:43:26.288789+05	\N
variant_01KPTFND8MZ55H0SB3CJ87JJ64	iitem_01KPC3ZEA9Y3X7A601MCGP3EEN	pvitem_01KPTG6VPXNBRY1MDKAA5M0SRK	5	2026-04-22 16:46:34.332791+05	2026-04-22 16:46:34.332791+05	\N
\.


--
-- Data for Name: product_variant_option; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variant_option (variant_id, option_value_id) FROM stdin;
variant_01KPC3ZEA1SZ2Z03KP170C0QFS	optval_01KPC3ZE92C3PFR16BNBN0EW69
variant_01KPC3ZEA11CRT67TA4020FQ1Z	optval_01KPC3ZE9235HFZTQMFH1TNE60
variant_01KPC3ZEA1MAMW0BFCKFFTNE3Q	optval_01KPC3ZE92JGTE334VSGDTSMR9
variant_01KPC3ZEA1Q1SS9YB0JD4M9SK9	optval_01KPC3ZE9371X6WD81YVB466JA
variant_01KPC3ZEA16JV8WNKTX37DPBDB	optval_01KPC3ZE93RATERAZE80GQYDJ1
variant_01KPT27Q4ACXSM633A2V2VVJVT	optval_01KPT27Q34JF9QFS581SMBFASK
variant_01KPT44ACMNS9RWB3B0QAB6KHW	optval_01KPT44AA84PQ9GF01721XJG9P
variant_01KPT4CS0JHT4SWFKV2WSQFZ60	optval_01KPT4CRZN18M632G16FJ5CVFM
variant_01KPT58G2M3NX84CNAZ6PE2WTD	optval_01KPT58FZ63G2JN1JE8MEMD0B3
variant_01KPT5ERT0856C7NKG4Y1CMJP1	optval_01KPT5ERQ2GZV7VDPV6MAJ7S8F
variant_01KPT5GB7B7C91YF1Z2MKGGAB1	optval_01KPT5GB4AKW30PBS2Y5PZWH8J
variant_01KPTEEHRV73V30DH2PMA8GDM7	optval_01KPTEEHQ74RCK3JJME0ZPT514
variant_01KPTFND8MZ55H0SB3CJ87JJ64	optval_01KPTG4Y3GEHB0VA5Q2AKZZDG9
\.


--
-- Data for Name: product_variant_price_set; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variant_price_set (variant_id, price_set_id, id, created_at, updated_at, deleted_at) FROM stdin;
variant_01KPC3ZEA1SZ2Z03KP170C0QFS	pset_01KPC3ZEANZ3H2476H3NV93CVT	pvps_01KPC3ZEAZY7MAEVDC36JYVH1C	2026-04-17 02:43:26.303299+05	2026-04-17 02:43:26.303299+05	\N
variant_01KPC3ZEA11CRT67TA4020FQ1Z	pset_01KPC3ZEANY4MMJY3V832XR46W	pvps_01KPC3ZEAZR2R8YG52XZJWEYKY	2026-04-17 02:43:26.303299+05	2026-04-17 02:43:26.303299+05	\N
variant_01KPC3ZEA1MAMW0BFCKFFTNE3Q	pset_01KPC3ZEAPJ3XNA97TKPKCMYZK	pvps_01KPC3ZEAZA1KZZKSCVPGMGF1N	2026-04-17 02:43:26.303299+05	2026-04-17 02:43:26.303299+05	\N
variant_01KPC3ZEA1Q1SS9YB0JD4M9SK9	pset_01KPC3ZEAP82E39PR5QVZSM915	pvps_01KPC3ZEAZNYVYGW2Q0HPJM452	2026-04-17 02:43:26.303299+05	2026-04-17 02:43:26.303299+05	\N
variant_01KPC3ZEA16JV8WNKTX37DPBDB	pset_01KPC3ZEAP02R5QQSA4AEH6CD0	pvps_01KPC3ZEAZ7B5EDH199YW5QDHS	2026-04-17 02:43:26.303299+05	2026-04-17 02:43:26.303299+05	\N
variant_01KPT27Q4ACXSM633A2V2VVJVT	pset_01KPT27Q4Q7C9DZ2NJXMMDTKQF	pvps_01KPT27Q55VYM06YJHCW2SEEBF	2026-04-22 12:42:22.374158+05	2026-04-22 12:42:22.374158+05	\N
variant_01KPT44ACMNS9RWB3B0QAB6KHW	pset_01KPT44ADA3PTTQDBJ4HY6KHP4	pvps_01KPT44AEAZMC77WRCP9SX0CFP	2026-04-22 13:15:28.202049+05	2026-04-22 13:15:28.202049+05	\N
variant_01KPT4CS0JHT4SWFKV2WSQFZ60	pset_01KPT4CS13TXGP73WTW09AA6Q4	pvps_01KPT4CS1N3XWAV99JY1V3J7CM	2026-04-22 13:20:05.301017+05	2026-04-22 13:20:05.301017+05	\N
variant_01KPT58G2M3NX84CNAZ6PE2WTD	pset_01KPT58G4C1XYRSCJEXGKP2SNP	pvps_01KPT58G5J9PX4AB6JXEN77S8H	2026-04-22 13:35:13.71409+05	2026-04-22 13:35:13.71409+05	\N
variant_01KPT5ERT0856C7NKG4Y1CMJP1	pset_01KPT5ERVS4304YYG4MAX07TM0	pvps_01KPT5ERWW9J14CN7P28GQKST3	2026-04-22 13:38:39.2553+05	2026-04-22 13:38:39.2553+05	\N
variant_01KPT5GB7B7C91YF1Z2MKGGAB1	pset_01KPT5GB8NEZVQ9VGMB6PRQFH2	pvps_01KPT5GB9BNCB8QXZ17F6NZ3G9	2026-04-22 13:39:30.858618+05	2026-04-22 13:39:30.858618+05	\N
variant_01KPTEEHRV73V30DH2PMA8GDM7	pset_01KPTEEHSG6ZBH5HHF634SVKNR	pvps_01KPTEEHT08N4ZKPJV5DRXJKQD	2026-04-22 16:15:49.183713+05	2026-04-22 16:15:49.183713+05	\N
variant_01KPTFND8MZ55H0SB3CJ87JJ64	pset_01KPTFNDBBB16DEP07Z903S9RK	pvps_01KPTFNDDMA2KQS9NQRZ9FRH9W	2026-04-22 16:37:02.644484+05	2026-04-22 16:37:02.644484+05	\N
\.


--
-- Data for Name: product_variant_product_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variant_product_image (id, variant_id, image_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion (id, code, campaign_id, is_automatic, type, created_at, updated_at, deleted_at, status, is_tax_inclusive, "limit", used, metadata) FROM stdin;
\.


--
-- Data for Name: promotion_application_method; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion_application_method (id, value, raw_value, max_quantity, apply_to_quantity, buy_rules_min_quantity, type, target_type, allocation, promotion_id, created_at, updated_at, deleted_at, currency_code) FROM stdin;
\.


--
-- Data for Name: promotion_campaign; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion_campaign (id, name, description, campaign_identifier, starts_at, ends_at, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion_campaign_budget; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion_campaign_budget (id, type, campaign_id, "limit", raw_limit, used, raw_used, created_at, updated_at, deleted_at, currency_code, attribute) FROM stdin;
\.


--
-- Data for Name: promotion_campaign_budget_usage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion_campaign_budget_usage (id, attribute_value, used, budget_id, raw_used, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion_promotion_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion_promotion_rule (promotion_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: promotion_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion_rule (id, description, attribute, operator, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion_rule_value; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promotion_rule_value (id, promotion_rule_id, value, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: provider_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.provider_identity (id, entity_id, provider, auth_identity_id, user_metadata, provider_metadata, created_at, updated_at, deleted_at) FROM stdin;
01KPE8HZB6Y62A89RH5MPS5K29	admin@dentauae.com	emailpass	authid_01KPE8HZB6HWEQNHS43Q2J99SJ	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAVtau8YNncXr1HcscIVTUck2bxPvxk0B/vCUlBy2INfelZEPXhNPiVJzRzqYtas1FvkUU4AaFhVzhsccZtd6mQ5JOhjjwBnEp0ZVbvxZIYQE"}	2026-04-17 22:41:56.71+05	2026-04-17 22:41:56.71+05	\N
01KQ5TQ97D8D8E4YAHX0A6TA7C	admin2@dentauae.com	emailpass	authid_01KQ5TQ97GCABS75FE17P6D09K	\N	{"password": "c2NyeXB0AA8AAAAIAAAAASAhmalHNlZvMi6akrFwg0jWlluNej5/ll48/y8f5L4i1BeLI7RhX0TFdGiYPorQFj2ySkkctNnbhoDT1BzB9eKSgUQjHJyZ97s11afTPxWk"}	2026-04-27 02:21:56.977+05	2026-04-27 02:21:56.977+05	\N
\.


--
-- Data for Name: publishable_api_key_sales_channel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.publishable_api_key_sales_channel (publishable_key_id, sales_channel_id, id, created_at, updated_at, deleted_at) FROM stdin;
apk_01KPC3ZE4AFSBX92QRCC147J91	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	pksc_01KPC3ZE8PEGNEFYWAFKMC8B5K	2026-04-17 02:43:26.095588+05	2026-04-17 02:43:26.095588+05	\N
\.


--
-- Data for Name: refund; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.refund (id, amount, raw_amount, payment_id, created_at, updated_at, deleted_at, created_by, metadata, refund_reason_id, note) FROM stdin;
\.


--
-- Data for Name: refund_reason; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.refund_reason (id, label, description, metadata, created_at, updated_at, deleted_at, code) FROM stdin;
refr_01KPC3YVXJF2K1B0QGV10YMBR8	Shipping Issue	Refund due to lost, delayed, or misdelivered shipment	\N	2026-04-17 02:43:07.378327+05	2026-04-17 02:43:07.378327+05	\N	shipping_issue
refr_01KPC3YVXKE9QB7AMTW3DJN64E	Customer Care Adjustment	Refund given as goodwill or compensation for inconvenience	\N	2026-04-17 02:43:07.378327+05	2026-04-17 02:43:07.378327+05	\N	customer_care_adjustment
refr_01KPC3YVXKXGR025FT7JZF7RDX	Pricing Error	Refund to correct an overcharge, missing discount, or incorrect price	\N	2026-04-17 02:43:07.378327+05	2026-04-17 02:43:07.378327+05	\N	pricing_error
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.region (id, name, currency_code, metadata, created_at, updated_at, deleted_at, automatic_taxes) FROM stdin;
reg_01KPC3ZE57TA5ZWFX8AC1FYS92	Middle East	aed	\N	2026-04-17 02:43:26.122+05	2026-04-17 02:43:26.122+05	\N	t
\.


--
-- Data for Name: region_country; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.region_country (iso_2, iso_3, num_code, name, display_name, region_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
af	afg	004	AFGHANISTAN	Afghanistan	\N	\N	2026-04-17 02:43:11.973+05	2026-04-17 02:43:11.973+05	\N
al	alb	008	ALBANIA	Albania	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
dz	dza	012	ALGERIA	Algeria	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
as	asm	016	AMERICAN SAMOA	American Samoa	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ad	and	020	ANDORRA	Andorra	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ao	ago	024	ANGOLA	Angola	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ai	aia	660	ANGUILLA	Anguilla	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
aq	ata	010	ANTARCTICA	Antarctica	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ag	atg	028	ANTIGUA AND BARBUDA	Antigua and Barbuda	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ar	arg	032	ARGENTINA	Argentina	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
am	arm	051	ARMENIA	Armenia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
aw	abw	533	ARUBA	Aruba	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
au	aus	036	AUSTRALIA	Australia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
at	aut	040	AUSTRIA	Austria	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
az	aze	031	AZERBAIJAN	Azerbaijan	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bs	bhs	044	BAHAMAS	Bahamas	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bd	bgd	050	BANGLADESH	Bangladesh	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bb	brb	052	BARBADOS	Barbados	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
by	blr	112	BELARUS	Belarus	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
be	bel	056	BELGIUM	Belgium	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bz	blz	084	BELIZE	Belize	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bj	ben	204	BENIN	Benin	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bm	bmu	060	BERMUDA	Bermuda	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bt	btn	064	BHUTAN	Bhutan	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bo	bol	068	BOLIVIA	Bolivia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bq	bes	535	BONAIRE, SINT EUSTATIUS AND SABA	Bonaire, Sint Eustatius and Saba	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ba	bih	070	BOSNIA AND HERZEGOVINA	Bosnia and Herzegovina	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bw	bwa	072	BOTSWANA	Botswana	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bv	bvd	074	BOUVET ISLAND	Bouvet Island	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
br	bra	076	BRAZIL	Brazil	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
io	iot	086	BRITISH INDIAN OCEAN TERRITORY	British Indian Ocean Territory	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bn	brn	096	BRUNEI DARUSSALAM	Brunei Darussalam	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bg	bgr	100	BULGARIA	Bulgaria	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bf	bfa	854	BURKINA FASO	Burkina Faso	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
bi	bdi	108	BURUNDI	Burundi	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
kh	khm	116	CAMBODIA	Cambodia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cm	cmr	120	CAMEROON	Cameroon	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ca	can	124	CANADA	Canada	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cv	cpv	132	CAPE VERDE	Cape Verde	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ky	cym	136	CAYMAN ISLANDS	Cayman Islands	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cf	caf	140	CENTRAL AFRICAN REPUBLIC	Central African Republic	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
td	tcd	148	CHAD	Chad	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cl	chl	152	CHILE	Chile	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cn	chn	156	CHINA	China	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cx	cxr	162	CHRISTMAS ISLAND	Christmas Island	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cc	cck	166	COCOS (KEELING) ISLANDS	Cocos (Keeling) Islands	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
co	col	170	COLOMBIA	Colombia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
km	com	174	COMOROS	Comoros	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cg	cog	178	CONGO	Congo	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cd	cod	180	CONGO, THE DEMOCRATIC REPUBLIC OF THE	Congo, the Democratic Republic of the	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ck	cok	184	COOK ISLANDS	Cook Islands	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cr	cri	188	COSTA RICA	Costa Rica	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ci	civ	384	COTE D'IVOIRE	Cote D'Ivoire	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
hr	hrv	191	CROATIA	Croatia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cu	cub	192	CUBA	Cuba	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cw	cuw	531	CURAÇAO	Curaçao	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cy	cyp	196	CYPRUS	Cyprus	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
cz	cze	203	CZECH REPUBLIC	Czech Republic	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
dk	dnk	208	DENMARK	Denmark	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
dj	dji	262	DJIBOUTI	Djibouti	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
dm	dma	212	DOMINICA	Dominica	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
do	dom	214	DOMINICAN REPUBLIC	Dominican Republic	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ec	ecu	218	ECUADOR	Ecuador	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
eg	egy	818	EGYPT	Egypt	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
sv	slv	222	EL SALVADOR	El Salvador	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
gq	gnq	226	EQUATORIAL GUINEA	Equatorial Guinea	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
er	eri	232	ERITREA	Eritrea	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
ee	est	233	ESTONIA	Estonia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
et	eth	231	ETHIOPIA	Ethiopia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
fk	flk	238	FALKLAND ISLANDS (MALVINAS)	Falkland Islands (Malvinas)	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
fo	fro	234	FAROE ISLANDS	Faroe Islands	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
fj	fji	242	FIJI	Fiji	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
fi	fin	246	FINLAND	Finland	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
fr	fra	250	FRANCE	France	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
gf	guf	254	FRENCH GUIANA	French Guiana	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
pf	pyf	258	FRENCH POLYNESIA	French Polynesia	\N	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:11.974+05	\N
tf	atf	260	FRENCH SOUTHERN TERRITORIES	French Southern Territories	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ga	gab	266	GABON	Gabon	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gm	gmb	270	GAMBIA	Gambia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ge	geo	268	GEORGIA	Georgia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
de	deu	276	GERMANY	Germany	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gh	gha	288	GHANA	Ghana	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gi	gib	292	GIBRALTAR	Gibraltar	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gr	grc	300	GREECE	Greece	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gl	grl	304	GREENLAND	Greenland	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gd	grd	308	GRENADA	Grenada	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gp	glp	312	GUADELOUPE	Guadeloupe	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gu	gum	316	GUAM	Guam	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gt	gtm	320	GUATEMALA	Guatemala	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gg	ggy	831	GUERNSEY	Guernsey	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gn	gin	324	GUINEA	Guinea	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gw	gnb	624	GUINEA-BISSAU	Guinea-Bissau	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gy	guy	328	GUYANA	Guyana	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ht	hti	332	HAITI	Haiti	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
hm	hmd	334	HEARD ISLAND AND MCDONALD ISLANDS	Heard Island And Mcdonald Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
va	vat	336	HOLY SEE (VATICAN CITY STATE)	Holy See (Vatican City State)	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
hn	hnd	340	HONDURAS	Honduras	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
hk	hkg	344	HONG KONG	Hong Kong	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
hu	hun	348	HUNGARY	Hungary	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
is	isl	352	ICELAND	Iceland	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
in	ind	356	INDIA	India	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
id	idn	360	INDONESIA	Indonesia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ir	irn	364	IRAN, ISLAMIC REPUBLIC OF	Iran, Islamic Republic of	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
iq	irq	368	IRAQ	Iraq	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ie	irl	372	IRELAND	Ireland	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
im	imn	833	ISLE OF MAN	Isle Of Man	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
il	isr	376	ISRAEL	Israel	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
it	ita	380	ITALY	Italy	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
jm	jam	388	JAMAICA	Jamaica	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
jp	jpn	392	JAPAN	Japan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
je	jey	832	JERSEY	Jersey	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
jo	jor	400	JORDAN	Jordan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
kz	kaz	398	KAZAKHSTAN	Kazakhstan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ke	ken	404	KENYA	Kenya	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ki	kir	296	KIRIBATI	Kiribati	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
kp	prk	408	KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF	Korea, Democratic People's Republic of	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
kr	kor	410	KOREA, REPUBLIC OF	Korea, Republic of	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
xk	xkx	900	KOSOVO	Kosovo	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
kg	kgz	417	KYRGYZSTAN	Kyrgyzstan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
la	lao	418	LAO PEOPLE'S DEMOCRATIC REPUBLIC	Lao People's Democratic Republic	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
lv	lva	428	LATVIA	Latvia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
lb	lbn	422	LEBANON	Lebanon	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ls	lso	426	LESOTHO	Lesotho	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
lr	lbr	430	LIBERIA	Liberia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ly	lby	434	LIBYA	Libya	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
li	lie	438	LIECHTENSTEIN	Liechtenstein	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
lt	ltu	440	LITHUANIA	Lithuania	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
lu	lux	442	LUXEMBOURG	Luxembourg	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mo	mac	446	MACAO	Macao	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mg	mdg	450	MADAGASCAR	Madagascar	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mw	mwi	454	MALAWI	Malawi	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
my	mys	458	MALAYSIA	Malaysia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mv	mdv	462	MALDIVES	Maldives	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ml	mli	466	MALI	Mali	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mt	mlt	470	MALTA	Malta	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mh	mhl	584	MARSHALL ISLANDS	Marshall Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mq	mtq	474	MARTINIQUE	Martinique	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mr	mrt	478	MAURITANIA	Mauritania	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mu	mus	480	MAURITIUS	Mauritius	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
yt	myt	175	MAYOTTE	Mayotte	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mx	mex	484	MEXICO	Mexico	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
fm	fsm	583	MICRONESIA, FEDERATED STATES OF	Micronesia, Federated States of	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
md	mda	498	MOLDOVA, REPUBLIC OF	Moldova, Republic of	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mc	mco	492	MONACO	Monaco	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mn	mng	496	MONGOLIA	Mongolia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
me	mne	499	MONTENEGRO	Montenegro	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ms	msr	500	MONTSERRAT	Montserrat	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ma	mar	504	MOROCCO	Morocco	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mz	moz	508	MOZAMBIQUE	Mozambique	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mm	mmr	104	MYANMAR	Myanmar	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
na	nam	516	NAMIBIA	Namibia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
nr	nru	520	NAURU	Nauru	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
np	npl	524	NEPAL	Nepal	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
nl	nld	528	NETHERLANDS	Netherlands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
nc	ncl	540	NEW CALEDONIA	New Caledonia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
nz	nzl	554	NEW ZEALAND	New Zealand	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ni	nic	558	NICARAGUA	Nicaragua	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ne	ner	562	NIGER	Niger	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ng	nga	566	NIGERIA	Nigeria	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
nu	niu	570	NIUE	Niue	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
nf	nfk	574	NORFOLK ISLAND	Norfolk Island	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mk	mkd	807	NORTH MACEDONIA	North Macedonia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mp	mnp	580	NORTHERN MARIANA ISLANDS	Northern Mariana Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
no	nor	578	NORWAY	Norway	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pk	pak	586	PAKISTAN	Pakistan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pw	plw	585	PALAU	Palau	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ps	pse	275	PALESTINIAN TERRITORY, OCCUPIED	Palestinian Territory, Occupied	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pa	pan	591	PANAMA	Panama	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pg	png	598	PAPUA NEW GUINEA	Papua New Guinea	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
py	pry	600	PARAGUAY	Paraguay	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pe	per	604	PERU	Peru	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ph	phl	608	PHILIPPINES	Philippines	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pn	pcn	612	PITCAIRN	Pitcairn	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pl	pol	616	POLAND	Poland	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pt	prt	620	PORTUGAL	Portugal	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pr	pri	630	PUERTO RICO	Puerto Rico	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
re	reu	638	REUNION	Reunion	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ro	rom	642	ROMANIA	Romania	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ru	rus	643	RUSSIAN FEDERATION	Russian Federation	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
rw	rwa	646	RWANDA	Rwanda	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
bl	blm	652	SAINT BARTHÉLEMY	Saint Barthélemy	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sh	shn	654	SAINT HELENA	Saint Helena	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
kn	kna	659	SAINT KITTS AND NEVIS	Saint Kitts and Nevis	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
lc	lca	662	SAINT LUCIA	Saint Lucia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
mf	maf	663	SAINT MARTIN (FRENCH PART)	Saint Martin (French part)	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
pm	spm	666	SAINT PIERRE AND MIQUELON	Saint Pierre and Miquelon	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
vc	vct	670	SAINT VINCENT AND THE GRENADINES	Saint Vincent and the Grenadines	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ws	wsm	882	SAMOA	Samoa	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sm	smr	674	SAN MARINO	San Marino	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
st	stp	678	SAO TOME AND PRINCIPE	Sao Tome and Principe	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sn	sen	686	SENEGAL	Senegal	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
rs	srb	688	SERBIA	Serbia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sc	syc	690	SEYCHELLES	Seychelles	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sl	sle	694	SIERRA LEONE	Sierra Leone	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sg	sgp	702	SINGAPORE	Singapore	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sx	sxm	534	SINT MAARTEN	Sint Maarten	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sk	svk	703	SLOVAKIA	Slovakia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
si	svn	705	SLOVENIA	Slovenia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sb	slb	090	SOLOMON ISLANDS	Solomon Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
so	som	706	SOMALIA	Somalia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
za	zaf	710	SOUTH AFRICA	South Africa	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gs	sgs	239	SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS	South Georgia and the South Sandwich Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ss	ssd	728	SOUTH SUDAN	South Sudan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
es	esp	724	SPAIN	Spain	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
lk	lka	144	SRI LANKA	Sri Lanka	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sd	sdn	729	SUDAN	Sudan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sr	sur	740	SURINAME	Suriname	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sj	sjm	744	SVALBARD AND JAN MAYEN	Svalbard and Jan Mayen	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sz	swz	748	SWAZILAND	Swaziland	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
se	swe	752	SWEDEN	Sweden	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ch	che	756	SWITZERLAND	Switzerland	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
sy	syr	760	SYRIAN ARAB REPUBLIC	Syrian Arab Republic	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tw	twn	158	TAIWAN, PROVINCE OF CHINA	Taiwan, Province of China	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tj	tjk	762	TAJIKISTAN	Tajikistan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tz	tza	834	TANZANIA, UNITED REPUBLIC OF	Tanzania, United Republic of	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
th	tha	764	THAILAND	Thailand	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tl	tls	626	TIMOR LESTE	Timor Leste	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tg	tgo	768	TOGO	Togo	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tk	tkl	772	TOKELAU	Tokelau	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
to	ton	776	TONGA	Tonga	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tt	tto	780	TRINIDAD AND TOBAGO	Trinidad and Tobago	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tn	tun	788	TUNISIA	Tunisia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tr	tur	792	TURKEY	Turkey	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tm	tkm	795	TURKMENISTAN	Turkmenistan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tc	tca	796	TURKS AND CAICOS ISLANDS	Turks and Caicos Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
tv	tuv	798	TUVALU	Tuvalu	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ug	uga	800	UGANDA	Uganda	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ua	ukr	804	UKRAINE	Ukraine	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
gb	gbr	826	UNITED KINGDOM	United Kingdom	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
us	usa	840	UNITED STATES	United States	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
um	umi	581	UNITED STATES MINOR OUTLYING ISLANDS	United States Minor Outlying Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
uy	ury	858	URUGUAY	Uruguay	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
uz	uzb	860	UZBEKISTAN	Uzbekistan	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
vu	vut	548	VANUATU	Vanuatu	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ve	ven	862	VENEZUELA	Venezuela	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
vn	vnm	704	VIET NAM	Viet Nam	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
vg	vgb	092	VIRGIN ISLANDS, BRITISH	Virgin Islands, British	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
vi	vir	850	VIRGIN ISLANDS, U.S.	Virgin Islands, U.S.	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
wf	wlf	876	WALLIS AND FUTUNA	Wallis and Futuna	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
eh	esh	732	WESTERN SAHARA	Western Sahara	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ye	yem	887	YEMEN	Yemen	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
zm	zmb	894	ZAMBIA	Zambia	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
zw	zwe	716	ZIMBABWE	Zimbabwe	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
ax	ala	248	ÅLAND ISLANDS	Åland Islands	\N	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:11.975+05	\N
bh	bhr	048	BAHRAIN	Bahrain	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	2026-04-17 02:43:11.974+05	2026-04-17 02:43:26.123+05	\N
kw	kwt	414	KUWAIT	Kuwait	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:26.123+05	\N
om	omn	512	OMAN	Oman	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:26.123+05	\N
qa	qat	634	QATAR	Qatar	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:26.123+05	\N
sa	sau	682	SAUDI ARABIA	Saudi Arabia	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:26.123+05	\N
ae	are	784	UNITED ARAB EMIRATES	United Arab Emirates	reg_01KPC3ZE57TA5ZWFX8AC1FYS92	\N	2026-04-17 02:43:11.975+05	2026-04-17 02:43:26.122+05	\N
\.


--
-- Data for Name: region_payment_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.region_payment_provider (region_id, payment_provider_id, id, created_at, updated_at, deleted_at) FROM stdin;
reg_01KPC3ZE57TA5ZWFX8AC1FYS92	pp_system_default	regpp_01KPC3ZE5KKFYNK91CC8JYBC5C	2026-04-17 02:43:26.131699+05	2026-04-17 02:43:26.131699+05	\N
\.


--
-- Data for Name: reservation_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reservation_item (id, created_at, updated_at, deleted_at, line_item_id, location_id, quantity, external_id, description, created_by, metadata, inventory_item_id, allow_backorder, raw_quantity) FROM stdin;
resitem_01KPDX1G4Q3JPBTKB274V35VAJ	2026-04-17 19:20:42.541+05	2026-04-22 14:20:55.52+05	2026-04-22 14:20:55.499+05	ordli_01KPDX1FWC759XFJSST1FQEH7Z	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	1	\N	\N	\N	\N	iitem_01KPC3ZEA9MBQEZ6QBXVGSYX0Z	f	{"value": "1", "precision": 20}
\.


--
-- Data for Name: return; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.return (id, order_id, claim_id, exchange_id, order_version, display_id, status, no_notification, refund_amount, raw_refund_amount, metadata, created_at, updated_at, deleted_at, received_at, canceled_at, location_id, requested_at, created_by) FROM stdin;
\.


--
-- Data for Name: return_fulfillment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.return_fulfillment (return_id, fulfillment_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: return_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.return_item (id, return_id, reason_id, item_id, quantity, raw_quantity, received_quantity, raw_received_quantity, note, metadata, created_at, updated_at, deleted_at, damaged_quantity, raw_damaged_quantity) FROM stdin;
\.


--
-- Data for Name: return_reason; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.return_reason (id, value, label, description, metadata, parent_return_reason_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: sales_channel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sales_channel (id, name, description, is_disabled, metadata, created_at, updated_at, deleted_at) FROM stdin;
sc_01KPC3ZE3GQ501NKE5KYMRV7RB	Default Sales Channel	Created by Medusa	f	\N	2026-04-17 02:43:26.064+05	2026-04-17 02:43:26.064+05	\N
\.


--
-- Data for Name: sales_channel_stock_location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sales_channel_stock_location (sales_channel_id, stock_location_id, id, created_at, updated_at, deleted_at) FROM stdin;
sc_01KPC3ZE3GQ501NKE5KYMRV7RB	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	scloc_01KPC3ZE8C70JPQ8FFZH78W5K0	2026-04-17 02:43:26.220568+05	2026-04-17 02:43:26.220568+05	\N
\.


--
-- Data for Name: script_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.script_migrations (id, script_name, created_at, finished_at) FROM stdin;
1	migrate-product-shipping-profile.js	2026-04-17 02:43:12.814913+05	2026-04-17 02:43:12.840328+05
2	migrate-tax-region-provider.js	2026-04-17 02:43:12.842265+05	2026-04-17 02:43:12.846759+05
\.


--
-- Data for Name: service_zone; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.service_zone (id, name, metadata, fulfillment_set_id, created_at, updated_at, deleted_at) FROM stdin;
serzo_01KPC3ZE6FT7D99MYFQ5BJEQJX	Middle East	\N	fuset_01KPC3ZE6FSESSQFDB1EFEPDAG	2026-04-17 02:43:26.159+05	2026-04-17 02:43:26.159+05	\N
\.


--
-- Data for Name: shipping_option; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_option (id, name, price_type, service_zone_id, shipping_profile_id, provider_id, data, metadata, shipping_option_type_id, created_at, updated_at, deleted_at) FROM stdin;
so_01KPC3ZE79FE9YYM62X80JWK3Y	Express Delivery	flat	serzo_01KPC3ZE6FT7D99MYFQ5BJEQJX	sp_01KPC3Z160DVNK4DXC50661TEG	manual_manual	\N	\N	sotype_01KPC3ZE79FMN3F8F9D5VV4QZA	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
so_01KPC3ZE7AMBYJNM52DHE8ZX3H	Free Clinical Shipping	flat	serzo_01KPC3ZE6FT7D99MYFQ5BJEQJX	sp_01KPC3Z160DVNK4DXC50661TEG	manual_manual	\N	\N	sotype_01KPC3ZE792RWEVH0ETNVM5JQC	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
so_01KPC3ZE792AK7TCQSYKEQ2G5S	Standard Shipping	flat	serzo_01KPC3ZE6FT7D99MYFQ5BJEQJX	sp_01KPC3Z160DVNK4DXC50661TEG	manual_manual	\N	\N	sotype_01KPC3ZE792RWEVH0ETNVM5JQC	2026-04-17 02:43:26.186+05	2026-04-22 16:49:33.147+05	\N
\.


--
-- Data for Name: shipping_option_price_set; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_option_price_set (shipping_option_id, price_set_id, id, created_at, updated_at, deleted_at) FROM stdin;
so_01KPC3ZE792AK7TCQSYKEQ2G5S	pset_01KPC3ZE7MWKSGTC852HF7ECK6	sops_01KPC3ZE87MFMA32D4CCH738Y8	2026-04-17 02:43:26.215998+05	2026-04-17 02:43:26.215998+05	\N
so_01KPC3ZE79FE9YYM62X80JWK3Y	pset_01KPC3ZE7M7VXREN0JKVEW8KWW	sops_01KPC3ZE88GBXS1DHPX4RMM877	2026-04-17 02:43:26.215998+05	2026-04-17 02:43:26.215998+05	\N
so_01KPC3ZE7AMBYJNM52DHE8ZX3H	pset_01KPC3ZE7MZJ1CDEQY1CTHQH0Y	sops_01KPC3ZE88B38M6DRV7RZEFXYY	2026-04-17 02:43:26.215998+05	2026-04-17 02:43:26.215998+05	\N
\.


--
-- Data for Name: shipping_option_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_option_rule (id, attribute, operator, value, shipping_option_id, created_at, updated_at, deleted_at) FROM stdin;
sorul_01KPC3ZE79MS8S45HEGK464HF1	enabled_in_store	eq	"true"	so_01KPC3ZE792AK7TCQSYKEQ2G5S	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
sorul_01KPC3ZE792V1J1ME9JZCPPWQC	is_return	eq	"false"	so_01KPC3ZE792AK7TCQSYKEQ2G5S	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
sorul_01KPC3ZE79SNJR6K6JVHA3XRH5	enabled_in_store	eq	"true"	so_01KPC3ZE79FE9YYM62X80JWK3Y	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
sorul_01KPC3ZE7950PSGWQ1RF61SAV5	is_return	eq	"false"	so_01KPC3ZE79FE9YYM62X80JWK3Y	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
sorul_01KPC3ZE79F4N6YHMGN5NCP2DX	enabled_in_store	eq	"true"	so_01KPC3ZE7AMBYJNM52DHE8ZX3H	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
sorul_01KPC3ZE79TCCC8PXBHJ61P5JP	is_return	eq	"false"	so_01KPC3ZE7AMBYJNM52DHE8ZX3H	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
\.


--
-- Data for Name: shipping_option_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_option_type (id, label, description, code, created_at, updated_at, deleted_at) FROM stdin;
sotype_01KPC3ZE791Y2YC1MPMVNZJFH4	Standard	Ship in 2-3 days.	standard	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
sotype_01KPC3ZE79FMN3F8F9D5VV4QZA	Express	Same Day Delivery (Dubai Only)	express	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
sotype_01KPC3ZE792RWEVH0ETNVM5JQC	Free	Free shipping for orders over AED 99	free	2026-04-17 02:43:26.186+05	2026-04-17 02:43:26.186+05	\N
\.


--
-- Data for Name: shipping_profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_profile (id, name, type, metadata, created_at, updated_at, deleted_at) FROM stdin;
sp_01KPC3Z160DVNK4DXC50661TEG	Default Shipping Profile	default	\N	2026-04-17 02:43:12.832+05	2026-04-17 02:43:12.832+05	\N
\.


--
-- Data for Name: stock_location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stock_location (id, created_at, updated_at, deleted_at, name, address_id, metadata) FROM stdin;
sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	2026-04-17 02:43:26.143+05	2026-04-17 02:43:26.143+05	\N	Dubai Warehouse	laddr_01KPC3ZE5YF1VVZDTRZN8VKXD3	\N
\.


--
-- Data for Name: stock_location_address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stock_location_address (id, created_at, updated_at, deleted_at, address_1, address_2, company, city, country_code, phone, province, postal_code, metadata) FROM stdin;
laddr_01KPC3ZE5YF1VVZDTRZN8VKXD3	2026-04-17 02:43:26.143+05	2026-04-22 16:49:14.143+05	\N	Al Quoz Industrial Area 3			Dubai	AE				\N
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.store (id, name, default_sales_channel_id, default_region_id, default_location_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
store_01KPC3ZE3RZV67MP8CMNGGJF4H	Medusa Store	sc_01KPC3ZE3GQ501NKE5KYMRV7RB	\N	sloc_01KPC3ZE5Y5T6JANESS5AEA0E5	\N	2026-04-17 02:43:26.071732+05	2026-04-17 02:43:26.071732+05	\N
\.


--
-- Data for Name: store_currency; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.store_currency (id, currency_code, is_default, store_id, created_at, updated_at, deleted_at) FROM stdin;
stocur_01KPC3ZE4YVW0HGVRWGQ5DRD4F	aed	t	store_01KPC3ZE3RZV67MP8CMNGGJF4H	2026-04-17 02:43:26.109491+05	2026-04-17 02:43:26.109491+05	\N
stocur_01KPC3ZE4YA5XNVTD4CN756W19	usd	f	store_01KPC3ZE3RZV67MP8CMNGGJF4H	2026-04-17 02:43:26.109491+05	2026-04-17 02:43:26.109491+05	\N
\.


--
-- Data for Name: store_locale; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.store_locale (id, locale_code, store_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: tax_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tax_provider (id, is_enabled, created_at, updated_at, deleted_at) FROM stdin;
tp_system	t	2026-04-17 02:43:12.005+05	2026-04-17 02:43:12.005+05	\N
\.


--
-- Data for Name: tax_rate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tax_rate (id, rate, code, name, is_default, is_combinable, tax_region_id, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
\.


--
-- Data for Name: tax_rate_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tax_rate_rule (id, tax_rate_id, reference_id, reference, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
\.


--
-- Data for Name: tax_region; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tax_region (id, provider_id, country_code, province_code, parent_id, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
txreg_01KPC3ZE5RY3AXHBG6DZHHB9EA	tp_system	ae	\N	\N	\N	2026-04-17 02:43:26.136+05	2026-04-17 02:43:26.136+05	\N	\N
txreg_01KPC3ZE5RF4TZZ12YBN1S48WV	tp_system	sa	\N	\N	\N	2026-04-17 02:43:26.136+05	2026-04-17 02:43:26.136+05	\N	\N
txreg_01KPC3ZE5RSFSS003FT7BJ2GVK	tp_system	om	\N	\N	\N	2026-04-17 02:43:26.137+05	2026-04-17 02:43:26.137+05	\N	\N
txreg_01KPC3ZE5R23ZYBH60E1SC2AMD	tp_system	kw	\N	\N	\N	2026-04-17 02:43:26.137+05	2026-04-17 02:43:26.137+05	\N	\N
txreg_01KPC3ZE5RF84TZHJHVBYBXTT5	tp_system	bh	\N	\N	\N	2026-04-17 02:43:26.137+05	2026-04-17 02:43:26.137+05	\N	\N
txreg_01KPC3ZE5RNE8ZXT5JAS9JZY9M	tp_system	qa	\N	\N	\N	2026-04-17 02:43:26.137+05	2026-04-17 02:43:26.137+05	\N	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, first_name, last_name, email, avatar_url, metadata, created_at, updated_at, deleted_at) FROM stdin;
user_01KPE8HZ9CRAXYVDM1KCXH81FA	\N	\N	admin@dentauae.com	\N	\N	2026-04-17 22:41:56.652+05	2026-04-17 22:41:56.652+05	\N
user_01KQ5TQ8VEDSYC1AR3KJQ4YDM4	\N	\N	admin2@dentauae.com	\N	\N	2026-04-27 02:21:56.59+05	2026-04-27 02:21:56.59+05	\N
\.


--
-- Data for Name: user_preference; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_preference (id, user_id, key, value, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: user_rbac_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_rbac_role (user_id, rbac_role_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: view_configuration; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.view_configuration (id, entity, name, user_id, is_system_default, configuration, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: workflow_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.workflow_execution (id, workflow_id, transaction_id, execution, context, state, created_at, updated_at, deleted_at, retention_time, run_id) FROM stdin;
\.


--
-- Name: link_module_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.link_module_migrations_id_seq', 33, true);


--
-- Name: mikro_orm_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.mikro_orm_migrations_id_seq', 165, true);


--
-- Name: order_change_action_ordering_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_change_action_ordering_seq', 3, true);


--
-- Name: order_claim_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_claim_display_id_seq', 1, false);


--
-- Name: order_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_display_id_seq', 2, true);


--
-- Name: order_exchange_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_exchange_display_id_seq', 1, false);


--
-- Name: return_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.return_display_id_seq', 1, false);


--
-- Name: script_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.script_migrations_id_seq', 33, true);


--
-- Name: account_holder account_holder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_holder
    ADD CONSTRAINT account_holder_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: application_method_buy_rules application_method_buy_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_method_buy_rules
    ADD CONSTRAINT application_method_buy_rules_pkey PRIMARY KEY (application_method_id, promotion_rule_id);


--
-- Name: application_method_target_rules application_method_target_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_method_target_rules
    ADD CONSTRAINT application_method_target_rules_pkey PRIMARY KEY (application_method_id, promotion_rule_id);


--
-- Name: auth_identity auth_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_identity
    ADD CONSTRAINT auth_identity_pkey PRIMARY KEY (id);


--
-- Name: capture capture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.capture
    ADD CONSTRAINT capture_pkey PRIMARY KEY (id);


--
-- Name: cart_address cart_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_address
    ADD CONSTRAINT cart_address_pkey PRIMARY KEY (id);


--
-- Name: cart_line_item_adjustment cart_line_item_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_line_item_adjustment
    ADD CONSTRAINT cart_line_item_adjustment_pkey PRIMARY KEY (id);


--
-- Name: cart_line_item cart_line_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_line_item
    ADD CONSTRAINT cart_line_item_pkey PRIMARY KEY (id);


--
-- Name: cart_line_item_tax_line cart_line_item_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_line_item_tax_line
    ADD CONSTRAINT cart_line_item_tax_line_pkey PRIMARY KEY (id);


--
-- Name: cart_payment_collection cart_payment_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_payment_collection
    ADD CONSTRAINT cart_payment_collection_pkey PRIMARY KEY (cart_id, payment_collection_id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: cart_promotion cart_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_promotion
    ADD CONSTRAINT cart_promotion_pkey PRIMARY KEY (cart_id, promotion_id);


--
-- Name: cart_shipping_method_adjustment cart_shipping_method_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_shipping_method_adjustment
    ADD CONSTRAINT cart_shipping_method_adjustment_pkey PRIMARY KEY (id);


--
-- Name: cart_shipping_method cart_shipping_method_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_shipping_method
    ADD CONSTRAINT cart_shipping_method_pkey PRIMARY KEY (id);


--
-- Name: cart_shipping_method_tax_line cart_shipping_method_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_shipping_method_tax_line
    ADD CONSTRAINT cart_shipping_method_tax_line_pkey PRIMARY KEY (id);


--
-- Name: credit_line credit_line_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_line
    ADD CONSTRAINT credit_line_pkey PRIMARY KEY (id);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (code);


--
-- Name: customer_account_holder customer_account_holder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_account_holder
    ADD CONSTRAINT customer_account_holder_pkey PRIMARY KEY (customer_id, account_holder_id);


--
-- Name: customer_address customer_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_pkey PRIMARY KEY (id);


--
-- Name: customer_group_customer customer_group_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group_customer
    ADD CONSTRAINT customer_group_customer_pkey PRIMARY KEY (id);


--
-- Name: customer_group customer_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT customer_group_pkey PRIMARY KEY (id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_address fulfillment_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment_address
    ADD CONSTRAINT fulfillment_address_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_item fulfillment_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment_item
    ADD CONSTRAINT fulfillment_item_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_label fulfillment_label_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment_label
    ADD CONSTRAINT fulfillment_label_pkey PRIMARY KEY (id);


--
-- Name: fulfillment fulfillment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_provider fulfillment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment_provider
    ADD CONSTRAINT fulfillment_provider_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_set fulfillment_set_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment_set
    ADD CONSTRAINT fulfillment_set_pkey PRIMARY KEY (id);


--
-- Name: geo_zone geo_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geo_zone
    ADD CONSTRAINT geo_zone_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: inventory_item inventory_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT inventory_item_pkey PRIMARY KEY (id);


--
-- Name: inventory_level inventory_level_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_level
    ADD CONSTRAINT inventory_level_pkey PRIMARY KEY (id);


--
-- Name: invite invite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invite
    ADD CONSTRAINT invite_pkey PRIMARY KEY (id);


--
-- Name: invite_rbac_role invite_rbac_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invite_rbac_role
    ADD CONSTRAINT invite_rbac_role_pkey PRIMARY KEY (invite_id, rbac_role_id);


--
-- Name: link_module_migrations link_module_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_module_migrations
    ADD CONSTRAINT link_module_migrations_pkey PRIMARY KEY (id);


--
-- Name: link_module_migrations link_module_migrations_table_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_module_migrations
    ADD CONSTRAINT link_module_migrations_table_name_key UNIQUE (table_name);


--
-- Name: location_fulfillment_provider location_fulfillment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location_fulfillment_provider
    ADD CONSTRAINT location_fulfillment_provider_pkey PRIMARY KEY (stock_location_id, fulfillment_provider_id);


--
-- Name: location_fulfillment_set location_fulfillment_set_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location_fulfillment_set
    ADD CONSTRAINT location_fulfillment_set_pkey PRIMARY KEY (stock_location_id, fulfillment_set_id);


--
-- Name: mikro_orm_migrations mikro_orm_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mikro_orm_migrations
    ADD CONSTRAINT mikro_orm_migrations_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notification_provider notification_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_provider
    ADD CONSTRAINT notification_provider_pkey PRIMARY KEY (id);


--
-- Name: order_address order_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_address
    ADD CONSTRAINT order_address_pkey PRIMARY KEY (id);


--
-- Name: order_cart order_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_pkey PRIMARY KEY (order_id, cart_id);


--
-- Name: order_change_action order_change_action_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_change_action
    ADD CONSTRAINT order_change_action_pkey PRIMARY KEY (id);


--
-- Name: order_change order_change_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_change
    ADD CONSTRAINT order_change_pkey PRIMARY KEY (id);


--
-- Name: order_claim_item_image order_claim_item_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_claim_item_image
    ADD CONSTRAINT order_claim_item_image_pkey PRIMARY KEY (id);


--
-- Name: order_claim_item order_claim_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_claim_item
    ADD CONSTRAINT order_claim_item_pkey PRIMARY KEY (id);


--
-- Name: order_claim order_claim_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_claim
    ADD CONSTRAINT order_claim_pkey PRIMARY KEY (id);


--
-- Name: order_credit_line order_credit_line_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_credit_line
    ADD CONSTRAINT order_credit_line_pkey PRIMARY KEY (id);


--
-- Name: order_exchange_item order_exchange_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_exchange_item
    ADD CONSTRAINT order_exchange_item_pkey PRIMARY KEY (id);


--
-- Name: order_exchange order_exchange_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_exchange
    ADD CONSTRAINT order_exchange_pkey PRIMARY KEY (id);


--
-- Name: order_fulfillment order_fulfillment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_fulfillment
    ADD CONSTRAINT order_fulfillment_pkey PRIMARY KEY (order_id, fulfillment_id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- Name: order_line_item_adjustment order_line_item_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_line_item_adjustment
    ADD CONSTRAINT order_line_item_adjustment_pkey PRIMARY KEY (id);


--
-- Name: order_line_item order_line_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_line_item
    ADD CONSTRAINT order_line_item_pkey PRIMARY KEY (id);


--
-- Name: order_line_item_tax_line order_line_item_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_line_item_tax_line
    ADD CONSTRAINT order_line_item_tax_line_pkey PRIMARY KEY (id);


--
-- Name: order_payment_collection order_payment_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_payment_collection
    ADD CONSTRAINT order_payment_collection_pkey PRIMARY KEY (order_id, payment_collection_id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order_promotion order_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_promotion
    ADD CONSTRAINT order_promotion_pkey PRIMARY KEY (order_id, promotion_id);


--
-- Name: order_shipping_method_adjustment order_shipping_method_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipping_method_adjustment
    ADD CONSTRAINT order_shipping_method_adjustment_pkey PRIMARY KEY (id);


--
-- Name: order_shipping_method order_shipping_method_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipping_method
    ADD CONSTRAINT order_shipping_method_pkey PRIMARY KEY (id);


--
-- Name: order_shipping_method_tax_line order_shipping_method_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipping_method_tax_line
    ADD CONSTRAINT order_shipping_method_tax_line_pkey PRIMARY KEY (id);


--
-- Name: order_shipping order_shipping_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipping
    ADD CONSTRAINT order_shipping_pkey PRIMARY KEY (id);


--
-- Name: order_summary order_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_summary
    ADD CONSTRAINT order_summary_pkey PRIMARY KEY (id);


--
-- Name: order_transaction order_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_transaction
    ADD CONSTRAINT order_transaction_pkey PRIMARY KEY (id);


--
-- Name: payment_collection_payment_providers payment_collection_payment_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_collection_payment_providers
    ADD CONSTRAINT payment_collection_payment_providers_pkey PRIMARY KEY (payment_collection_id, payment_provider_id);


--
-- Name: payment_collection payment_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_collection
    ADD CONSTRAINT payment_collection_pkey PRIMARY KEY (id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: payment_provider payment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_provider
    ADD CONSTRAINT payment_provider_pkey PRIMARY KEY (id);


--
-- Name: payment_session payment_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_session
    ADD CONSTRAINT payment_session_pkey PRIMARY KEY (id);


--
-- Name: price_list price_list_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_list
    ADD CONSTRAINT price_list_pkey PRIMARY KEY (id);


--
-- Name: price_list_rule price_list_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_list_rule
    ADD CONSTRAINT price_list_rule_pkey PRIMARY KEY (id);


--
-- Name: price price_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_pkey PRIMARY KEY (id);


--
-- Name: price_preference price_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_preference
    ADD CONSTRAINT price_preference_pkey PRIMARY KEY (id);


--
-- Name: price_rule price_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_rule
    ADD CONSTRAINT price_rule_pkey PRIMARY KEY (id);


--
-- Name: price_set price_set_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_set
    ADD CONSTRAINT price_set_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product_category_product product_category_product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT product_category_product_pkey PRIMARY KEY (product_id, product_category_id);


--
-- Name: product_collection product_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT product_collection_pkey PRIMARY KEY (id);


--
-- Name: product_option product_option_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_option
    ADD CONSTRAINT product_option_pkey PRIMARY KEY (id);


--
-- Name: product_option_value product_option_value_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_option_value
    ADD CONSTRAINT product_option_value_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_sales_channel product_sales_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_sales_channel
    ADD CONSTRAINT product_sales_channel_pkey PRIMARY KEY (product_id, sales_channel_id);


--
-- Name: product_shipping_profile product_shipping_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_shipping_profile
    ADD CONSTRAINT product_shipping_profile_pkey PRIMARY KEY (product_id, shipping_profile_id);


--
-- Name: product_tag product_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_tag
    ADD CONSTRAINT product_tag_pkey PRIMARY KEY (id);


--
-- Name: product_tags product_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_pkey PRIMARY KEY (product_id, product_tag_id);


--
-- Name: product_type product_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT product_type_pkey PRIMARY KEY (id);


--
-- Name: product_variant_inventory_item product_variant_inventory_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_inventory_item
    ADD CONSTRAINT product_variant_inventory_item_pkey PRIMARY KEY (variant_id, inventory_item_id);


--
-- Name: product_variant_option product_variant_option_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_option
    ADD CONSTRAINT product_variant_option_pkey PRIMARY KEY (variant_id, option_value_id);


--
-- Name: product_variant product_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT product_variant_pkey PRIMARY KEY (id);


--
-- Name: product_variant_price_set product_variant_price_set_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_price_set
    ADD CONSTRAINT product_variant_price_set_pkey PRIMARY KEY (variant_id, price_set_id);


--
-- Name: product_variant_product_image product_variant_product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_product_image
    ADD CONSTRAINT product_variant_product_image_pkey PRIMARY KEY (id);


--
-- Name: promotion_application_method promotion_application_method_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_application_method
    ADD CONSTRAINT promotion_application_method_pkey PRIMARY KEY (id);


--
-- Name: promotion_campaign_budget promotion_campaign_budget_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_campaign_budget
    ADD CONSTRAINT promotion_campaign_budget_pkey PRIMARY KEY (id);


--
-- Name: promotion_campaign_budget_usage promotion_campaign_budget_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_campaign_budget_usage
    ADD CONSTRAINT promotion_campaign_budget_usage_pkey PRIMARY KEY (id);


--
-- Name: promotion_campaign promotion_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_campaign
    ADD CONSTRAINT promotion_campaign_pkey PRIMARY KEY (id);


--
-- Name: promotion promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT promotion_pkey PRIMARY KEY (id);


--
-- Name: promotion_promotion_rule promotion_promotion_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_promotion_rule
    ADD CONSTRAINT promotion_promotion_rule_pkey PRIMARY KEY (promotion_id, promotion_rule_id);


--
-- Name: promotion_rule promotion_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_rule
    ADD CONSTRAINT promotion_rule_pkey PRIMARY KEY (id);


--
-- Name: promotion_rule_value promotion_rule_value_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_rule_value
    ADD CONSTRAINT promotion_rule_value_pkey PRIMARY KEY (id);


--
-- Name: provider_identity provider_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_identity
    ADD CONSTRAINT provider_identity_pkey PRIMARY KEY (id);


--
-- Name: publishable_api_key_sales_channel publishable_api_key_sales_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publishable_api_key_sales_channel
    ADD CONSTRAINT publishable_api_key_sales_channel_pkey PRIMARY KEY (publishable_key_id, sales_channel_id);


--
-- Name: refund refund_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_pkey PRIMARY KEY (id);


--
-- Name: refund_reason refund_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refund_reason
    ADD CONSTRAINT refund_reason_pkey PRIMARY KEY (id);


--
-- Name: region_country region_country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region_country
    ADD CONSTRAINT region_country_pkey PRIMARY KEY (iso_2);


--
-- Name: region_payment_provider region_payment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region_payment_provider
    ADD CONSTRAINT region_payment_provider_pkey PRIMARY KEY (region_id, payment_provider_id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: reservation_item reservation_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservation_item
    ADD CONSTRAINT reservation_item_pkey PRIMARY KEY (id);


--
-- Name: return_fulfillment return_fulfillment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.return_fulfillment
    ADD CONSTRAINT return_fulfillment_pkey PRIMARY KEY (return_id, fulfillment_id);


--
-- Name: return_item return_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.return_item
    ADD CONSTRAINT return_item_pkey PRIMARY KEY (id);


--
-- Name: return return_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT return_pkey PRIMARY KEY (id);


--
-- Name: return_reason return_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.return_reason
    ADD CONSTRAINT return_reason_pkey PRIMARY KEY (id);


--
-- Name: sales_channel sales_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_channel
    ADD CONSTRAINT sales_channel_pkey PRIMARY KEY (id);


--
-- Name: sales_channel_stock_location sales_channel_stock_location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_channel_stock_location
    ADD CONSTRAINT sales_channel_stock_location_pkey PRIMARY KEY (sales_channel_id, stock_location_id);


--
-- Name: script_migrations script_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.script_migrations
    ADD CONSTRAINT script_migrations_pkey PRIMARY KEY (id);


--
-- Name: service_zone service_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_zone
    ADD CONSTRAINT service_zone_pkey PRIMARY KEY (id);


--
-- Name: shipping_option shipping_option_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_pkey PRIMARY KEY (id);


--
-- Name: shipping_option_price_set shipping_option_price_set_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option_price_set
    ADD CONSTRAINT shipping_option_price_set_pkey PRIMARY KEY (shipping_option_id, price_set_id);


--
-- Name: shipping_option_rule shipping_option_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option_rule
    ADD CONSTRAINT shipping_option_rule_pkey PRIMARY KEY (id);


--
-- Name: shipping_option_type shipping_option_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option_type
    ADD CONSTRAINT shipping_option_type_pkey PRIMARY KEY (id);


--
-- Name: shipping_profile shipping_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_profile
    ADD CONSTRAINT shipping_profile_pkey PRIMARY KEY (id);


--
-- Name: stock_location_address stock_location_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_location_address
    ADD CONSTRAINT stock_location_address_pkey PRIMARY KEY (id);


--
-- Name: stock_location stock_location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_location
    ADD CONSTRAINT stock_location_pkey PRIMARY KEY (id);


--
-- Name: store_currency store_currency_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_currency
    ADD CONSTRAINT store_currency_pkey PRIMARY KEY (id);


--
-- Name: store_locale store_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_locale
    ADD CONSTRAINT store_locale_pkey PRIMARY KEY (id);


--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: tax_provider tax_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_provider
    ADD CONSTRAINT tax_provider_pkey PRIMARY KEY (id);


--
-- Name: tax_rate tax_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT tax_rate_pkey PRIMARY KEY (id);


--
-- Name: tax_rate_rule tax_rate_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_rate_rule
    ADD CONSTRAINT tax_rate_rule_pkey PRIMARY KEY (id);


--
-- Name: tax_region tax_region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_region
    ADD CONSTRAINT tax_region_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_preference user_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_preference
    ADD CONSTRAINT user_preference_pkey PRIMARY KEY (id);


--
-- Name: user_rbac_role user_rbac_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_rbac_role
    ADD CONSTRAINT user_rbac_role_pkey PRIMARY KEY (user_id, rbac_role_id);


--
-- Name: view_configuration view_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.view_configuration
    ADD CONSTRAINT view_configuration_pkey PRIMARY KEY (id);


--
-- Name: workflow_execution workflow_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_execution
    ADD CONSTRAINT workflow_execution_pkey PRIMARY KEY (workflow_id, transaction_id, run_id);


--
-- Name: IDX_account_holder_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_account_holder_deleted_at" ON public.account_holder USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_account_holder_id_5cb3a0c0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_account_holder_id_5cb3a0c0" ON public.customer_account_holder USING btree (account_holder_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_account_holder_provider_id_external_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_account_holder_provider_id_external_id_unique" ON public.account_holder USING btree (provider_id, external_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_api_key_deleted_at" ON public.api_key USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_redacted; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_api_key_redacted" ON public.api_key USING btree (redacted) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_revoked_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_api_key_revoked_at" ON public.api_key USING btree (revoked_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_token_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_api_key_token_unique" ON public.api_key USING btree (token);


--
-- Name: IDX_api_key_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_api_key_type" ON public.api_key USING btree (type);


--
-- Name: IDX_application_method_allocation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_application_method_allocation" ON public.promotion_application_method USING btree (allocation);


--
-- Name: IDX_application_method_target_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_application_method_target_type" ON public.promotion_application_method USING btree (target_type);


--
-- Name: IDX_application_method_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_application_method_type" ON public.promotion_application_method USING btree (type);


--
-- Name: IDX_auth_identity_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_auth_identity_deleted_at" ON public.auth_identity USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_campaign_budget_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_campaign_budget_type" ON public.promotion_campaign_budget USING btree (type);


--
-- Name: IDX_capture_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_capture_deleted_at" ON public.capture USING btree (deleted_at);


--
-- Name: IDX_capture_payment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_capture_payment_id" ON public.capture USING btree (payment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_address_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_address_deleted_at" ON public.cart_address USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_billing_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_billing_address_id" ON public.cart USING btree (billing_address_id) WHERE ((deleted_at IS NULL) AND (billing_address_id IS NOT NULL));


--
-- Name: IDX_cart_credit_line_reference_reference_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_credit_line_reference_reference_id" ON public.credit_line USING btree (reference, reference_id) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_currency_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_currency_code" ON public.cart USING btree (currency_code);


--
-- Name: IDX_cart_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_customer_id" ON public.cart USING btree (customer_id) WHERE ((deleted_at IS NULL) AND (customer_id IS NOT NULL));


--
-- Name: IDX_cart_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_deleted_at" ON public.cart USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_id_-4a39f6c9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_id_-4a39f6c9" ON public.cart_payment_collection USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_id_-71069c16; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_id_-71069c16" ON public.order_cart USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_id_-a9d4a70b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_id_-a9d4a70b" ON public.cart_promotion USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_line_item_adjustment_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_line_item_adjustment_deleted_at" ON public.cart_line_item_adjustment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_line_item_adjustment_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_line_item_adjustment_item_id" ON public.cart_line_item_adjustment USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_line_item_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_line_item_cart_id" ON public.cart_line_item USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_line_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_line_item_deleted_at" ON public.cart_line_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_line_item_tax_line_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_line_item_tax_line_deleted_at" ON public.cart_line_item_tax_line USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_line_item_tax_line_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_line_item_tax_line_item_id" ON public.cart_line_item_tax_line USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_region_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_region_id" ON public.cart USING btree (region_id) WHERE ((deleted_at IS NULL) AND (region_id IS NOT NULL));


--
-- Name: IDX_cart_sales_channel_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_sales_channel_id" ON public.cart USING btree (sales_channel_id) WHERE ((deleted_at IS NULL) AND (sales_channel_id IS NOT NULL));


--
-- Name: IDX_cart_shipping_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_shipping_address_id" ON public.cart USING btree (shipping_address_id) WHERE ((deleted_at IS NULL) AND (shipping_address_id IS NOT NULL));


--
-- Name: IDX_cart_shipping_method_adjustment_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_shipping_method_adjustment_deleted_at" ON public.cart_shipping_method_adjustment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_shipping_method_adjustment_shipping_method_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_shipping_method_adjustment_shipping_method_id" ON public.cart_shipping_method_adjustment USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_shipping_method_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_shipping_method_cart_id" ON public.cart_shipping_method USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_shipping_method_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_shipping_method_deleted_at" ON public.cart_shipping_method USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_shipping_method_tax_line_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_shipping_method_tax_line_deleted_at" ON public.cart_shipping_method_tax_line USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_shipping_method_tax_line_shipping_method_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_cart_shipping_method_tax_line_shipping_method_id" ON public.cart_shipping_method_tax_line USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_category_handle_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_category_handle_unique" ON public.product_category USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_collection_handle_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_collection_handle_unique" ON public.product_collection USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_credit_line_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_credit_line_cart_id" ON public.credit_line USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_credit_line_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_credit_line_deleted_at" ON public.credit_line USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_address_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_address_customer_id" ON public.customer_address USING btree (customer_id);


--
-- Name: IDX_customer_address_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_address_deleted_at" ON public.customer_address USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_address_unique_customer_billing; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_customer_address_unique_customer_billing" ON public.customer_address USING btree (customer_id) WHERE (is_default_billing = true);


--
-- Name: IDX_customer_address_unique_customer_shipping; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_customer_address_unique_customer_shipping" ON public.customer_address USING btree (customer_id) WHERE (is_default_shipping = true);


--
-- Name: IDX_customer_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_deleted_at" ON public.customer USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_email_has_account_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_customer_email_has_account_unique" ON public.customer USING btree (email, has_account) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_customer_customer_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_group_customer_customer_group_id" ON public.customer_group_customer USING btree (customer_group_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_customer_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_group_customer_customer_id" ON public.customer_group_customer USING btree (customer_id);


--
-- Name: IDX_customer_group_customer_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_group_customer_deleted_at" ON public.customer_group_customer USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_group_deleted_at" ON public.customer_group USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_customer_group_name_unique" ON public.customer_group USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_id_5cb3a0c0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_customer_id_5cb3a0c0" ON public.customer_account_holder USING btree (customer_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_deleted_at_-1d67bae40; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-1e5992737; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-1e5992737" ON public.location_fulfillment_provider USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-31ea43a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-31ea43a" ON public.return_fulfillment USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-4a39f6c9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-4a39f6c9" ON public.cart_payment_collection USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-71069c16; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-71069c16" ON public.order_cart USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-71518339; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-71518339" ON public.order_promotion USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-85069d44; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-85069d44" ON public.invite_rbac_role USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-a9d4a70b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-a9d4a70b" ON public.cart_promotion USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-e88adb96; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-e88adb96" ON public.location_fulfillment_set USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-e8d2543e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_-e8d2543e" ON public.order_fulfillment USING btree (deleted_at);


--
-- Name: IDX_deleted_at_17a262437; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_17a262437" ON public.product_shipping_profile USING btree (deleted_at);


--
-- Name: IDX_deleted_at_17b4c4e35; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_17b4c4e35" ON public.product_variant_inventory_item USING btree (deleted_at);


--
-- Name: IDX_deleted_at_1c934dab0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_1c934dab0" ON public.region_payment_provider USING btree (deleted_at);


--
-- Name: IDX_deleted_at_20b454295; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_20b454295" ON public.product_sales_channel USING btree (deleted_at);


--
-- Name: IDX_deleted_at_26d06f470; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_26d06f470" ON public.sales_channel_stock_location USING btree (deleted_at);


--
-- Name: IDX_deleted_at_52b23597; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_52b23597" ON public.product_variant_price_set USING btree (deleted_at);


--
-- Name: IDX_deleted_at_5cb3a0c0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_5cb3a0c0" ON public.customer_account_holder USING btree (deleted_at);


--
-- Name: IDX_deleted_at_64ff0c4c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_64ff0c4c" ON public.user_rbac_role USING btree (deleted_at);


--
-- Name: IDX_deleted_at_ba32fa9c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_ba32fa9c" ON public.shipping_option_price_set USING btree (deleted_at);


--
-- Name: IDX_deleted_at_f42b9949; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_deleted_at_f42b9949" ON public.order_payment_collection USING btree (deleted_at);


--
-- Name: IDX_fulfillment_address_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_address_deleted_at" ON public.fulfillment_address USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_deleted_at" ON public.fulfillment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_id_-31ea43a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_id_-31ea43a" ON public.return_fulfillment USING btree (fulfillment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_id_-e8d2543e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_id_-e8d2543e" ON public.order_fulfillment USING btree (fulfillment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_item_deleted_at" ON public.fulfillment_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_item_fulfillment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_item_fulfillment_id" ON public.fulfillment_item USING btree (fulfillment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_item_inventory_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_item_inventory_item_id" ON public.fulfillment_item USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_item_line_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_item_line_item_id" ON public.fulfillment_item USING btree (line_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_label_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_label_deleted_at" ON public.fulfillment_label USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_label_fulfillment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_label_fulfillment_id" ON public.fulfillment_label USING btree (fulfillment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_location_id" ON public.fulfillment USING btree (location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_provider_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_provider_deleted_at" ON public.fulfillment_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_provider_id_-1e5992737; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_provider_id_-1e5992737" ON public.location_fulfillment_provider USING btree (fulfillment_provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_set_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_set_deleted_at" ON public.fulfillment_set USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_set_id_-e88adb96; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_set_id_-e88adb96" ON public.location_fulfillment_set USING btree (fulfillment_set_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_set_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_fulfillment_set_name_unique" ON public.fulfillment_set USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_shipping_option_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_fulfillment_shipping_option_id" ON public.fulfillment USING btree (shipping_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_geo_zone_city; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_geo_zone_city" ON public.geo_zone USING btree (city) WHERE ((deleted_at IS NULL) AND (city IS NOT NULL));


--
-- Name: IDX_geo_zone_country_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_geo_zone_country_code" ON public.geo_zone USING btree (country_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_geo_zone_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_geo_zone_deleted_at" ON public.geo_zone USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_geo_zone_province_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_geo_zone_province_code" ON public.geo_zone USING btree (province_code) WHERE ((deleted_at IS NULL) AND (province_code IS NOT NULL));


--
-- Name: IDX_geo_zone_service_zone_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_geo_zone_service_zone_id" ON public.geo_zone USING btree (service_zone_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_id_-1d67bae40; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (id);


--
-- Name: IDX_id_-1e5992737; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-1e5992737" ON public.location_fulfillment_provider USING btree (id);


--
-- Name: IDX_id_-31ea43a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-31ea43a" ON public.return_fulfillment USING btree (id);


--
-- Name: IDX_id_-4a39f6c9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-4a39f6c9" ON public.cart_payment_collection USING btree (id);


--
-- Name: IDX_id_-71069c16; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-71069c16" ON public.order_cart USING btree (id);


--
-- Name: IDX_id_-71518339; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-71518339" ON public.order_promotion USING btree (id);


--
-- Name: IDX_id_-85069d44; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-85069d44" ON public.invite_rbac_role USING btree (id);


--
-- Name: IDX_id_-a9d4a70b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-a9d4a70b" ON public.cart_promotion USING btree (id);


--
-- Name: IDX_id_-e88adb96; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-e88adb96" ON public.location_fulfillment_set USING btree (id);


--
-- Name: IDX_id_-e8d2543e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_-e8d2543e" ON public.order_fulfillment USING btree (id);


--
-- Name: IDX_id_17a262437; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_17a262437" ON public.product_shipping_profile USING btree (id);


--
-- Name: IDX_id_17b4c4e35; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_17b4c4e35" ON public.product_variant_inventory_item USING btree (id);


--
-- Name: IDX_id_1c934dab0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_1c934dab0" ON public.region_payment_provider USING btree (id);


--
-- Name: IDX_id_20b454295; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_20b454295" ON public.product_sales_channel USING btree (id);


--
-- Name: IDX_id_26d06f470; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_26d06f470" ON public.sales_channel_stock_location USING btree (id);


--
-- Name: IDX_id_52b23597; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_52b23597" ON public.product_variant_price_set USING btree (id);


--
-- Name: IDX_id_5cb3a0c0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_5cb3a0c0" ON public.customer_account_holder USING btree (id);


--
-- Name: IDX_id_64ff0c4c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_64ff0c4c" ON public.user_rbac_role USING btree (id);


--
-- Name: IDX_id_ba32fa9c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_ba32fa9c" ON public.shipping_option_price_set USING btree (id);


--
-- Name: IDX_id_f42b9949; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_id_f42b9949" ON public.order_payment_collection USING btree (id);


--
-- Name: IDX_image_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_image_deleted_at" ON public.image USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_image_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_image_product_id" ON public.image USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_inventory_item_deleted_at" ON public.inventory_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_inventory_item_id_17b4c4e35; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_inventory_item_id_17b4c4e35" ON public.product_variant_inventory_item USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_item_sku; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_inventory_item_sku" ON public.inventory_item USING btree (sku) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_level_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_inventory_level_deleted_at" ON public.inventory_level USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_inventory_level_inventory_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_inventory_level_inventory_item_id" ON public.inventory_level USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_level_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_inventory_level_location_id" ON public.inventory_level USING btree (location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_level_location_id_inventory_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_inventory_level_location_id_inventory_item_id" ON public.inventory_level USING btree (inventory_item_id, location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_invite_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_invite_deleted_at" ON public.invite USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_invite_email_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_invite_email_unique" ON public.invite USING btree (email) WHERE (deleted_at IS NULL);


--
-- Name: IDX_invite_id_-85069d44; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_invite_id_-85069d44" ON public.invite_rbac_role USING btree (invite_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_invite_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_invite_token" ON public.invite USING btree (token) WHERE (deleted_at IS NULL);


--
-- Name: IDX_line_item_adjustment_promotion_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_line_item_adjustment_promotion_id" ON public.cart_line_item_adjustment USING btree (promotion_id) WHERE ((deleted_at IS NULL) AND (promotion_id IS NOT NULL));


--
-- Name: IDX_line_item_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_line_item_product_id" ON public.cart_line_item USING btree (product_id) WHERE ((deleted_at IS NULL) AND (product_id IS NOT NULL));


--
-- Name: IDX_line_item_product_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_line_item_product_type_id" ON public.order_line_item USING btree (product_type_id) WHERE ((deleted_at IS NULL) AND (product_type_id IS NOT NULL));


--
-- Name: IDX_line_item_tax_line_tax_rate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_line_item_tax_line_tax_rate_id" ON public.cart_line_item_tax_line USING btree (tax_rate_id) WHERE ((deleted_at IS NULL) AND (tax_rate_id IS NOT NULL));


--
-- Name: IDX_line_item_variant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_line_item_variant_id" ON public.cart_line_item USING btree (variant_id) WHERE ((deleted_at IS NULL) AND (variant_id IS NOT NULL));


--
-- Name: IDX_notification_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_notification_deleted_at" ON public.notification USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_notification_idempotency_key_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_notification_idempotency_key_unique" ON public.notification USING btree (idempotency_key) WHERE (deleted_at IS NULL);


--
-- Name: IDX_notification_provider_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_notification_provider_deleted_at" ON public.notification_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_notification_provider_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_notification_provider_id" ON public.notification USING btree (provider_id);


--
-- Name: IDX_notification_receiver_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_notification_receiver_id" ON public.notification USING btree (receiver_id);


--
-- Name: IDX_option_product_id_title_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_option_product_id_title_unique" ON public.product_option USING btree (product_id, title) WHERE (deleted_at IS NULL);


--
-- Name: IDX_option_value_option_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_option_value_option_id_unique" ON public.product_option_value USING btree (option_id, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_address_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_address_customer_id" ON public.order_address USING btree (customer_id);


--
-- Name: IDX_order_address_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_address_deleted_at" ON public.order_address USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_billing_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_billing_address_id" ON public."order" USING btree (billing_address_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_claim_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_action_claim_id" ON public.order_change_action USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_action_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_action_deleted_at" ON public.order_change_action USING btree (deleted_at);


--
-- Name: IDX_order_change_action_exchange_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_action_exchange_id" ON public.order_change_action USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_action_order_change_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_action_order_change_id" ON public.order_change_action USING btree (order_change_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_action_order_id" ON public.order_change_action USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_ordering; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_action_ordering" ON public.order_change_action USING btree (ordering) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_return_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_action_return_id" ON public.order_change_action USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_change_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_change_type" ON public.order_change USING btree (change_type);


--
-- Name: IDX_order_change_claim_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_claim_id" ON public.order_change USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_deleted_at" ON public.order_change USING btree (deleted_at);


--
-- Name: IDX_order_change_exchange_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_exchange_id" ON public.order_change USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_order_id" ON public.order_change USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_order_id_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_order_id_version" ON public.order_change USING btree (order_id, version);


--
-- Name: IDX_order_change_return_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_return_id" ON public.order_change USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_status" ON public.order_change USING btree (status) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_change_version" ON public.order_change USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_deleted_at" ON public.order_claim USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_display_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_display_id" ON public.order_claim USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_claim_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_item_claim_id" ON public.order_claim_item USING btree (claim_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_item_deleted_at" ON public.order_claim_item USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_image_claim_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_item_image_claim_item_id" ON public.order_claim_item_image USING btree (claim_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_image_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_item_image_deleted_at" ON public.order_claim_item_image USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_claim_item_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_item_item_id" ON public.order_claim_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_order_id" ON public.order_claim USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_return_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_claim_return_id" ON public.order_claim USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_credit_line_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_credit_line_deleted_at" ON public.order_credit_line USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_credit_line_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_credit_line_order_id" ON public.order_credit_line USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_credit_line_order_id_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_credit_line_order_id_version" ON public.order_credit_line USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_currency_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_currency_code" ON public."order" USING btree (currency_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_custom_display_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_order_custom_display_id" ON public."order" USING btree (custom_display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_customer_id" ON public."order" USING btree (customer_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_deleted_at" ON public."order" USING btree (deleted_at);


--
-- Name: IDX_order_display_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_display_id" ON public."order" USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_exchange_deleted_at" ON public.order_exchange USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_display_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_exchange_display_id" ON public.order_exchange USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_exchange_item_deleted_at" ON public.order_exchange_item USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_item_exchange_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_exchange_item_exchange_id" ON public.order_exchange_item USING btree (exchange_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_item_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_exchange_item_item_id" ON public.order_exchange_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_exchange_order_id" ON public.order_exchange USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_return_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_exchange_return_id" ON public.order_exchange USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_id_-71069c16; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_id_-71069c16" ON public.order_cart USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_id_-71518339; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_id_-71518339" ON public.order_promotion USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_id_-e8d2543e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_id_-e8d2543e" ON public.order_fulfillment USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_id_f42b9949; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_id_f42b9949" ON public.order_payment_collection USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_is_draft_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_is_draft_order" ON public."order" USING btree (is_draft_order) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_item_deleted_at" ON public.order_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_item_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_item_item_id" ON public.order_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_item_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_item_order_id" ON public.order_item USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_item_order_id_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_item_order_id_version" ON public.order_item USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_adjustment_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_line_item_adjustment_item_id" ON public.order_line_item_adjustment USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_line_item_product_id" ON public.order_line_item USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_tax_line_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_line_item_tax_line_item_id" ON public.order_line_item_tax_line USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_variant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_line_item_variant_id" ON public.order_line_item USING btree (variant_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_region_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_region_id" ON public."order" USING btree (region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_sales_channel_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_sales_channel_id" ON public."order" USING btree (sales_channel_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_address_id" ON public."order" USING btree (shipping_address_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_claim_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_claim_id" ON public.order_shipping USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_shipping_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_deleted_at" ON public.order_shipping USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_shipping_exchange_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_exchange_id" ON public.order_shipping USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_shipping_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_item_id" ON public.order_shipping USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_method_adjustment_shipping_method_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_method_adjustment_shipping_method_id" ON public.order_shipping_method_adjustment USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_method_shipping_option_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_method_shipping_option_id" ON public.order_shipping_method USING btree (shipping_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_method_tax_line_shipping_method_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_method_tax_line_shipping_method_id" ON public.order_shipping_method_tax_line USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_order_id" ON public.order_shipping USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_order_id_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_order_id_version" ON public.order_shipping USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_return_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_return_id" ON public.order_shipping USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_shipping_shipping_method_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_shipping_shipping_method_id" ON public.order_shipping USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_summary_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_summary_deleted_at" ON public.order_summary USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_summary_order_id_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_summary_order_id_version" ON public.order_summary USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_claim_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_transaction_claim_id" ON public.order_transaction USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_transaction_currency_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_transaction_currency_code" ON public.order_transaction USING btree (currency_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_exchange_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_transaction_exchange_id" ON public.order_transaction USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_transaction_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_transaction_order_id" ON public.order_transaction USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_order_id_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_transaction_order_id_version" ON public.order_transaction USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_reference_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_transaction_reference_id" ON public.order_transaction USING btree (reference_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_return_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_order_transaction_return_id" ON public.order_transaction USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_payment_collection_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_collection_deleted_at" ON public.payment_collection USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_payment_collection_id_-4a39f6c9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_collection_id_-4a39f6c9" ON public.cart_payment_collection USING btree (payment_collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_collection_id_f42b9949; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_collection_id_f42b9949" ON public.order_payment_collection USING btree (payment_collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_deleted_at" ON public.payment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_payment_payment_collection_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_payment_collection_id" ON public.payment USING btree (payment_collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_payment_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_payment_session_id" ON public.payment USING btree (payment_session_id);


--
-- Name: IDX_payment_payment_session_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_payment_payment_session_id_unique" ON public.payment USING btree (payment_session_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_provider_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_provider_deleted_at" ON public.payment_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_provider_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_provider_id" ON public.payment USING btree (provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_provider_id_1c934dab0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_provider_id_1c934dab0" ON public.region_payment_provider USING btree (payment_provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_session_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_session_deleted_at" ON public.payment_session USING btree (deleted_at);


--
-- Name: IDX_payment_session_payment_collection_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_payment_session_payment_collection_id" ON public.payment_session USING btree (payment_collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_currency_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_currency_code" ON public.price USING btree (currency_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_deleted_at" ON public.price USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_list_deleted_at" ON public.price_list USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_id_status_starts_at_ends_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_list_id_status_starts_at_ends_at" ON public.price_list USING btree (id, status, starts_at, ends_at) WHERE ((deleted_at IS NULL) AND (status = 'active'::text));


--
-- Name: IDX_price_list_rule_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_list_rule_attribute" ON public.price_list_rule USING btree (attribute) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_list_rule_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_list_rule_deleted_at" ON public.price_list_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_rule_price_list_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_list_rule_price_list_id" ON public.price_list_rule USING btree (price_list_id) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_rule_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_list_rule_value" ON public.price_list_rule USING gin (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_preference_attribute_value; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_price_preference_attribute_value" ON public.price_preference USING btree (attribute, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_preference_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_preference_deleted_at" ON public.price_preference USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_price_list_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_price_list_id" ON public.price USING btree (price_list_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_price_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_price_set_id" ON public.price USING btree (price_set_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_rule_attribute" ON public.price_rule USING btree (attribute) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_attribute_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_rule_attribute_value" ON public.price_rule USING btree (attribute, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_attribute_value_price_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_rule_attribute_value_price_id" ON public.price_rule USING btree (attribute, value, price_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_rule_deleted_at" ON public.price_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_rule_operator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_rule_operator" ON public.price_rule USING btree (operator);


--
-- Name: IDX_price_rule_operator_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_rule_operator_value" ON public.price_rule USING btree (operator, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_price_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_rule_price_id" ON public.price_rule USING btree (price_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_price_id_attribute_operator_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_price_rule_price_id_attribute_operator_unique" ON public.price_rule USING btree (price_id, attribute, operator) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_set_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_set_deleted_at" ON public.price_set USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_set_id_52b23597; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_set_id_52b23597" ON public.product_variant_price_set USING btree (price_set_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_set_id_ba32fa9c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_price_set_id_ba32fa9c" ON public.shipping_option_price_set USING btree (price_set_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_category_parent_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_category_parent_category_id" ON public.product_category USING btree (parent_category_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_category_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_category_path" ON public.product_category USING btree (mpath) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_collection_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_collection_deleted_at" ON public.product_collection USING btree (deleted_at);


--
-- Name: IDX_product_collection_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_collection_id" ON public.product USING btree (collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_deleted_at" ON public.product USING btree (deleted_at);


--
-- Name: IDX_product_handle_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_product_handle_unique" ON public.product USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_id_17a262437; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_id_17a262437" ON public.product_shipping_profile USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_id_20b454295; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_id_20b454295" ON public.product_sales_channel USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_image_rank; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_image_rank" ON public.image USING btree (rank) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_image_rank_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_image_rank_product_id" ON public.image USING btree (rank, product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_image_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_image_url" ON public.image USING btree (url) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_image_url_rank_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_image_url_rank_product_id" ON public.image USING btree (url, rank, product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_option_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_option_deleted_at" ON public.product_option USING btree (deleted_at);


--
-- Name: IDX_product_option_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_option_product_id" ON public.product_option USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_option_value_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_option_value_deleted_at" ON public.product_option_value USING btree (deleted_at);


--
-- Name: IDX_product_option_value_option_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_option_value_option_id" ON public.product_option_value USING btree (option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_status" ON public.product USING btree (status) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_tag_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_tag_deleted_at" ON public.product_tag USING btree (deleted_at);


--
-- Name: IDX_product_type_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_type_deleted_at" ON public.product_type USING btree (deleted_at);


--
-- Name: IDX_product_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_type_id" ON public.product USING btree (type_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_barcode_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_product_variant_barcode_unique" ON public.product_variant USING btree (barcode) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_variant_deleted_at" ON public.product_variant USING btree (deleted_at);


--
-- Name: IDX_product_variant_ean_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_product_variant_ean_unique" ON public.product_variant USING btree (ean) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_id_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_variant_id_product_id" ON public.product_variant USING btree (id, product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_variant_product_id" ON public.product_variant USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_image_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_variant_product_image_deleted_at" ON public.product_variant_product_image USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_image_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_variant_product_image_image_id" ON public.product_variant_product_image USING btree (image_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_image_variant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_product_variant_product_image_variant_id" ON public.product_variant_product_image USING btree (variant_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_sku_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_product_variant_sku_unique" ON public.product_variant USING btree (sku) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_upc_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_product_variant_upc_unique" ON public.product_variant USING btree (upc) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_application_method_currency_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_application_method_currency_code" ON public.promotion_application_method USING btree (currency_code) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_promotion_application_method_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_application_method_deleted_at" ON public.promotion_application_method USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_application_method_promotion_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_promotion_application_method_promotion_id_unique" ON public.promotion_application_method USING btree (promotion_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_campaign_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_promotion_campaign_budget_campaign_id_unique" ON public.promotion_campaign_budget USING btree (campaign_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_campaign_budget_deleted_at" ON public.promotion_campaign_budget USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_usage_attribute_value_budget_id_u; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_promotion_campaign_budget_usage_attribute_value_budget_id_u" ON public.promotion_campaign_budget_usage USING btree (attribute_value, budget_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_usage_budget_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_campaign_budget_usage_budget_id" ON public.promotion_campaign_budget_usage USING btree (budget_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_usage_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_campaign_budget_usage_deleted_at" ON public.promotion_campaign_budget_usage USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_campaign_identifier_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_promotion_campaign_campaign_identifier_unique" ON public.promotion_campaign USING btree (campaign_identifier) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_campaign_deleted_at" ON public.promotion_campaign USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_campaign_id" ON public.promotion USING btree (campaign_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_deleted_at" ON public.promotion USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_id_-71518339; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_id_-71518339" ON public.order_promotion USING btree (promotion_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_id_-a9d4a70b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_id_-a9d4a70b" ON public.cart_promotion USING btree (promotion_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_is_automatic; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_is_automatic" ON public.promotion USING btree (is_automatic) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_attribute" ON public.promotion_rule USING btree (attribute);


--
-- Name: IDX_promotion_rule_attribute_operator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_attribute_operator" ON public.promotion_rule USING btree (attribute, operator) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_attribute_operator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_attribute_operator_id" ON public.promotion_rule USING btree (operator, attribute, id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_deleted_at" ON public.promotion_rule USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_operator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_operator" ON public.promotion_rule USING btree (operator);


--
-- Name: IDX_promotion_rule_value_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_value_deleted_at" ON public.promotion_rule_value USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_value_promotion_rule_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_value_promotion_rule_id" ON public.promotion_rule_value USING btree (promotion_rule_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_value_rule_id_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_value_rule_id_value" ON public.promotion_rule_value USING btree (promotion_rule_id, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_value_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_rule_value_value" ON public.promotion_rule_value USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_status" ON public.promotion USING btree (status) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_promotion_type" ON public.promotion USING btree (type);


--
-- Name: IDX_provider_identity_auth_identity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_provider_identity_auth_identity_id" ON public.provider_identity USING btree (auth_identity_id);


--
-- Name: IDX_provider_identity_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_provider_identity_deleted_at" ON public.provider_identity USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_provider_identity_provider_entity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_provider_identity_provider_entity_id" ON public.provider_identity USING btree (entity_id, provider);


--
-- Name: IDX_publishable_key_id_-1d67bae40; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_publishable_key_id_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (publishable_key_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_rbac_role_id_-85069d44; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_rbac_role_id_-85069d44" ON public.invite_rbac_role USING btree (rbac_role_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_rbac_role_id_64ff0c4c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_rbac_role_id_64ff0c4c" ON public.user_rbac_role USING btree (rbac_role_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_refund_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_refund_deleted_at" ON public.refund USING btree (deleted_at);


--
-- Name: IDX_refund_payment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_refund_payment_id" ON public.refund USING btree (payment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_refund_reason_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_refund_reason_deleted_at" ON public.refund_reason USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_refund_refund_reason_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_refund_refund_reason_id" ON public.refund USING btree (refund_reason_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_region_country_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_region_country_deleted_at" ON public.region_country USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_region_country_region_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_region_country_region_id" ON public.region_country USING btree (region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_region_country_region_id_iso_2_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_region_country_region_id_iso_2_unique" ON public.region_country USING btree (region_id, iso_2);


--
-- Name: IDX_region_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_region_deleted_at" ON public.region USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_region_id_1c934dab0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_region_id_1c934dab0" ON public.region_payment_provider USING btree (region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_reservation_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_reservation_item_deleted_at" ON public.reservation_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_reservation_item_inventory_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_reservation_item_inventory_item_id" ON public.reservation_item USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_reservation_item_line_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_reservation_item_line_item_id" ON public.reservation_item USING btree (line_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_reservation_item_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_reservation_item_location_id" ON public.reservation_item USING btree (location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_claim_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_claim_id" ON public.return USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_return_display_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_display_id" ON public.return USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_exchange_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_exchange_id" ON public.return USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_return_id_-31ea43a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_id_-31ea43a" ON public.return_fulfillment USING btree (return_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_item_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_item_deleted_at" ON public.return_item USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_item_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_item_item_id" ON public.return_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_item_reason_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_item_reason_id" ON public.return_item USING btree (reason_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_item_return_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_item_return_id" ON public.return_item USING btree (return_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_order_id" ON public.return USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_reason_parent_return_reason_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_reason_parent_return_reason_id" ON public.return_reason USING btree (parent_return_reason_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_reason_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_return_reason_value" ON public.return_reason USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_sales_channel_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_sales_channel_deleted_at" ON public.sales_channel USING btree (deleted_at);


--
-- Name: IDX_sales_channel_id_-1d67bae40; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_sales_channel_id_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (sales_channel_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_sales_channel_id_20b454295; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_sales_channel_id_20b454295" ON public.product_sales_channel USING btree (sales_channel_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_sales_channel_id_26d06f470; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_sales_channel_id_26d06f470" ON public.sales_channel_stock_location USING btree (sales_channel_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_service_zone_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_service_zone_deleted_at" ON public.service_zone USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_service_zone_fulfillment_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_service_zone_fulfillment_set_id" ON public.service_zone USING btree (fulfillment_set_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_service_zone_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_service_zone_name_unique" ON public.service_zone USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_method_adjustment_promotion_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_method_adjustment_promotion_id" ON public.cart_shipping_method_adjustment USING btree (promotion_id) WHERE ((deleted_at IS NULL) AND (promotion_id IS NOT NULL));


--
-- Name: IDX_shipping_method_option_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_method_option_id" ON public.cart_shipping_method USING btree (shipping_option_id) WHERE ((deleted_at IS NULL) AND (shipping_option_id IS NOT NULL));


--
-- Name: IDX_shipping_method_tax_line_tax_rate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_method_tax_line_tax_rate_id" ON public.cart_shipping_method_tax_line USING btree (tax_rate_id) WHERE ((deleted_at IS NULL) AND (tax_rate_id IS NOT NULL));


--
-- Name: IDX_shipping_option_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_deleted_at" ON public.shipping_option USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_option_id_ba32fa9c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_id_ba32fa9c" ON public.shipping_option_price_set USING btree (shipping_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_provider_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_provider_id" ON public.shipping_option USING btree (provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_rule_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_rule_deleted_at" ON public.shipping_option_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_option_rule_shipping_option_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_rule_shipping_option_id" ON public.shipping_option_rule USING btree (shipping_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_service_zone_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_service_zone_id" ON public.shipping_option USING btree (service_zone_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_shipping_option_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_shipping_option_type_id" ON public.shipping_option USING btree (shipping_option_type_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_shipping_profile_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_shipping_profile_id" ON public.shipping_option USING btree (shipping_profile_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_type_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_option_type_deleted_at" ON public.shipping_option_type USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_profile_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_profile_deleted_at" ON public.shipping_profile USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_profile_id_17a262437; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_shipping_profile_id_17a262437" ON public.product_shipping_profile USING btree (shipping_profile_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_profile_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_shipping_profile_name_unique" ON public.shipping_profile USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_single_default_region; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_single_default_region" ON public.tax_rate USING btree (tax_region_id) WHERE ((is_default = true) AND (deleted_at IS NULL));


--
-- Name: IDX_stock_location_address_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_stock_location_address_deleted_at" ON public.stock_location_address USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_stock_location_address_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_stock_location_address_id_unique" ON public.stock_location USING btree (address_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_stock_location_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_stock_location_deleted_at" ON public.stock_location USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_stock_location_id_-1e5992737; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_stock_location_id_-1e5992737" ON public.location_fulfillment_provider USING btree (stock_location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_stock_location_id_-e88adb96; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_stock_location_id_-e88adb96" ON public.location_fulfillment_set USING btree (stock_location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_stock_location_id_26d06f470; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_stock_location_id_26d06f470" ON public.sales_channel_stock_location USING btree (stock_location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_store_currency_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_store_currency_deleted_at" ON public.store_currency USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_store_currency_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_store_currency_store_id" ON public.store_currency USING btree (store_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_store_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_store_deleted_at" ON public.store USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_store_locale_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_store_locale_deleted_at" ON public.store_locale USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_store_locale_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_store_locale_store_id" ON public.store_locale USING btree (store_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tag_value_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_tag_value_unique" ON public.product_tag USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_provider_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_provider_deleted_at" ON public.tax_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_rate_deleted_at" ON public.tax_rate USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_tax_rate_rule_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_rate_rule_deleted_at" ON public.tax_rate_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_tax_rate_rule_reference_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_rate_rule_reference_id" ON public.tax_rate_rule USING btree (reference_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_rule_tax_rate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_rate_rule_tax_rate_id" ON public.tax_rate_rule USING btree (tax_rate_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_rule_unique_rate_reference; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_tax_rate_rule_unique_rate_reference" ON public.tax_rate_rule USING btree (tax_rate_id, reference_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_tax_region_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_rate_tax_region_id" ON public.tax_rate USING btree (tax_region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_region_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_region_deleted_at" ON public.tax_region USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_tax_region_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_region_parent_id" ON public.tax_region USING btree (parent_id);


--
-- Name: IDX_tax_region_provider_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_tax_region_provider_id" ON public.tax_region USING btree (provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_region_unique_country_nullable_province; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_tax_region_unique_country_nullable_province" ON public.tax_region USING btree (country_code) WHERE ((province_code IS NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_tax_region_unique_country_province; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_tax_region_unique_country_province" ON public.tax_region USING btree (country_code, province_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_type_value_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_type_value_unique" ON public.product_type USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_unique_promotion_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_unique_promotion_code" ON public.promotion USING btree (code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_user_deleted_at" ON public."user" USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_user_email_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_user_email_unique" ON public."user" USING btree (email) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_id_64ff0c4c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_user_id_64ff0c4c" ON public.user_rbac_role USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_preference_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_user_preference_deleted_at" ON public.user_preference USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_preference_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_user_preference_user_id" ON public.user_preference USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_preference_user_id_key_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_user_preference_user_id_key_unique" ON public.user_preference USING btree (user_id, key) WHERE (deleted_at IS NULL);


--
-- Name: IDX_variant_id_17b4c4e35; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_variant_id_17b4c4e35" ON public.product_variant_inventory_item USING btree (variant_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_variant_id_52b23597; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_variant_id_52b23597" ON public.product_variant_price_set USING btree (variant_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_view_configuration_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_view_configuration_deleted_at" ON public.view_configuration USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_view_configuration_entity_is_system_default; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_view_configuration_entity_is_system_default" ON public.view_configuration USING btree (entity, is_system_default) WHERE (deleted_at IS NULL);


--
-- Name: IDX_view_configuration_entity_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_view_configuration_entity_user_id" ON public.view_configuration USING btree (entity, user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_view_configuration_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_view_configuration_user_id" ON public.view_configuration USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_deleted_at" ON public.workflow_execution USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_id" ON public.workflow_execution USING btree (id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_retention_time_updated_at_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_retention_time_updated_at_state" ON public.workflow_execution USING btree (retention_time, updated_at, state) WHERE ((deleted_at IS NULL) AND (retention_time IS NOT NULL));


--
-- Name: IDX_workflow_execution_run_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_run_id" ON public.workflow_execution USING btree (run_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_state" ON public.workflow_execution USING btree (state) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_state_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_state_updated_at" ON public.workflow_execution USING btree (state, updated_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_transaction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_transaction_id" ON public.workflow_execution USING btree (transaction_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_updated_at_retention_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_updated_at_retention_time" ON public.workflow_execution USING btree (updated_at, retention_time) WHERE ((deleted_at IS NULL) AND (retention_time IS NOT NULL) AND ((state)::text = ANY ((ARRAY['done'::character varying, 'failed'::character varying, 'reverted'::character varying])::text[])));


--
-- Name: IDX_workflow_execution_workflow_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_workflow_id" ON public.workflow_execution USING btree (workflow_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_workflow_id_transaction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_execution_workflow_id_transaction_id" ON public.workflow_execution USING btree (workflow_id, transaction_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_workflow_id_transaction_id_run_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_workflow_execution_workflow_id_transaction_id_run_id_unique" ON public.workflow_execution USING btree (workflow_id, transaction_id, run_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_script_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_script_name_unique ON public.script_migrations USING btree (script_name);


--
-- Name: tax_rate_rule FK_tax_rate_rule_tax_rate_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_rate_rule
    ADD CONSTRAINT "FK_tax_rate_rule_tax_rate_id" FOREIGN KEY (tax_rate_id) REFERENCES public.tax_rate(id) ON DELETE CASCADE;


--
-- Name: tax_rate FK_tax_rate_tax_region_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "FK_tax_rate_tax_region_id" FOREIGN KEY (tax_region_id) REFERENCES public.tax_region(id) ON DELETE CASCADE;


--
-- Name: tax_region FK_tax_region_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_region
    ADD CONSTRAINT "FK_tax_region_parent_id" FOREIGN KEY (parent_id) REFERENCES public.tax_region(id) ON DELETE CASCADE;


--
-- Name: tax_region FK_tax_region_provider_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_region
    ADD CONSTRAINT "FK_tax_region_provider_id" FOREIGN KEY (provider_id) REFERENCES public.tax_provider(id) ON DELETE SET NULL;


--
-- Name: application_method_buy_rules application_method_buy_rules_application_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_method_buy_rules
    ADD CONSTRAINT application_method_buy_rules_application_method_id_foreign FOREIGN KEY (application_method_id) REFERENCES public.promotion_application_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: application_method_buy_rules application_method_buy_rules_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_method_buy_rules
    ADD CONSTRAINT application_method_buy_rules_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: application_method_target_rules application_method_target_rules_application_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_method_target_rules
    ADD CONSTRAINT application_method_target_rules_application_method_id_foreign FOREIGN KEY (application_method_id) REFERENCES public.promotion_application_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: application_method_target_rules application_method_target_rules_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_method_target_rules
    ADD CONSTRAINT application_method_target_rules_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: capture capture_payment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.capture
    ADD CONSTRAINT capture_payment_id_foreign FOREIGN KEY (payment_id) REFERENCES public.payment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart cart_billing_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_billing_address_id_foreign FOREIGN KEY (billing_address_id) REFERENCES public.cart_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cart_line_item_adjustment cart_line_item_adjustment_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_line_item_adjustment
    ADD CONSTRAINT cart_line_item_adjustment_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.cart_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_line_item cart_line_item_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_line_item
    ADD CONSTRAINT cart_line_item_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_line_item_tax_line cart_line_item_tax_line_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_line_item_tax_line
    ADD CONSTRAINT cart_line_item_tax_line_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.cart_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart cart_shipping_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_shipping_address_id_foreign FOREIGN KEY (shipping_address_id) REFERENCES public.cart_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cart_shipping_method_adjustment cart_shipping_method_adjustment_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_shipping_method_adjustment
    ADD CONSTRAINT cart_shipping_method_adjustment_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.cart_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_shipping_method cart_shipping_method_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_shipping_method
    ADD CONSTRAINT cart_shipping_method_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_shipping_method_tax_line cart_shipping_method_tax_line_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_shipping_method_tax_line
    ADD CONSTRAINT cart_shipping_method_tax_line_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.cart_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: credit_line credit_line_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_line
    ADD CONSTRAINT credit_line_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON UPDATE CASCADE;


--
-- Name: customer_address customer_address_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_group_customer customer_group_customer_customer_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group_customer
    ADD CONSTRAINT customer_group_customer_customer_group_id_foreign FOREIGN KEY (customer_group_id) REFERENCES public.customer_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_group_customer customer_group_customer_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group_customer
    ADD CONSTRAINT customer_group_customer_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fulfillment fulfillment_delivery_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_delivery_address_id_foreign FOREIGN KEY (delivery_address_id) REFERENCES public.fulfillment_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fulfillment_item fulfillment_item_fulfillment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment_item
    ADD CONSTRAINT fulfillment_item_fulfillment_id_foreign FOREIGN KEY (fulfillment_id) REFERENCES public.fulfillment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fulfillment_label fulfillment_label_fulfillment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment_label
    ADD CONSTRAINT fulfillment_label_fulfillment_id_foreign FOREIGN KEY (fulfillment_id) REFERENCES public.fulfillment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fulfillment fulfillment_provider_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_provider_id_foreign FOREIGN KEY (provider_id) REFERENCES public.fulfillment_provider(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fulfillment fulfillment_shipping_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_shipping_option_id_foreign FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: geo_zone geo_zone_service_zone_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geo_zone
    ADD CONSTRAINT geo_zone_service_zone_id_foreign FOREIGN KEY (service_zone_id) REFERENCES public.service_zone(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: image image_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_level inventory_level_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_level
    ADD CONSTRAINT inventory_level_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notification notification_provider_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_provider_id_foreign FOREIGN KEY (provider_id) REFERENCES public.notification_provider(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order order_billing_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_billing_address_id_foreign FOREIGN KEY (billing_address_id) REFERENCES public.order_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_change_action order_change_action_order_change_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_change_action
    ADD CONSTRAINT order_change_action_order_change_id_foreign FOREIGN KEY (order_change_id) REFERENCES public.order_change(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_change order_change_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_change
    ADD CONSTRAINT order_change_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_credit_line order_credit_line_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_credit_line
    ADD CONSTRAINT order_credit_line_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_item order_item_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.order_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_item order_item_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_line_item_adjustment order_line_item_adjustment_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_line_item_adjustment
    ADD CONSTRAINT order_line_item_adjustment_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.order_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_line_item_tax_line order_line_item_tax_line_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_line_item_tax_line
    ADD CONSTRAINT order_line_item_tax_line_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.order_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_line_item order_line_item_totals_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_line_item
    ADD CONSTRAINT order_line_item_totals_id_foreign FOREIGN KEY (totals_id) REFERENCES public.order_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order order_shipping_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_shipping_address_id_foreign FOREIGN KEY (shipping_address_id) REFERENCES public.order_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_shipping_method_adjustment order_shipping_method_adjustment_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipping_method_adjustment
    ADD CONSTRAINT order_shipping_method_adjustment_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.order_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_shipping_method_tax_line order_shipping_method_tax_line_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipping_method_tax_line
    ADD CONSTRAINT order_shipping_method_tax_line_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.order_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_shipping order_shipping_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipping
    ADD CONSTRAINT order_shipping_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_summary order_summary_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_summary
    ADD CONSTRAINT order_summary_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_transaction order_transaction_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_transaction
    ADD CONSTRAINT order_transaction_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_collection_payment_providers payment_collection_payment_providers_payment_col_aa276_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_collection_payment_providers
    ADD CONSTRAINT payment_collection_payment_providers_payment_col_aa276_foreign FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_collection_payment_providers payment_collection_payment_providers_payment_pro_2d555_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_collection_payment_providers
    ADD CONSTRAINT payment_collection_payment_providers_payment_pro_2d555_foreign FOREIGN KEY (payment_provider_id) REFERENCES public.payment_provider(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment payment_payment_collection_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_payment_collection_id_foreign FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_session payment_session_payment_collection_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_session
    ADD CONSTRAINT payment_session_payment_collection_id_foreign FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price_list_rule price_list_rule_price_list_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_list_rule
    ADD CONSTRAINT price_list_rule_price_list_id_foreign FOREIGN KEY (price_list_id) REFERENCES public.price_list(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price price_price_list_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_price_list_id_foreign FOREIGN KEY (price_list_id) REFERENCES public.price_list(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price price_price_set_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_price_set_id_foreign FOREIGN KEY (price_set_id) REFERENCES public.price_set(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price_rule price_rule_price_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_rule
    ADD CONSTRAINT price_rule_price_id_foreign FOREIGN KEY (price_id) REFERENCES public.price(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category product_category_parent_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_parent_category_id_foreign FOREIGN KEY (parent_category_id) REFERENCES public.product_category(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category_product product_category_product_product_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT product_category_product_product_category_id_foreign FOREIGN KEY (product_category_id) REFERENCES public.product_category(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category_product product_category_product_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT product_category_product_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product product_collection_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_collection_id_foreign FOREIGN KEY (collection_id) REFERENCES public.product_collection(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: product_option product_option_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_option
    ADD CONSTRAINT product_option_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_option_value product_option_value_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_option_value
    ADD CONSTRAINT product_option_value_option_id_foreign FOREIGN KEY (option_id) REFERENCES public.product_option(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_tags product_tags_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_tags product_tags_product_tag_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_product_tag_id_foreign FOREIGN KEY (product_tag_id) REFERENCES public.product_tag(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product product_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_type_id_foreign FOREIGN KEY (type_id) REFERENCES public.product_type(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: product_variant_option product_variant_option_option_value_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_option
    ADD CONSTRAINT product_variant_option_option_value_id_foreign FOREIGN KEY (option_value_id) REFERENCES public.product_option_value(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant_option product_variant_option_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_option
    ADD CONSTRAINT product_variant_option_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant product_variant_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT product_variant_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant_product_image product_variant_product_image_image_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_product_image
    ADD CONSTRAINT product_variant_product_image_image_id_foreign FOREIGN KEY (image_id) REFERENCES public.image(id) ON DELETE CASCADE;


--
-- Name: promotion_application_method promotion_application_method_promotion_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_application_method
    ADD CONSTRAINT promotion_application_method_promotion_id_foreign FOREIGN KEY (promotion_id) REFERENCES public.promotion(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_campaign_budget promotion_campaign_budget_campaign_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_campaign_budget
    ADD CONSTRAINT promotion_campaign_budget_campaign_id_foreign FOREIGN KEY (campaign_id) REFERENCES public.promotion_campaign(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_campaign_budget_usage promotion_campaign_budget_usage_budget_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_campaign_budget_usage
    ADD CONSTRAINT promotion_campaign_budget_usage_budget_id_foreign FOREIGN KEY (budget_id) REFERENCES public.promotion_campaign_budget(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion promotion_campaign_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT promotion_campaign_id_foreign FOREIGN KEY (campaign_id) REFERENCES public.promotion_campaign(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: promotion_promotion_rule promotion_promotion_rule_promotion_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_promotion_rule
    ADD CONSTRAINT promotion_promotion_rule_promotion_id_foreign FOREIGN KEY (promotion_id) REFERENCES public.promotion(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_promotion_rule promotion_promotion_rule_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_promotion_rule
    ADD CONSTRAINT promotion_promotion_rule_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_rule_value promotion_rule_value_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion_rule_value
    ADD CONSTRAINT promotion_rule_value_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: provider_identity provider_identity_auth_identity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_identity
    ADD CONSTRAINT provider_identity_auth_identity_id_foreign FOREIGN KEY (auth_identity_id) REFERENCES public.auth_identity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: refund refund_payment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_payment_id_foreign FOREIGN KEY (payment_id) REFERENCES public.payment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region_country region_country_region_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region_country
    ADD CONSTRAINT region_country_region_id_foreign FOREIGN KEY (region_id) REFERENCES public.region(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reservation_item reservation_item_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservation_item
    ADD CONSTRAINT reservation_item_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: return_reason return_reason_parent_return_reason_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.return_reason
    ADD CONSTRAINT return_reason_parent_return_reason_id_foreign FOREIGN KEY (parent_return_reason_id) REFERENCES public.return_reason(id);


--
-- Name: service_zone service_zone_fulfillment_set_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_zone
    ADD CONSTRAINT service_zone_fulfillment_set_id_foreign FOREIGN KEY (fulfillment_set_id) REFERENCES public.fulfillment_set(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option shipping_option_provider_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_provider_id_foreign FOREIGN KEY (provider_id) REFERENCES public.fulfillment_provider(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: shipping_option_rule shipping_option_rule_shipping_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option_rule
    ADD CONSTRAINT shipping_option_rule_shipping_option_id_foreign FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option shipping_option_service_zone_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_service_zone_id_foreign FOREIGN KEY (service_zone_id) REFERENCES public.service_zone(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option shipping_option_shipping_option_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_shipping_option_type_id_foreign FOREIGN KEY (shipping_option_type_id) REFERENCES public.shipping_option_type(id) ON UPDATE CASCADE;


--
-- Name: shipping_option shipping_option_shipping_profile_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_shipping_profile_id_foreign FOREIGN KEY (shipping_profile_id) REFERENCES public.shipping_profile(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: stock_location stock_location_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_location
    ADD CONSTRAINT stock_location_address_id_foreign FOREIGN KEY (address_id) REFERENCES public.stock_location_address(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_currency store_currency_store_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_currency
    ADD CONSTRAINT store_currency_store_id_foreign FOREIGN KEY (store_id) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_locale store_locale_store_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_locale
    ADD CONSTRAINT store_locale_store_id_foreign FOREIGN KEY (store_id) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict erxDdC9Bnc2o0gcpcWluFx0Z4RfNccb6YDeo9MZJuu9TslkbBxGzNB74HZZGDVE


<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/classes/ShopifyWebhook.php';

$post = file_get_contents('php://input');
error_log("RECEIVED DATA: ".$post);

if (!ShopifyWebhook::verify($_SERVER['HTTP_X_SHOPIFY_HMAC_SHA256'], WEBHOOK_SIGNATURE, $post))
  die;

ShopifyWebhook::connect(DBHOST, DBUSER, DBPASS, DBNAME);
ShopifyWebhook::process(json_decode($post));

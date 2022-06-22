<?php

class ShopifyWebhook {
  static $db;

  static function verify($signature, $secret, $data) {
    $calculated_hmac = base64_encode(hash_hmac('sha256', $data, $secret, true));
    return hash_equals($signature, $calculated_hmac);
  }

  static function connect($host, $user, $pwd, $name) {
    $string = 'mysql:host=' . $host . ';dbname=' . $name . ';charset=utf8';
    ShopifyWebhook::$db = new PDO($string, $user, $pwd, array(PDO::ATTR_PERSISTENT => false));
  }

  static function process($body) {
    $data = array(
      'id' => $body->id,
      'createdAt' => $body->created_at,
      'number' => $body->number,
      'total' => $body->total_price,
      'subtotal' => $body->subtotal_price,
      'tax' => $body->total_tax,
      'discounts' => $body->total_discounts,
      'shipping' => static::shipping($body->shipping_lines),
      'firstName' => $body->billing_address->first_name,
      'lastName' => $body->billing_address->last_name,
      'address' => trim($body->billing_address->address1 . ' ' . $body->billing_address->address2),
      'phone' => $body->billing_address->phone,
      'city' => $body->billing_address->city,
      'province' => $body->billing_address->province,
      'country' => $body->billing_address->country,
      'email' => $body->customer->email,
      'dni' => static::dni($body->note_attributes)
    );

    return ShopifyWebhook::insertOrder($data);
  }

  static function shipping($lines) {
    return array_reduce($lines, function ($carry, $item) {
      return $carry + $item->price;
    }, 0);
  }

  static function dni($attributes) {
    $attributes = array_filter($attributes, function ($att) {
      return strtolower($att->name) === 'dni';
    });

    if (count($attributes))
      return current($attributes)->value;
    else
      return null;
  }

  static function insertOrder($data) {
    $fields = array_keys($data);
    $placeholders = array_fill(0, count($fields), '?');

    $query = 'INSERT INTO `shopify_orders` (' . implode(',', $fields) . ') VALUES (' . implode(',', $placeholders) . ')';
    return static::$db->prepare($query)->execute(array_values($data));
  }
}

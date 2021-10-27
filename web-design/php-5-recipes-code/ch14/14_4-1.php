<?php
// Example 14-4-1.php
$root = new DomDocument('1.0', 'iso-8859-1');
$html = $root->createElement("html");

$body = $root->createElement("body");
$table = $root->createElement("table");

$w = $root->createAttribute("width");
$table->appendChild($w);
$h = $root->createAttribute("height");
$table->appendChild($h);
$b = $root->createAttribute("border");
$table->appendChild($b);
$table->setAttribute("width", "100%");
$table->setAttribute("height", "50%");
$table->setAttribute("border", "1");

$row = $root->createElement("tr");

$cell = $root->createElement("td", "value1");
$row->appendChild($cell);
$cell = $root->createElement("td", "value2");
$row->appendChild($cell);

$table->appendChild($row);
$body->appendChild($table);
$html->appendChild($body);

$root->appendChild($html);

echo $root->saveHTML();
?>

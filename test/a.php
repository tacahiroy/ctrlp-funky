<?php
/**
 * sample file for ctrlp-funky
 *
 * PHP 5
 *
 */

require 'foo.php';
require('bar.php');
require_once 'baz.php';
require_once('boo.php');
include 'foo.php';
include('bar.php');
include_once 'baz.php';
include_once('boo.php');

class Klass extends Foo {

  /**
   * public variable
   */
	public $public_var = null;

  /**
   * protected variable
   */
  protected $_protected_var = array(
    'foo' => 'bar'
  );

  /**
   * initialization
   *
   * @return void
   */
  public function initialize() {
    $this->public_var = 'init';
  }

  /**
   * public func with args
   *
   * @return void
   */
  public function foo($arg1, $arg2) {
    return null;
  }

  /**
   * protected func
   *
   * @return void
   */
  protected function _bar() {
    return false;
  }

  /**
   * protected func with args
   *
   * @return void
   */
  protected function _bar2($arg1, $arg2) {
    return false;
  }
}

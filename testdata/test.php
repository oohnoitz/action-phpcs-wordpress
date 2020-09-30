<?php
/**
 * Comment
 */

echo 'Hello World!';

$a = function_call();


class TestFile {
  /**
   * Constant
   *
   * @var bool
   */
  const A = false;

  /**
   * Property
   *
   * @var int
   */
  public $a = 123;

  /**
   * Function
   *
   * @param int       $param_a Testing
   * @param bool|null $param_b Testing
   *
   * @return void
   */
  public function testing( $param_a, ?bool $param_b = false): void {
    if ($param_b) {
      echo 'Testing'
    }

    echo $param_a;
  }
}

<?php
/**
 * Date: 25/11/13
 * Time: 15:42
 */

namespace Muzar\ScraperBundle\Tests\LinkIterator;

use Muzar\ScraperBundle\LinkIterator\Hudebnibazar;

class HudebnibazarTest extends \PHPUnit_Framework_TestCase
{

	protected function setUp()
	{
		parent::setUp();
	}


	public function testIsIterator()
	{
		$it = new Hudebnibazar(__DIR__ . '/rss.xml');
		$this->assertInstanceOf('\Iterator', $it);
	}

	public function testCount()
	{
		$it = new Hudebnibazar(__DIR__ . '/rss.xml');
		$this->assertCount(50, iterator_to_array($it));
	}

	public function testItems()
	{
		$it = new Hudebnibazar(__DIR__ . '/rss.xml');
		foreach($it as $link => $pubDate)
		{
			$this->assertInstanceOf('\DateTime', $pubDate);
			$this->assertNotEmpty(filter_var($link, FILTER_VALIDATE_URL));
		}
	}

}
 
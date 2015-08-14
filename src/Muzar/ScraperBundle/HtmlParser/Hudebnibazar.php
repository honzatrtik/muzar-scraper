<?php
/**
 * Date: 25/11/13
 * Time: 15:41
 */

namespace Muzar\ScraperBundle\HtmlParser;

use Symfony\Component\DomCrawler\Crawler;

class Hudebnibazar implements HtmlParserInterface
{

	public function parse(Crawler $crawler)
	{

		$params = array();

		$node = $crawler->filter('input[name="nabpop"]:checked');
		if ($node->count())
		{
			$params['type'] = trim($node->first()->attr('value'));
		}

		$node = $crawler->filter('select[name="kategorie"] option:selected');
		if ($node->count())
		{
			$params['categoryId'] = trim($node->first()->attr('value'));
			$params['category'] = trim($node->first()->text());
		}

		$node = $crawler->filter('select[name="kraj"] option:selected');
		if ($node->count())
		{
			$params['regionId'] = trim($node->first()->attr('value'));
			$params['region'] = trim($node->first()->text());
		}


		$node = $crawler->filter('input[name="nazev"]');
		if ($node->count())
		{
			$params['name'] = trim($node->first()->attr('value'));
		}

		$node = $crawler->filter('input[name="cena"]');
		if ($node->count())
		{
			$params['price'] = trim($node->first()->attr('value'));
		}

		$node = $crawler->filter('select[name="mena"] option:selected');
		if ($node->count())
		{
			$params['currency'] = trim($node->first()->attr('value'));
		}

		// email
		$node = $crawler->filterXPath('//*[@id = "bflm"]/following-sibling::script');
		if ($node->count())
		{
			$text = $node->text();
			if (preg_match('/\("bflm"\)\.value\=\'(.*)\'(.*)\'(.*)\'\;/', $text, $matches))
			{
				$params['email'] = $matches[1] . '@' . $matches[3];
			}
		}

		// telefon
		$node = $crawler->filter('input[name="telefon"]');
		if ($node->count())
		{
			$params['phone'] = trim($node->first()->attr('value'));
		}

		// telefon
		$node = $crawler->filter('textarea[name="prispevek"]');
		if ($node->count())
		{
			$params['text'] = trim($node->first()->text());
		}

		// Pocet obrazku
		$as = $crawler->filter('.InzeratObrd a');
		$imageUrls = array();
		$as->each(function(Crawler $a) use (&$imageUrls) {
			$imageUrls[] = $a->attr('href');
		});

		$params['images'] = trim($as->count());
		$params['imageUrls'] = $imageUrls;

		return $params;

	}

} 
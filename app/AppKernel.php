<?php

use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;

class AppKernel extends Kernel
{
    public function registerBundles()
    {

		$bundles = array(
            new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
            new Symfony\Bundle\MonologBundle\MonologBundle(),
            new Symfony\Bundle\SwiftmailerBundle\SwiftmailerBundle(),
            new Doctrine\Bundle\DoctrineBundle\DoctrineBundle(),
        );

		if (php_sapi_name() === 'cli')
		{
			$bundles[] = new Muzar\ScraperBundle\MuzarScraperBundle();
		}

		if (in_array($this->getEnvironment(), array('dev', 'test'))) {
        }

        return $bundles;
    }

	public function registerContainerConfiguration(LoaderInterface $loader)
	{
		$loader->load(__DIR__.'/config/'.$this->getEnvironment().'/config.yml');
	}
}

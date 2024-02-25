<?php

namespace App\DataFixtures;

use App\Entity\Todo;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $count = 10;
        for ($i = 0; $i < $count; $i++) {
            $todo = new Todo();
            $todo->setTitle('Ma Todo ' . $i);
            $todo->setIsDone(rand(0, 1));
            $manager->persist($todo);
        }
        $manager->flush();
    }
}

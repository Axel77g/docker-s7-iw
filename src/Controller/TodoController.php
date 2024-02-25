<?php

namespace App\Controller;

use App\Entity\Todo;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class TodoController extends AbstractController
{
    #[Route('/todo', name: 'app_todo')]
    public function index(EntityManagerInterface $entityManager)
    {
        $todos = $entityManager->getRepository(Todo::class)->findAll();
        return $this->render('index.todo.html.twig', [
            'todos' => $todos,
        ]);
    }
}

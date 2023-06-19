<?php

use App\Controllers\User;
use PHPUnit\Framework\TestCase;

class UserControllerTest extends TestCase
{
    protected $userController;

    protected function setUp(): void
    {
        $mockRouter = $this->createMock(\Core\Router::class);
        $this->userController = new \App\Controllers\User($mockRouter);
    }

    public function testLoginAction()
    {
        // Prepare data
        $_POST['submit'] = true;
        $_POST['email'] = 'test@example.com';
        $_POST['password'] = 'password';

        $this->userController->loginAction();

        $this->assertEquals($_SESSION['user']['email'], $_POST['email']);
        $this->assertTrue(isset($_SESSION['user']['id']));

    }

    public function testRegisterAction()
    {
        // Prepare data
        $_POST['submit'] = true;
        $_POST['email'] = 'test@example.com';
        $_POST['username'] = 'username';
        $_POST['password'] = 'password';
        $_POST['password-check'] = 'password';

        $this->userController->registerAction();

        $this->assertEquals($_SESSION['user']['email'], $_POST['email']);
        $this->assertTrue(isset($_SESSION['user']['id']));

    }

    public function testLogoutAction()
    {
        $this->userController->logoutAction();
        $this->assertFalse(isset($_SESSION['user']));
    }
}

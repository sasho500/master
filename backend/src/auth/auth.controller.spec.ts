import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { ThrottlerGuard } from '@nestjs/throttler';
import { APP_GUARD } from '@nestjs/core';
import { HttpStatus } from '@nestjs/common';
describe('AuthController', () => {
  let authController: AuthController;
  let authService: AuthService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [
        AuthService,
        {
          provide: APP_GUARD,
          useClass: ThrottlerGuard,
        },
      ],
    }).compile();

    authController = module.get<AuthController>(AuthController);
    authService = module.get<AuthService>(AuthService);
  });

  describe('login', () => {
    it('should return a token for valid credentials', async () => {
      const result = 'token';
      jest
        .spyOn(authService, 'validateUser')
        .mockImplementation(() => Promise.resolve(result));

      const req = { body: { username: 'test', password: 'test' } };
      const res = {
        cookie: jest.fn(),
        json: jest.fn().mockReturnValue({ token: result }),
      };

      await authController.login(req as any, res as any);
      expect(res.cookie).toHaveBeenCalled();
      expect(res.json).toHaveBeenCalledWith({ token: result });
    });

    it('should return unauthorized for invalid credentials', async () => {
      jest
        .spyOn(authService, 'validateUser')
        .mockImplementation(() => Promise.resolve(null));

      const req = { body: { username: 'test', password: 'wrong' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn().mockReturnValue({ message: 'Authentication failed' }),
      };

      await authController.login(req as any, res as any);
      expect(res.status).toHaveBeenCalledWith(HttpStatus.UNAUTHORIZED);
      expect(res.json).toHaveBeenCalledWith({
        message: 'Authentication failed',
      });
    });
  });

  describe('register', () => {
    it('should return a user and token for successful registration', async () => {
      const user = { id: 1, username: 'test' };
      const token = 'token';
      jest
        .spyOn(authService, 'registerAndLogin')
        .mockImplementation(() => Promise.resolve({ user, token }));

      const req = { body: { username: 'test', password: 'test' } };
      const res = {
        cookie: jest.fn(),
        status: jest.fn().mockReturnThis(),
        json: jest.fn().mockReturnValue({ user, token }),
      };

      await authController.register(req as any, res as any);
      expect(res.cookie).toHaveBeenCalled();
      expect(res.status).toHaveBeenCalledWith(HttpStatus.CREATED);
      expect(res.json).toHaveBeenCalledWith({ user, token });
    });

    it('should return bad request for registration failure', async () => {
      const error = new Error('Username already exists');
      jest.spyOn(authService, 'registerAndLogin').mockImplementation(() => {
        throw error;
      });

      const req = { body: { username: 'test', password: 'test' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn().mockReturnValue({
          message: 'User could not be created',
          error: error.message,
        }),
      };

      await authController.register(req as any, res as any);
      expect(res.status).toHaveBeenCalledWith(HttpStatus.BAD_REQUEST);
      expect(res.json).toHaveBeenCalledWith({
        message: 'User could not be created',
        error: error.message,
      });
    });
  });
});

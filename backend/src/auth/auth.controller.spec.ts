import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';

describe('AuthController', () => {
  let controller: AuthController;
  let service: Partial<AuthService>;

  beforeEach(async () => {
    service = {
      validateUser: jest.fn().mockResolvedValue('test_token'),
      createUser: jest.fn().mockResolvedValue({ key: 'test_key' }),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [{ provide: AuthService, useValue: service }],
    }).compile();

    controller = module.get<AuthController>(AuthController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should login user and return a token', async () => {
    const req = { body: { username: 'test', password: 'test' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await controller.login(req, res);

    expect(res.status).not.toHaveBeenCalled();
    expect(res.json).toHaveBeenCalledWith({ token: 'test_token' });
  });

  it('should register a user', async () => {
    const req = { body: { username: 'test', password: 'test' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
      cookie: jest.fn(),
    };

    await controller.register(req, res);

    expect(res.status).toHaveBeenCalledWith(201);
    expect(res.json).toHaveBeenCalledWith({
      user: { key: 'test_key' },
      token: 'test_token',
    });
  });
});

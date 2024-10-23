import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { UsersService } from '../users/users.service';

describe('AuthService', () => {
  let service: AuthService;
  let usersService: Partial<UsersService>;

  beforeEach(async () => {
    usersService = {
      validateLogin: jest.fn().mockResolvedValue({ key: 'test_key' }),
      create: jest.fn().mockResolvedValue({ key: 'test_key' }),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        { provide: UsersService, useValue: usersService },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should validate user and return a token', async () => {
    const token = await service.validateUser({
      username: 'test',
      password: 'test',
    });
    expect(token).toBeDefined();
    expect(typeof token).toBe('string');
  });

  it('should create a user', async () => {
    const user = await service.createUser({
      username: 'test',
      password: 'test',
    });
    expect(user).toBeDefined();
    expect(user.key).toBe('test_key');
  });
});

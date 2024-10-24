import { Injectable, Logger, UnauthorizedException } from '@nestjs/common';
import * as jwt from 'jsonwebtoken';
import * as bcrypt from 'bcrypt';
import { UsersService } from '../users/users.service';
import { User } from '../users/user.entity';

@Injectable()
export class AuthService {
  private readonly jwtSecret: string;
  private readonly logger = new Logger(AuthService.name);

  constructor(private usersService: UsersService) {
    this.jwtSecret = process.env.JWT_SECRET || 'defaultSecretKey';
  }

  async validateUser(credentials): Promise<string> {
    this.logger.log('Validating user');
    const user = await this.usersService.validateLogin(credentials.username, credentials.password);
    
    if (user) {
      this.logger.log('User validated successfully');
      return jwt.sign({ key: user.key, role: user.role }, this.jwtSecret, { expiresIn: '1h' });

    }
    this.logger.log('User validation failed');
    return null;
}

  async createUser(data): Promise<User> {
    return this.usersService.create(data);
  }

  async registerAndLogin(data): Promise<{ user: User; token: string }> {
    const existingUser = await this.usersService.findByUsername(data.username);
    if (existingUser) {
      throw new Error('Username already exists');
    }

    const user = await this.createUser(data);
    const token = await this.validateUser({ username: data.username, password: data.password });
    return { user, token };
  }
  decodeToken(token): any {
    this.logger.debug('Decoding token:', token);
    try {
      return jwt.verify(token, this.jwtSecret);
    } catch (err) {
      this.logger.error('Invalid token:', err.message);
      throw new UnauthorizedException('Invalid token');
    }
  }
}
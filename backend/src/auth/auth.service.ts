import { Injectable } from '@nestjs/common';
import * as jwt from 'jsonwebtoken';
import { UsersService } from '../users/users.service';
import { User } from '../users/user.entity';

@Injectable()
export class AuthService {
  constructor(private usersService: UsersService) {}

  async validateUser(credentials): Promise<string> {
    const user = await this.usersService.validateLogin(credentials.username, credentials.password);
    if (user) {
      return jwt.sign({ username: user.username }, 'secretKey', {
        expiresIn: '1h',
      });
    }
    return null;
  }

  async createUser(data): Promise<User> {
    return this.usersService.create(data);
  }

  decodeToken(token): any {
    return jwt.verify(token, 'secretKey');
  }
}
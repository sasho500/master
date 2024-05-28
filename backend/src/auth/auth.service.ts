import { Injectable } from '@nestjs/common';
import * as jwt from 'jsonwebtoken';
import * as bcrypt from 'bcrypt';
import { UsersService } from '../users/users.service';
import { User } from '../users/user.entity';

@Injectable()
export class AuthService {
  private readonly jwtSecret: string;

  constructor(private usersService: UsersService) {
    this.jwtSecret = process.env.JWT_SECRET || 'defaultSecretKey';
  }

  async validateUser(credentials): Promise<string> {
    const user = await this.usersService.validateLogin(credentials.username, credentials.password);
    if (user) {
      return jwt.sign({ key: user.key }, this.jwtSecret, { expiresIn: '1h' });
    }
    return null;
  }

  async createUser(data): Promise<User> {
    const salt = await bcrypt.genSalt();
    data.password = await bcrypt.hash(data.password, salt);
    return this.usersService.create(data);
  }

  decodeToken(token): any {
    return jwt.verify(token, this.jwtSecret);
  }
}
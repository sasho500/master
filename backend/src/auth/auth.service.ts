import { Injectable } from '@nestjs/common';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class AuthService {
  private users = [{ username: 'test', password: 'test' }]; // Example user, replace with DB access

  async validateUser(credentials): Promise<string> {
    const user = this.users.find(
      (u) =>
        u.username === credentials.username &&
        u.password === credentials.password,
    );
    if (user) {
      return jwt.sign({ username: user.username }, 'secretKey', {
        expiresIn: '1h',
      });
    }
    return null;
  }

  async createUser(data): Promise<any> {
    // Add user creation logic here
    return { id: Date.now(), ...data };
  }

  decodeToken(token): any {
    return jwt.verify(token, 'secretKey');
  }
}

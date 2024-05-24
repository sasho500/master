import {
  Controller,
  Post,
  Get,
  Request,
  Response,
  HttpStatus,
} from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('login')
  async login(@Request() req, @Response() res) {
    const token = await this.authService.validateUser(req.body);
    if (!token) {
      return res
        .status(HttpStatus.UNAUTHORIZED)
        .json({ message: 'Authentication failed' });
    }
    return res.json({ token });
  }

  @Post('register')
  async register(@Request() req, @Response() res) {
    const user = await this.authService.createUser(req.body);
    if (!user) {
      return res
        .status(HttpStatus.BAD_REQUEST)
        .json({ message: 'User could not be created' });
    }
    return res.status(HttpStatus.CREATED).json(user);
  }

  @Get('logout')
  logout(@Request() req, @Response() res) {
    // Implement logout logic, possibly clearing a token or a session
    res.cookie('auth_token', '', {
      httpOnly: true,
      secure: process.env.NODE_ENV !== 'development', // Secure flag in production
      expires: new Date(0), // Set expiration to past date to delete the cookie
    });
    return res.status(200).json({ message: 'Logout successful' });
  }
}

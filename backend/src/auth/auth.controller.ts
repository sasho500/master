import {
  Controller,
  Post,
  Get,
  Request,
  Response,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { Throttle } from '@nestjs/throttler';

@Controller('auth')
export class AuthController {
  private readonly logger = new Logger(AuthController.name);

  constructor(private authService: AuthService) {}

  @Post('login')
  @Throttle({ default: { limit: 1, ttl: 6 } })
  async login(@Request() req, @Response() res) {
    this.logger.log('Login request received'); // Logging without sensitive data

    const token = await this.authService.validateUser(req.body);

    if (!token) {
      this.logger.log('Authentication failed'); // Logging without sensitive data
      return res
        .status(HttpStatus.UNAUTHORIZED)
        .json({ message: 'Authentication failed' });
    }
    this.logger.log('Authentication successful'); // Logging without sensitive data
    res.cookie('auth_token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV !== 'development',
    });
    return res.json({ token });
  }
  
  @Post('register')
  @Throttle({ default: { limit: 5, ttl: 60000 } })
  async register(@Request() req, @Response() res) {
    try {
      const { user, token } = await this.authService.registerAndLogin(req.body);
      res.cookie('auth_token', token, {
        httpOnly: true,
        secure: process.env.NODE_ENV !== 'development',
      });
      return res.status(HttpStatus.CREATED).json({ user, token });
    } catch (error) {
      this.logger.error('User registration failed', error.stack); // Logging error details
      return res
        .status(HttpStatus.BAD_REQUEST)
        .json({ message: 'User could not be created', error: error.message });
    }
  }

  @Get('logout')
  logout(@Request() req, @Response() res) {
    res.cookie('auth_token', '', {
      httpOnly: true,
      secure: process.env.NODE_ENV !== 'development',
      expires: new Date(0), // Set expiration to past date to delete the cookie
    });
    return res.status(200).json({ message: 'Logout successful' });
  }
}
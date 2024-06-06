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
    console.log('Login request body:', req.body); // Log request body

    const token = await this.authService.validateUser(req.body);
    
    if (!token) {
      console.log('Authentication failed'); // Log failure
      return res
        .status(HttpStatus.UNAUTHORIZED)
        .json({ message: 'Authentication failed' });
    }
    console.log('Authentication successful, token:', token); // Log success
    return res.json({ token });
  }
  
  @Post('register')
  async register(@Request() req, @Response() res) {
    try {
      const { user, token } = await this.authService.registerAndLogin(req.body);
      res.cookie('auth_token', token, {
        httpOnly: true,
        secure: process.env.NODE_ENV !== 'development',
      });
      return res.status(HttpStatus.CREATED).json({ user, token });
    } catch (error) {
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
import { Injectable, CanActivate, ExecutionContext, UnauthorizedException, Logger } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AuthService } from '../auth/auth.service';

@Injectable()
export class RolesGuard implements CanActivate {
  private readonly logger = new Logger(RolesGuard.name);
  constructor(private reflector: Reflector, private authService: AuthService) {}

  canActivate(context: ExecutionContext): boolean {
    const roles = this.reflector.get<string[]>('roles', context.getHandler());
    if (!roles) {
      return true;
    }
    const request = context.switchToHttp().getRequest();
    const authHeader = request.headers.authorization;
    this.logger.debug('Authorization header:', authHeader);

    if (!authHeader) {
      this.logger.error('Authorization header not found');
      throw new UnauthorizedException('Authorization header not found');
    }

    const parts = authHeader.split(' ');
    this.logger.debug("head",authHeader);
    if (parts.length !== 2 || parts[0] !== 'Bearer') {
      this.logger.error('Authorization header format is invalid');
      throw new UnauthorizedException('Authorization header format is invalid');
    }

    const token = parts[1];
    this.logger.debug('Extracted token:', token);

    if (!token) {
      this.logger.error('JWT token not found');
      throw new UnauthorizedException('JWT token not found');
    }

    const user = this.authService.decodeToken(token);
    this.logger.debug('Decoded user:', user);

    return roles.some(role => user.role === role);
  }
}
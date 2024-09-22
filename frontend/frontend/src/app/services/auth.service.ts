import { Injectable, Inject, PLATFORM_ID } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { isPlatformBrowser } from '@angular/common';
import { CookieService } from 'ngx-cookie-service';
import { jwtDecode } from 'jwt-decode';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl: string;
  private isBrowser: boolean;

  constructor(
    private http: HttpClient,
    @Inject(PLATFORM_ID) platformId: any,
    private cookieService: CookieService
  ) {
    this.isBrowser = isPlatformBrowser(platformId);

    if (isPlatformBrowser(platformId)) {
      this.apiUrl = `${environment.apiUrl}/auth`; // Client-side
    } else {
      this.apiUrl = `${process.env['API_URL']}/auth`; // Server-side
    }
  }

  login(credentials: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/login`, credentials);
  }

  register(userData: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/register`, userData);
  }

  logout(): void {
    if (this.isBrowser) {
      this.cookieService.delete('authToken', '/');
      alert('You have been logged out.');
    }
  }

  getToken(): string | null {
    if (this.isBrowser) {
      return localStorage.getItem('authToken');
    }
    return null;
  }

  isAuthenticated(): boolean {
    return this.isBrowser ? this.cookieService.check('authToken') : false;
  }

  setToken(token: string) {
    if (this.isBrowser) {
      this.cookieService.set('authToken', token, {
        expires: 50 / (24 * 60), // 50 minutes
        secure: true, // Secure flag for HTTPS
        sameSite: 'Strict', // Prevent CSRF attacks
        path: '/', // Root path
      });
    }
  }

  getCurrentUser(): any {
    if (this.isBrowser) {
      const token = this.cookieService.get('authToken');
      if (token) {
        try {
          const decodedToken: any = jwtDecode(token);
          return decodedToken;
        } catch (error) {
          console.error('Error decoding token', error);
          return null;
        }
      }
    }
    return null;
  }

  isAdmin(): boolean {
    const user = this.getCurrentUser();
    return user && user.role === 'admin';
  }
}

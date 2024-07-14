import { Injectable, Inject, PLATFORM_ID } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { isPlatformBrowser } from '@angular/common';
import { CookieService } from 'ngx-cookie-service';
@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = 'http://localhost:3000/auth';
  private isBrowser: boolean;

  constructor(
    private http: HttpClient,
    @Inject(PLATFORM_ID) platformId: any,
    private cookieService: CookieService
  ) {
    this.isBrowser = isPlatformBrowser(platformId);
  }

  login(credentials: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/login`, credentials);
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
      this.cookieService.set('authToken', token, 20 / (24 * 60)); // 20 minutes
    }
  }

  getCurrentUser(): any {
    return { role: 'user' };
  }
}

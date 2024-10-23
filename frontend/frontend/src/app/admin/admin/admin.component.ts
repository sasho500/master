import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CookieService } from 'ngx-cookie-service';
import { Inject, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-admin',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss'],
})
export class AdminComponent {
  private isBrowser: boolean;
  constructor(
    @Inject(PLATFORM_ID) platformId: any,
    private cookieService: CookieService,
    private router: Router
  ) {
    this.isBrowser = isPlatformBrowser(platformId);
  }
  logout(): void {
    if (this.isBrowser) {
      this.cookieService.delete('authToken', '/');
      this.router.navigate(['/']);
      alert('You have been logged out.');
    }
  }
}

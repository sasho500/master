import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';
@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss',
})
export class LoginComponent {
  credentials = {
    username: '',
    password: '',
  };

  errorMessage: string | null = null;
  failedAttempts: number = 0; // Tracks failed login attempts
  blockedUntil: Date | null = null; // Tracks the time when the user is blocked

  constructor(private authService: AuthService, private router: Router) {}

  // Check for dangerous input before submitting
  isDangerousInput(input: string): boolean {
    const dangerousPatterns =
      /<script>|<\/script>|SELECT|INSERT|UPDATE|DELETE|DROP|--|;|=|\(|\)/gi;
    return dangerousPatterns.test(input);
  }

  isBlocked(): boolean {
    const blockedUntil = localStorage.getItem('blockedUntil');
    if (blockedUntil) {
      const blockEndTime = new Date(blockedUntil);
      const currentTime = new Date();
      if (currentTime < blockEndTime) {
        return true;
      } else {
        // Remove block if time has passed
        localStorage.removeItem('blockedUntil');
        return false;
      }
    }
    return false;
  }
  onSubmit() {
    // Check if the user is blocked
    if (this.isBlocked()) {
      this.errorMessage = 'Too many failed attempts. Try again later.';
      return;
    }

    // Validate input
    if (
      this.isDangerousInput(this.credentials.username) ||
      this.isDangerousInput(this.credentials.password)
    ) {
      this.errorMessage = 'Invalid input.';
      setTimeout(() => {
        this.errorMessage = null;
      }, 6000);
      return;
    }

    // Attempt login
    this.authService.login(this.credentials).subscribe(
      (response) => {
        this.authService.setToken(response.token);
        this.router.navigate(['/']);
      },
      (error: any) => {
        console.log(error);
        this.failedAttempts++;

        if (this.failedAttempts >= 5) {
          // Block user for 30 minutes
          const currentTime = new Date();
          const blockTime = new Date(currentTime.getTime() + 30 * 60000); // 30 minutes
          localStorage.setItem('blockedUntil', blockTime.toISOString());

          this.failedAttempts = 0;
          this.errorMessage =
            'Too many failed attempts. You are blocked for 30 minutes.';
        } else {
          this.errorMessage = `Wrong username or password. ${
            5 - this.failedAttempts
          } attempts remaining.`;
        }

        setTimeout(() => {
          this.errorMessage = null;
        }, 6000);
      }
    );
  }
}

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
  constructor(private authService: AuthService, private router: Router) {}

  // Check for dangerous input before submitting
  isDangerousInput(input: string): boolean {
    const dangerousPatterns =
      /<script>|<\/script>|SELECT|INSERT|UPDATE|DELETE|DROP|--|;|=|\(|\)/gi;
    return dangerousPatterns.test(input);
  }

  onSubmit() {
    if (
      this.isDangerousInput(this.credentials.username) ||
      this.isDangerousInput(this.credentials.password)
    ) {
      console.log('test danger');
      this.errorMessage = 'Wrong username or password';
      setTimeout(() => {
        this.errorMessage = null;
      }, 6000);
      return;
    }

    this.authService.login(this.credentials).subscribe(
      (response) => {
        this.authService.setToken(response.token);
        this.router.navigate(['/']);
      },
      (error: any) => {
        this.errorMessage = 'Wrong username or password';
        setTimeout(() => {
          this.errorMessage = null;
        }, 6000);
      }
    );
  }
}

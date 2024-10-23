import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './register.component.html',
  styleUrl: './register.component.scss',
})
export class RegisterComponent {
  userData = {
    username: '',
    password: '',
    email: '',
    role: 'user',
    profile_picture_url: 'http://example.com/new_profile_picture.jpg',
  };

  errorMessage: string | null = null;

  constructor(private authService: AuthService, private router: Router) {}
  register(registerForm: any) {
    if (registerForm.invalid) {
      this.errorMessage = 'Please correct the errors in the form.';
      return;
    }

    this.authService.register(this.userData).subscribe(
      (response: any) => {
        this.authService
          .login({
            username: this.userData.username,
            password: this.userData.password,
          })
          .subscribe(
            (loginResponse: any) => {
              this.authService.setToken(loginResponse.token);
              this.router.navigate(['/']);
            },
            (loginError: any) => {
              console.error('Login error:', loginError);
              this.errorMessage = 'Login failed. Please try again.';
              setTimeout(() => {
                this.errorMessage = null;
              }, 6000);
            }
          );
      },
      (error: any) => {
        console.error('Registration error:', error);
        this.errorMessage = 'Registration failed. Please try again.';
        setTimeout(() => {
          this.errorMessage = null;
        }, 6000);
      }
    );
  }
}
